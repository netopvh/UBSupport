//
//  Extensions.swift
//  UBSupport
//
//  Created by Usemobile on 23/04/19.
//

import Foundation
import UIKit

extension UIImage {
    
    class func getFrom(customClass: AnyClass, nameResource: String) -> UIImage? {
        let frameWorkBundle = Bundle(for: customClass)
        if let bundleURL = frameWorkBundle.resourceURL?.appendingPathComponent("UBSupport.bundle"), let resourceBundle = Bundle(url: bundleURL) {
            return UIImage(named: nameResource, in: resourceBundle, compatibleWith: nil)
        }
        return nil
    }
}

extension UIView {
    
    func applyLightShadowToCircle() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 3
    }
    
    func applyCircle() {
        self.setCorner(self.bounds.height/2)
    }
    
    func setCorner(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    func fillSuperview(padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        self.anchor(top: self.superview?.topAnchor, left: self.superview?.leftAnchor, bottom: self.superview?.bottomAnchor, right: self.superview?.rightAnchor, padding: padding, size: size)
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
            
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: padding.left).isActive = true
            
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -padding.right).isActive = true
            
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
            
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
    }
}


extension UIViewController {
    
    static var top: UIViewController? {
        get {
            return topViewController()
        }
    }
    
    static var root: UIViewController? {
        get {
            return UIApplication.shared.delegate?.window??.rootViewController
        }
    }
    
    static func topViewController(from viewController: UIViewController? = UIViewController.root) -> UIViewController? {
        if let tabBarViewController = viewController as? UITabBarController {
            return topViewController(from: tabBarViewController.selectedViewController)
        } else if let navigationController = viewController as? UINavigationController {
            return topViewController(from: navigationController.visibleViewController)
        } else if let presentedViewController = viewController?.presentedViewController {
            return topViewController(from: presentedViewController)
        } else {
            return viewController
        }
    }
}
