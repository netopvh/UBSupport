//
//  SupportCellView.swift
//  UBSupport
//
//  Created by Usemobile on 23/04/19.
//

import Foundation

class SupportCellView: UIView {
    
    // MARK: - UI Components
    
    lazy var cornerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        self.addSubview(view)
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage.getFrom(customClass: SupportCellView.self, nameResource: "support")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = #colorLiteral(red: 0.7450980392, green: 0.7450980392, blue: 0.7450980392, alpha: 1)
        self.cornerView.addSubview(imageView)
        return imageView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        self.cornerView.addSubview(label)
        return label
    }()
    
    lazy var arrowView: ArrowView = {
        let view = ArrowView()
        self.cornerView.addSubview(view)
        return view
    }()
    
    // MARK: - Properties
    
    var settings: SupportCellSettings = .default {
        didSet {
            self.setupSettings()
        }
    }
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        self.backgroundColor = .clear
        self.cornerView.fillSuperview()
        self.applyLightShadowToCircle()
        self.cornerView.setCorner(16)
        
        self.imageView.anchor(top: nil, left: self.cornerView.leftAnchor, bottom: nil, right: nil, padding: .init(top: 0, left: 16, bottom: 0, right: 0), size: .init(width: 34, height: 34))
        self.imageView.centerYAnchor.constraint(equalTo: self.cornerView.centerYAnchor).isActive = true
        
        self.label.anchor(top: self.cornerView.topAnchor, left: self.imageView.rightAnchor, bottom: self.cornerView.bottomAnchor, right: nil, padding: .init(top: 16, left: 12, bottom: 16, right: 0))
        self.label.heightAnchor.constraint(greaterThanOrEqualToConstant: 38).isActive = true
        
        self.arrowView.anchor(top: nil, left: self.label.rightAnchor, bottom: nil, right: self.cornerView.rightAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 12), size: .init(width: 15, height: 22))
        self.arrowView.centerYAnchor.constraint(equalTo: self.cornerView.centerYAnchor).isActive = true
    }
    
    private func setupSettings() {
        self.label.textColor = self.settings.textColor
        self.label.font = self.settings.textFont 
        
        self.imageView.image = self.settings.icon ?? UIImage.getFrom(customClass: SupportCellView.self, nameResource: "support")?.withRenderingMode(.alwaysTemplate)
        self.imageView.tintColor = self.settings.iconColor
        
        self.arrowView.color = self.settings.arrowColor
    }
    
    func setSelected(_ selected: Bool) {
        self.cornerView.backgroundColor = selected ? self.settings.selectedBackgroundColor : .white
        self.imageView.tintColor = selected ? self.settings.selectedTintColor : self.settings.iconColor
        self.label.textColor = selected ? self.settings.selectedTintColor : self.settings.textColor
        self.arrowView.color = selected ? self.settings.selectedTintColor : self.settings.arrowColor
    }
}
