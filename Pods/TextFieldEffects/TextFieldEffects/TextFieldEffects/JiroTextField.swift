//
//  JiroTextField.swift
//  TextFieldEffects
//
//  Created by Raúl Riera on 24/01/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit

@IBDesignable open class JiroTextField: TextFieldEffects {
    
    @IBInspectable open var borderColor: UIColor? {
        didSet {
            updateBorder()
        }
    }
    @IBInspectable open var placeholderColor: UIColor? {
        didSet {
            updatePlaceholder()
        }
    }
    
    override open var placeholder: String? {
        didSet {
            updatePlaceholder()
        }
    }
    
    override open var bounds: CGRect {
        didSet {
            updateBorder()
            updatePlaceholder()
        }
    }
    
    fileprivate let borderThickness: CGFloat = 2
    fileprivate let placeholderInsets = CGPoint(x: 8, y: 8)
    fileprivate let textFieldInsets = CGPoint(x:8, y:12)
    fileprivate let borderLayer = CALayer()
    
    // MARK: - TextFieldsEffectsProtocol
    
    override func drawViewsForRect(_ rect: CGRect) {
        let frame = CGRect(origin: CGPoint.zero, size: CGSize(width: rect.size.width, height: rect.size.height))
        
        placeholderLabel.frame = frame.insetBy(dx: placeholderInsets.x, dy: placeholderInsets.y)
        placeholderLabel.font = placeholderFontFromFont(font!)
        
        updateBorder()
        updatePlaceholder()
        
        layer.addSublayer(borderLayer)
        addSubview(placeholderLabel)        
    }
    
    fileprivate func updateBorder() {
        borderLayer.frame = rectForBorder(borderThickness, isFill: false)
        borderLayer.backgroundColor = borderColor?.cgColor
    }
    
    fileprivate func updatePlaceholder() {
        placeholderLabel.text = placeholder
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.sizeToFit()
        layoutPlaceholderInTextRect()
        
        if isFirstResponder || !(text?.isEmpty)! {
            animateViewsForTextEntry()
        }
    }
    
    fileprivate func placeholderFontFromFont(_ font: UIFont) -> UIFont! {
        let smallerFont = UIFont(name: font.fontName, size: font.pointSize * 0.65)
        return smallerFont
    }
    
    fileprivate func rectForBorder(_ thickness: CGFloat, isFill: Bool) -> CGRect {
        if isFill {
            return CGRect(origin: CGPoint(x: 0, y: placeholderLabel.frame.origin.y + placeholderLabel.font.lineHeight), size: CGSize(width: frame.width, height: frame.height))
        } else {
            return CGRect(origin: CGPoint(x: 0, y: frame.height-thickness), size: CGSize(width: frame.width, height: thickness))
        }
    }
    
    fileprivate func layoutPlaceholderInTextRect() {
        
        if !(text?.isEmpty)! {
            return
        }
        
        let textRect = self.textRect(forBounds: bounds)
        var originX = textRect.origin.x
        switch self.textAlignment {
        case .center:
            originX += textRect.size.width/2 - placeholderLabel.bounds.width/2
        case .right:
            originX += textRect.size.width - placeholderLabel.bounds.width
        default:
            break
        }
        placeholderLabel.frame = CGRect(x: originX, y: textRect.size.height/2,
            width: placeholderLabel.frame.size.width, height: placeholderLabel.frame.size.height)
    }
    
    override func animateViewsForTextEntry() {
        borderLayer.frame.origin = CGPoint(x: 0, y: (font?.lineHeight)!)
        
        UIView.animate(withDuration: 0.2, delay: 0.3, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.beginFromCurrentState, animations: ({
            
            self.placeholderLabel.frame.origin = CGPoint(x: self.placeholderInsets.x, y: self.borderLayer.frame.origin.y - self.placeholderLabel.bounds.height)
            self.borderLayer.frame = self.rectForBorder(self.borderThickness, isFill: true)
            
        }), completion:nil)
    }
    
    override func animateViewsForTextDisplay() {
        if (text?.isEmpty)! {
            UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2.0, options: UIViewAnimationOptions.beginFromCurrentState, animations: ({
                self.layoutPlaceholderInTextRect()
                self.placeholderLabel.alpha = 1
            }), completion: nil)
            
            borderLayer.frame = rectForBorder(borderThickness, isFill: false)
        }
    }
    
    // MARK: - Overrides
            
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.offsetBy(dx: textFieldInsets.x, dy: textFieldInsets.y)
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.offsetBy(dx: textFieldInsets.x, dy: textFieldInsets.y)
    }

}
