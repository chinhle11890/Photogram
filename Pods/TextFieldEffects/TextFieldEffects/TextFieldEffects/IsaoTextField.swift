//
//  IsaoTextField.swift
//  TextFieldEffects
//
//  Created by Raúl Riera on 29/01/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit

@IBDesignable open class IsaoTextField: TextFieldEffects {
    
    @IBInspectable open var inactiveColor: UIColor? {
        didSet {
            updateBorder()
        }
    }
    @IBInspectable open var activeColor: UIColor? {
        didSet {
            updateBorder()
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
    
    fileprivate let borderThickness: (active: CGFloat, inactive: CGFloat) = (4, 2)
    fileprivate let placeholderInsets = CGPoint(x: 6, y: 6)
    fileprivate let textFieldInsets = CGPoint(x: 6, y: 6)
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
        borderLayer.frame = rectForBorder(frame)
        borderLayer.backgroundColor = isFirstResponder ? activeColor?.cgColor : inactiveColor?.cgColor
    }
    
    fileprivate func updatePlaceholder() {
        placeholderLabel.text = placeholder
        placeholderLabel.textColor = inactiveColor
        placeholderLabel.sizeToFit()
        layoutPlaceholderInTextRect()
        
        if isFirstResponder {
            animateViewsForTextEntry()
        }
    }
    
    fileprivate func placeholderFontFromFont(_ font: UIFont) -> UIFont! {
        let smallerFont = UIFont(name: font.fontName, size: font.pointSize * 0.7)
        return smallerFont
    }
    
    fileprivate func rectForBorder(_ bounds: CGRect) -> CGRect {
        var newRect:CGRect
        
        if isFirstResponder {
            newRect = CGRect(x: 0, y: bounds.size.height - (font?.lineHeight)! + textFieldInsets.y - borderThickness.active, width: bounds.size.width, height: borderThickness.active)
        } else {
            newRect = CGRect(x: 0, y: bounds.size.height - (font?.lineHeight)! + textFieldInsets.y - borderThickness.inactive, width: bounds.size.width, height: borderThickness.inactive)
        }
        
        return newRect
    }
    
    fileprivate func layoutPlaceholderInTextRect() {
        
        if !(text?.isEmpty)! {
            return
        }
        
        let textRect = self.textRect(forBounds: bounds)
        var originX = textRect.origin.x
        switch textAlignment {
        case .center:
            originX += textRect.size.width/2 - placeholderLabel.bounds.width/2
        case .right:
            originX += textRect.size.width - placeholderLabel.bounds.width
        default:
            break
        }
        placeholderLabel.frame = CGRect(x: originX, y: bounds.height - placeholderLabel.frame.height,
            width: placeholderLabel.frame.size.width, height: placeholderLabel.frame.size.height)
    }
    
    override func animateViewsForTextEntry() {
        updateBorder()
        if let activeColor = activeColor {
            performPlacerholderAnimationWithColor(activeColor)
        }
    }
    
    override func animateViewsForTextDisplay() {
        updateBorder()
        if let inactiveColor = inactiveColor {
            performPlacerholderAnimationWithColor(inactiveColor)
        }
    }
    
    fileprivate func performPlacerholderAnimationWithColor(_ color: UIColor) {
        
        let yOffset:CGFloat = 4
        
        UIView.animate(withDuration: 0.15, animations: { () -> Void in
            self.placeholderLabel.transform = CGAffineTransform(translationX: 0, y: -yOffset)
            self.placeholderLabel.alpha = 0
            }, completion: { (completed) -> Void in
                
                self.placeholderLabel.transform = CGAffineTransform.identity
                self.placeholderLabel.transform = CGAffineTransform(translationX: 0, y: yOffset)
                
                UIView.animate(withDuration: 0.15, animations: {
                    self.placeholderLabel.textColor = color
                    self.placeholderLabel.transform = CGAffineTransform.identity
                    self.placeholderLabel.alpha = 1
                })
        }) 
    }
    
    // MARK: - Overrides
        
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        let newBounds = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height - (font?.lineHeight)! + textFieldInsets.y)
        return newBounds.insetBy(dx: textFieldInsets.x, dy: 0)
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        let newBounds = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height - (font?.lineHeight)! + textFieldInsets.y)
        
        return newBounds.insetBy(dx: textFieldInsets.x, dy: 0)
    }
    
}
