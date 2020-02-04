//
//  SubjectView.swift
//  UBSupport
//
//  Created by Usemobile on 25/04/19.
//

import Foundation
import UIKit

class SubjectView: UIView {
    
    // MARK: - UI Components
    
    lazy var lblSubject: UILabel = {
        let label = UILabel()
        label.text = .subject
        self.addSubview(label)
        return label
    }()
    
    lazy var arrowView: DownArrowView = {
        let view = DownArrowView()
        self.addSubview(view)
        return view
    }()
    
    lazy var btnSubject: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(self.btnSubjectPressed), for: .touchUpInside)
        self.addSubview(button)
        return button
    }()
    
    // MARK: - Properties
    
    var subjects: [String] = [.doubt, .suggestion, .commercial, .marketing, .financial]
    
    
    var selectedSubject: String? {
        didSet {
            self.textDidChange?(self.selectedSubject)
            self.setupLblSubject(self.selectedSubject)
        }
    }
    
    var settings: SupportSettings = .default
    var textDidChange: ((String?) -> Void)?
    
    // MARK: - Life Cycle
    
    init(settings: SupportSettings = .default) {
        self.settings = settings
        super.init(frame: .zero)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        self.backgroundColor = .clear
        self.setCorner(15)
        self.layer.borderColor = self.settings.mainColor.cgColor
        self.layer.borderWidth = 1.0
        
        self.lblSubject.anchor(top: nil, left: self.leftAnchor, bottom: nil, right: nil, padding: .init(top: 0, left: 12, bottom: 0, right: 0))
        self.lblSubject.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.arrowView.anchor(top: nil, left: self.lblSubject.rightAnchor, bottom: nil, right: self.rightAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 12), size: .init(width: 22, height: 12))
        self.arrowView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        self.btnSubject.fillSuperview()
        self.setupLblSubject(nil)
    }
    
    func setupLblSubject(_ subject: String?) {
        let supportContactSettings = self.settings.supportContactSettings
        if let text = subject {
            self.lblSubject.font = supportContactSettings.subjectFont
            self.lblSubject.text = text
            self.lblSubject.textColor = supportContactSettings.subjectTextColor
        } else {
            self.lblSubject.font = supportContactSettings.subjectPlaceholderFont
            self.lblSubject.text = .subject
            self.lblSubject.textColor = supportContactSettings.subjectPlaceholderColor
        }
    }
    
    @objc func btnSubjectPressed() {
        self.presentPicker()
    }
    
    func presentPicker() {
        DPPickerManager.shared.showPicker(title: .subject, selected: self.selectedSubject, strings: self.subjects) { (value, index, cancel) in
            if !cancel {
                self.selectedSubject = self.subjects[index]
            }
        }
    }
}
