//
//  CustomButton.swift
//  UBProfile
//
//  Created by Usemobile on 03/04/19.
//

import Foundation

import TransitionButton

class CustomButton: TransitionButton {
    
    // MARK: - Properties
    
    var settings: SupportSettings = .default {
        didSet {
            self.enabledBackgroundColor = self.settings.buttonBackgroundColor
            self.disabledBackgroundColor = self.settings.buttonDisabledColor
            self.setTitleColor(self.settings.buttonTitleColor, for: .normal)
            self.titleLabel?.font = self.settings.buttonFont
        }
    }
    
    var enabledBackgroundColor: UIColor = .orange {
        didSet {
            self.backgroundColor = self.isEnabled ? self.enabledBackgroundColor : self.disabledBackgroundColor
        }
    }
    
    override var isUserInteractionEnabled: Bool {
        didSet {
            self.backgroundColor = self.isUserInteractionEnabled ? self.enabledBackgroundColor : self.disabledBackgroundColor
        }
    }
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup
    
    fileprivate func setup() {
        self.backgroundColor = self.enabledBackgroundColor
        self.setTitleColor(UIColor.black.withAlphaComponent(0.5), for: UIControl.State.highlighted)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .black)
    }
    
}

