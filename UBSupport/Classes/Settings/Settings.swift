//
//  Settings.swift
//  UBSupport
//
//  Created by Usemobile on 23/04/19.
//

import Foundation

public enum ProfileLanguage: String {
    case en = "en-US"
    case pt = "pt-BR"
    case es = "es-BO"
}

var currentLanguage: ProfileLanguage = .pt

public class SupportSettings {
    
    public var language: ProfileLanguage = .pt {
        didSet {
            currentLanguage = language
        }
    }
    
    public var mainColor: UIColor
    public var buttonTitleColor: UIColor
    public var buttonBackgroundColor: UIColor
    public var buttonDisabledColor: UIColor
    public var closeColor: UIColor
    public var emptyTintColor: UIColor
    
    public var buttonFont: UIFont
    public var emptyFont: UIFont
    
    public var closeImage: UIImage?
    
    public var supportCellSettings: SupportCellSettings
    public var supportDetailsSettings: SupportDetailsSettings
    public var supportContactSettings: SupportContactSettings
    
    public var emptySupportText: Bool = false
    
    public static var `default`: SupportSettings {
        return SupportSettings(mainColor: .orange, buttonBackgroundColor: .orange, buttonDisabledColor: UIColor.orange.withAlphaComponent(0.6), buttonFont: .systemFont(ofSize: 20, weight: .black), emptyFont: .systemFont(ofSize: 14), supportCellSettings: .default, supportDetailsSettings: .default, supportContactDetails: .default)
    }
    
    public init(mainColor: UIColor, buttonTitleColor: UIColor = .white, buttonBackgroundColor: UIColor, closeColor: UIColor = .white, emptyTintColor: UIColor = #colorLiteral(red: 0.7450980392, green: 0.7450980392, blue: 0.7450980392, alpha: 1), buttonDisabledColor: UIColor, buttonFont: UIFont, emptyFont: UIFont, closeImage: UIImage? = nil, supportCellSettings: SupportCellSettings, supportDetailsSettings: SupportDetailsSettings, supportContactDetails: SupportContactSettings, emptySupportText: Bool = false) {
        self.mainColor = mainColor
        self.buttonTitleColor = buttonTitleColor
        self.buttonBackgroundColor = buttonBackgroundColor
        self.buttonDisabledColor = buttonDisabledColor
        self.closeColor = closeColor
        self.emptyTintColor = emptyTintColor
        
        self.buttonFont = buttonFont
        self.emptyFont = emptyFont
        
        self.closeImage = closeImage
        
        self.supportCellSettings = supportCellSettings
        self.supportDetailsSettings = supportDetailsSettings
        self.supportContactSettings = supportContactDetails
        
        self.emptySupportText = emptySupportText
    }
}

public class SupportCellSettings {
    
    public var iconColor: UIColor
    public var textColor: UIColor
    public var arrowColor: UIColor
    public var selectedBackgroundColor: UIColor
    public var selectedTintColor: UIColor
    
    public var textFont: UIFont
    
    public var icon: UIImage?
    
    public static var `default`: SupportCellSettings {
        return SupportCellSettings(selectedBackgroundColor: .orange, textFont: .systemFont(ofSize: 16))
    }
    
    public init(iconColor: UIColor = #colorLiteral(red: 0.7450980392, green: 0.7450980392, blue: 0.7450980392, alpha: 1), textColor: UIColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), arrowColor: UIColor = UIColor.white.withAlphaComponent(0.3), selectedBackgroundColor: UIColor, selectedTintColor: UIColor = .white, textFont: UIFont, icon: UIImage? = nil) {
        self.iconColor = iconColor
        self.textColor = textColor
        self.arrowColor = arrowColor
        self.selectedBackgroundColor = selectedBackgroundColor
        self.selectedTintColor = selectedTintColor
        self.textFont = textFont
        self.icon = icon
    }
}

public class SupportDetailsSettings {
    public var titleColor: UIColor
    public var textColor: UIColor
    public var doubtsColor: UIColor
    public var btnUnselectedColor: UIColor
    public var btnYesColor: UIColor
    public var bntNoColor: UIColor
    
    public var titleFont: UIFont
    public var textFont: UIFont
    public var doubtsFont: UIFont
    public var btnFont: UIFont
    
    public var yesImage: UIImage?
    public var noImage: UIImage?
    
    public static var `default`: SupportDetailsSettings {
        return SupportDetailsSettings(titleFont: .boldSystemFont(ofSize: 28), textFont: .systemFont(ofSize: 14), doubtsFont: .boldSystemFont(ofSize: 16), btnFont: .systemFont(ofSize: 14))
    }
    
    public init(titleColor: UIColor = .black, textColor: UIColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), doubtsColor: UIColor = .black, btnUnselectedColor: UIColor = #colorLiteral(red: 0.7450980392, green: 0.7450980392, blue: 0.7450980392, alpha: 1), btnYesColor: UIColor = #colorLiteral(red: 0.2941176471, green: 0.8509803922, blue: 0.3921568627, alpha: 1), bntNoColor: UIColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1), titleFont: UIFont, textFont: UIFont, doubtsFont: UIFont, btnFont: UIFont, yesImage: UIImage? = nil, noImage: UIImage? = nil) {
        self.titleColor = titleColor
        self.textColor = textColor
        self.doubtsColor = doubtsColor
        self.btnUnselectedColor = btnUnselectedColor
        self.btnYesColor = btnYesColor
        self.bntNoColor = bntNoColor
        
        self.titleFont = titleFont
        self.textFont = textFont
        self.doubtsFont = doubtsFont
        self.btnFont = btnFont
        
        self.yesImage = yesImage
        self.noImage = noImage
    }
}

public class SupportContactSettings {
    public var titleColor: UIColor
    public var subjectTextColor: UIColor
    public var subjectPlaceholderColor: UIColor
    public var commentTextColor: UIColor
    public var commentPlaceholderColor: UIColor
    public var arrowColor: UIColor
    
    public var titleFont: UIFont
    public var subjectFont: UIFont
    public var subjectPlaceholderFont: UIFont
    public var commentFont: UIFont
    public var commentPlaceholderFont: UIFont
    
    public static var `default`: SupportContactSettings {
        return SupportContactSettings(titleFont: .systemFont(ofSize: 14, weight: .semibold), subjectFont: .systemFont(ofSize: 14), subjectPlaceholderFont: .italicSystemFont(ofSize: 14), commentFont: .systemFont(ofSize: 14), commentPlaceholderFont: .italicSystemFont(ofSize: 14))
    }
    
    public init(titleColor: UIColor = .black, subjectTextColor: UIColor = .black, subjectPlaceholderColor: UIColor = #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1), commentTextColor: UIColor = .black, commentPlaceholderColor: UIColor = #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1), arrowColor: UIColor = .black, titleFont: UIFont, subjectFont: UIFont, subjectPlaceholderFont: UIFont, commentFont: UIFont, commentPlaceholderFont: UIFont) {
        self.titleColor = titleColor
        self.subjectTextColor = subjectTextColor
        self.subjectPlaceholderColor = subjectPlaceholderColor
        self.commentTextColor = commentTextColor
        self.commentPlaceholderColor = commentPlaceholderColor
        self.arrowColor = arrowColor
        
        self.titleFont = titleFont
        self.subjectFont = subjectFont
        self.subjectPlaceholderFont = subjectPlaceholderFont
        self.commentFont = commentFont
        self.commentPlaceholderFont = commentPlaceholderFont
    }
}
