//
//  CommentView.swift
//  UBSupport
//
//  Created by Usemobile on 06/05/19.
//

import UIKit

protocol CommentViewDelegate: class {
    func textViewShouldReturn(_ view: CommentView, text: String)
}

class CommentView: UIView {
    
    // MARK: - UI Components
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.text = .comment
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.textColor = .black
        textView.delegate = self
        self.addSubview(textView)
        return textView
    }()
    
    // MARK: - Properties
    
    weak var delegate: CommentViewDelegate?
    
    var text = "" {
        didSet {
            self.textDidChange?(self.text)
        }
    }
    
    var defaultText = "" {
        didSet {
            self.setupTextView(self.text)
        }
    }
    
    var placeholder: String = .comment {
        didSet {
            self.setupTextView(self.text)
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
        self.setCorner(20)
        self.layer.borderColor = self.settings.mainColor.cgColor
        self.layer.borderWidth = 1.0
        
        self.textView.fillSuperview(padding: .init(top: 4, left: 10, bottom: 4, right: 10))
        
        self.setupTextView()
    }
    
    private func setupTextView(_ text: String = "") {
        let supportContactSettings = self.settings.supportContactSettings
        if text.isEmpty {
            self.text = ""
            self.textView.text = self.placeholder
            self.textView.textColor = supportContactSettings.commentPlaceholderColor
            self.textView.font = supportContactSettings.commentPlaceholderFont
        } else {
            self.text = self.textView.text ?? ""
            self.textView.textColor = supportContactSettings.commentTextColor
            self.textView.font = supportContactSettings.commentFont
        }
    }

}

// MARK: - TextView Delegate

extension CommentView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        let supportContactSettings = self.settings.supportContactSettings
        if textView.textColor == supportContactSettings.commentPlaceholderColor {
            textView.font = supportContactSettings.commentFont
            textView.text = nil
            textView.textColor = supportContactSettings.commentTextColor
            self.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.setupTextView(textView.text ?? "")
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            self.delegate?.textViewShouldReturn(self, text: textView.text ?? "")
        }
        return true
    }
}

