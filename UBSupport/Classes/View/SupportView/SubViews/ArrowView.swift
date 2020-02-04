//
//  ArrowView.swift
//  UBProfile
//
//  Created by Usemobile on 03/04/19.
//

import Foundation

class ArrowView: UIView {
    
    // MARK: - UI/CA Components
    
    var path: UIBezierPath!
    var sublayer = CAShapeLayer()
    
    // MARK: - Properties
    
    var color: UIColor = #colorLiteral(red: 0.6470588235, green: 0.6470588235, blue: 0.6470588235, alpha: 1) {
        didSet {
            self.sublayer.fillColor = self.color.cgColor
        }
    }
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        self.createArrow()
    }
    
    // MARK: - Setup
    
    func createArrow() {
        let arrowWidth: CGFloat = 1.75
        path = UIBezierPath()
        
        path.move(to: .init(x: arrowWidth, y: 0))
        path.addLine(to: .init(x: self.frame.size.width - 2 * arrowWidth, y: self.frame.size.height/2))
        path.addLine(to: .init(x: arrowWidth, y: self.frame.height))
        path.addLine(to: .init(x: 0, y: self.frame.height-arrowWidth))
        path.addLine(to: .init(x: self.frame.width-4*arrowWidth, y: self.frame.height/2))
        path.addLine(to: .init(x: 0, y: arrowWidth))
        
        path.close()
        let layer = CAShapeLayer()
        layer.path = self.path.cgPath
        layer.fillColor = self.color.cgColor
        
        self.layer.addSublayer(layer)
        self.sublayer = layer
    }
    
}

class DownArrowView: UIView {
    
    var path: UIBezierPath!
    var sublayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        self.createArrow()
    }
    
    var color: UIColor = .black {
        didSet {
            self.sublayer.fillColor = self.color.cgColor
        }
    }
    
    func createArrow() {
        let arrowWidth: CGFloat = 1.75
        path = UIBezierPath()
        
        path.move(to: .init(x: 0, y: arrowWidth))
        path.addLine(to: .init(x: self.frame.size.width/2, y: self.frame.size.height))
        path.addLine(to: .init(x: self.frame.width, y: arrowWidth))
        path.addLine(to: .init(x: self.frame.width-arrowWidth, y: 0))
        path.addLine(to: .init(x: self.frame.width/2, y: self.frame.height-2*arrowWidth))
        path.addLine(to: .init(x: arrowWidth, y: 0))
        
        path.close()
        let layer = CAShapeLayer()
        layer.path = self.path.cgPath
        layer.fillColor = self.color.cgColor
        
        self.layer.addSublayer(layer)
        self.sublayer = layer
    }
    
}

