//
//  ContactView.swift
//  UBSupport
//
//  Created by Usemobile on 25/04/19.
//

import Foundation
import UIKit
import TPKeyboardAvoiding

protocol ContactViewDelegate: class {
    func sendPressed(_ view: ContactView, subject: String, message: String)
}

class ContactView: UIView {
    
    // MARK: - UI Components
    
    lazy var scrollView: TPKeyboardAvoidingScrollView = {
        let scrollView = TPKeyboardAvoidingScrollView()
        self.addSubview(scrollView)
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        self.scrollView.addSubview(view)
        return view
    }()
    
    lazy var lblTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = self.settings.emptySupportText ? nil : .contact(email: self.model.email, phone: self.model.phone)
        label.textAlignment = .center
        self.contentView.addSubview(label)
        return label
    }()
    
    lazy var subjectView: SubjectView = {
        let view = SubjectView(settings: self.settings)
        view.textDidChange = { [weak self](text: String?) in
            guard let strongSelf = self else { return }
            strongSelf.subject = text ?? ""
        }
        if let subjects = self.model.subjects {
            view.subjects = subjects
        }
        self.contentView.addSubview(view)
        return view
    }()
    
    lazy var commentView: CommentView = {
        let view = CommentView(settings: self.settings)
        view.textDidChange = { [weak self](text: String?) in
            guard let strongSelf = self else { return }
            strongSelf.comment = text ?? ""
        }
        view.delegate = self
        self.contentView.addSubview(view)
        return view
    }()
    
    lazy var btnSend: CustomButton = {
        let button = CustomButton()
        button.settings = self.settings
        button.setTitle(.send, for: .normal)
        button.cornerRadius = 27.5
        button.isUserInteractionEnabled = false
        button.addTarget(self, action: #selector(self.sendPressed), for: .touchUpInside)
        self.contentView.addSubview(button)
        return button
    }()
    
    // MARK: - Properties
    
    weak var delegate: ContactViewDelegate?
    var model: SupportModel
    var settings: SupportSettings {
        didSet {
            self.lblTitle.text = self.settings.emptySupportText ? nil : .contact(email: self.model.email, phone: self.model.phone)
            self.cnstSubjectTopSuperView.priority = UILayoutPriority(self.settings.emptySupportText ? 999 : 250)
        }
    }
    
    var subject = "" {
        didSet {
            self.checkBtnState()
        }
    }
    var comment = "" {
        didSet {
            self.checkBtnState()
        }
    }
    
    private var cnstSubjectTopSuperView = NSLayoutConstraint()
    
    // MARK: - Life Cycle
    
    init(model: SupportModel, settings: SupportSettings = .default) {
        self.model = model
        self.settings = settings
        super.init(frame: .zero)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.model = SupportModel(email: "", phone: "")
        self.settings = .default
        super.init(coder: aDecoder)
        self.setup()
    }
    
    // MARK: - Setups
    
    private func setup() {
        self.backgroundColor = .white
        self.setupSrollView()
        self.setupContentView()
        self.setupSettings()
        self.btnSend.isUserInteractionEnabled = false
    }
    
    fileprivate func setupSrollView() {
        if #available(iOS 11, *) {
            self.scrollView.anchor(top: self.safeAreaLayoutGuide.topAnchor, left: self.leftAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, right: self.rightAnchor)
        } else {
            self.scrollView.fillSuperview()
        }
        self.contentView.fillSuperview()
        self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor).isActive = true
        self.contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        let contentHeight = self.contentView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor)
        contentHeight.priority = .defaultLow
        contentHeight.isActive = true
    }
    
    fileprivate func setupContentView() {
        let subjectTopTitle = self.subjectView.topAnchor.constraint(equalTo: self.lblTitle.bottomAnchor, constant: 24)
        subjectTopTitle.priority = UILayoutPriority(750)
        subjectTopTitle.isActive = true
        self.cnstSubjectTopSuperView = self.subjectView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 24)
        self.cnstSubjectTopSuperView.priority = UILayoutPriority(self.settings.emptySupportText ? 999 : 250)
        self.cnstSubjectTopSuperView.isActive = true
        self.lblTitle.anchor(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, bottom: nil, right: self.contentView.rightAnchor, padding: .init(top: 30, left: 20, bottom: 0, right: 20))
        self.subjectView.anchor(top: nil, left: self.lblTitle.leftAnchor, bottom: nil, right: self.lblTitle.rightAnchor, padding: .init(top: 24, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 52))
        self.commentView.anchor(top: self.subjectView.bottomAnchor, left: self.subjectView.leftAnchor, bottom: nil, right: self.subjectView.rightAnchor, padding: .init(top: 20, left: 0, bottom: 20, right: 0))
        self.btnSend.anchor(top: self.commentView.bottomAnchor, left: self.commentView.leftAnchor, bottom: self.contentView.bottomAnchor, right: self.commentView.rightAnchor, padding: .init(top: 20, left: 6, bottom: 22, right: 6), size: .init(width: 0, height: 55))
    }
    
    fileprivate func setupSettings() {
        let supportContactSettings = self.settings.supportContactSettings
        self.lblTitle.textColor = supportContactSettings.titleColor
        self.lblTitle.font = supportContactSettings.titleFont
        
    }
    
    func checkBtnState() {
        self.btnSend.isUserInteractionEnabled = !self.subject.isEmpty && !self.comment.isEmpty
    }
    
    @objc func sendPressed() {
        self.endEditing(false)
        DispatchQueue.main.async {
        self.delegate?.sendPressed(self, subject: self.subject, message: self.comment)
        }
    }
}

extension ContactView: CommentViewDelegate {
    func textViewShouldReturn(_ view: CommentView, text: String) {
        if self.btnSend.isUserInteractionEnabled {
            self.sendPressed()
        } else {
            self.endEditing(false)
        }
    }
}
