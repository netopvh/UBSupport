//
//  SupportDetailsView.swift
//  UBSupport
//
//  Created by Usemobile on 23/04/19.
//

import Foundation
import UIKit

protocol SupportDetailsViewDelegate: class {
    func didVoteUseful(_ view: SupportDetailsView, useful: Bool)
}

class SupportDetailsView: UIView {
    
    // MARK: - UI Components
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        self.addSubview(view)
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        self.scrollView.addSubview(view)
        return view
    }()
    
    lazy var lblTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 28)
        self.contentView.addSubview(label)
        return label
    }()
    
    lazy var lblText: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        self.contentView.addSubview(label)
        return label
    }()
    
    lazy var lblDoubts: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = .doubts
        self.contentView.addSubview(label)
        return label
    }()
    
    lazy var voteView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        self.contentView.addSubview(view)
        return view
    }()
    
    lazy var btnYes: VoteButton = {
        let button = VoteButton(type: .yes, voted: false, settings: self.settings)
        button.addTarget(self, action: #selector(self.btnVotePressed(_:)), for: .touchUpInside)
        self.voteView.addSubview(button)
        return button
    }()
    
    lazy var btnNo: VoteButton = {
        let button = VoteButton(type: .no, voted: false, settings: self.settings)
        button.addTarget(self, action: #selector(self.btnVotePressed(_:)), for: .touchUpInside)
        self.voteView.addSubview(button)
        return button
    }()
    
    // MARK: - Properties
    
    weak var delegate: SupportDetailsViewDelegate?
    var model: SupportCellViewModel
    var settings: SupportDetailsSettings = .default
    
    // MARK: - Life Cycle
    
    init(model: SupportCellViewModel, settings: SupportDetailsSettings = .default) {
        self.model = model
        self.settings = settings
        super.init(frame: .zero)
        self.setup()
        self.setupSettings()
        self.setupModel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setup() {
        self.backgroundColor = .white
        
        self.scrollView.fillSuperview()
        self.contentView.fillSuperview()
        let heightAnchor =  self.contentView.heightAnchor.constraint(equalTo: self.heightAnchor)
        heightAnchor.priority = .defaultLow
        heightAnchor.isActive = true
        self.contentView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        
        self.lblTitle.anchor(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, bottom: nil, right: self.contentView.rightAnchor, padding: .init(top: 24, left: 16, bottom: 0, right: 16))
        self.lblText.anchor(top: self.lblTitle.bottomAnchor, left: self.lblTitle.leftAnchor, bottom: nil, right: self.lblTitle.rightAnchor, padding: .init(top: 30, left: 0, bottom: 0, right: 0))
        self.lblDoubts.anchor(top: self.lblText.bottomAnchor, left: self.lblText.leftAnchor, bottom: nil, right: self.lblText.rightAnchor, padding: .init(top: 30, left: 9, bottom: 0, right: 9))
        
        self.voteView.anchor(top: self.lblDoubts.bottomAnchor, left: nil, bottom: self.contentView.bottomAnchor, right: nil, padding: .init(top: 30, left: 0, bottom: 24, right: 0))
        self.voteView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        
        let voteBtnSize: CGSize = .init(width: 48, height: 72)
        self.btnYes.anchor(top: self.voteView.topAnchor, left: self.voteView.leftAnchor, bottom: self.voteView.bottomAnchor, right: nil, size: voteBtnSize)
        self.btnNo.anchor(top: self.voteView.topAnchor, left: self.btnYes.rightAnchor, bottom: self.voteView.bottomAnchor, right: self.voteView.rightAnchor, padding: .init(top: 0, left: voteBtnSize.height, bottom: 0, right: 0), size: voteBtnSize)
        
    }
    
    private func setupSettings() {
        self.lblTitle.textColor = self.settings.titleColor
        self.lblTitle.font = self.settings.titleFont
        
        self.lblText.textColor = self.settings.textColor
        self.lblText.font = self.settings.textFont
        
        self.lblDoubts.textColor = self.settings.doubtsColor
        self.lblDoubts.font = self.settings.doubtsFont
    }
    
    private func setupModel() {
        self.lblTitle.text = self.model.title
        self.lblText.text = self.model.message
        
        let voted = self.model.voted
        switch voted {
        case 1, 2:
            self.btnYes.isEnabled = false
            self.btnNo.isEnabled = false
            self.btnYes.voted = voted == 1
            self.btnNo.voted = voted == 2
        default:
            self.btnYes.isEnabled = true
            self.btnNo.isEnabled = true
        }
    }
    
    // MARK: - Objc Func
    
    @objc func btnVotePressed(_ sender: VoteButton) {
        self.btnYes.isEnabled = false
        self.btnNo.isEnabled = false
        sender.voted = true
        self.model.voted = sender == self.btnYes ? 1 : 2
        self.delegate?.didVoteUseful(self, useful: sender == self.btnYes)
    }
    
}

