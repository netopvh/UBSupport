//
//  VoteButton.swift
//  TransitionButton
//
//  Created by Usemobile on 23/04/19.
//

import Foundation
import UIKit

class VoteButton: UIButton {
    
    // MARK: - Properties
    
    enum `Type`: String {
        case yes
        case no
    }
    
    var type: Type = .yes
    var voted: Bool = false {
        didSet {
            self.setupColors()
        }
    }
    
    var settings: SupportDetailsSettings = .default
    
    // MARK: - Life Cycle
    
    init(type: Type, voted: Bool, settings: SupportDetailsSettings = .default) {
        self.type = type
        self.voted = voted
        self.settings = settings
        super.init(frame: .zero)
        self.setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override func backgroundRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height - 24)
    }
    
    // MARK: - Setup
    
    fileprivate func setupColors() {
        let color: UIColor = self.voted ? (self.type == .yes ? self.settings.btnYesColor : self.settings.bntNoColor) : self.settings.btnUnselectedColor
        self.tintColor = color
        self.setTitleColor(color, for: .normal)
    }
    
    private func setup() {
        let image: UIImage? = self.type == .yes ? self.settings.yesImage : self.settings.noImage
        self.setBackgroundImage(image ?? UIImage.getFrom(customClass: VoteButton.self, nameResource: self.type.rawValue)?.withRenderingMode(.alwaysTemplate), for: .normal)
        let title: String = self.type == .yes ? .yes : .no
        self.setTitle(title, for: .normal)
        self.setupColors()
        
        self.titleLabel?.font = self.settings.btnFont
        
        self.titleEdgeInsets = .init(top: 48, left: 0, bottom: 0, right: 0)
    }
    
}
