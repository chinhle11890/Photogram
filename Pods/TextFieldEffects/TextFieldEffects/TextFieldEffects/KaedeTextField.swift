//
//  KaedeTextField.swift
//  Swish
//
//  Created by Raúl Riera on 20/01/2015.
//  Copyright (c) 2015 com.raulriera.swishapp. All rights reserved.
//

import UIKit

@IBDesignable open class KaedeTextField: TextFieldEffects {
    
    @IBInspectable open var placeholderColor: UIColor? {
        didSet {
            updatePlaceholder()
        }
    }
    
    @IBInspectable open var foregroundColor: UIColor? {
        didSet {
            updateForegroundColor()
        }
    }
    
    override open var placeholder: String? {
        didSet {
            updatePlaceholder()
        }
    }
    
    override open var bounds: CGRect {
        didSet {
            drawViewsForRect(bounds)
        }
    }
    
    fileprivate let foregroundView = UIView()
    fileprivate let placeholderInsets = CGPoint(x: 10, y: 5)
    fileprivate let textFieldInsets = CGPoint(x: 10, y: 0)
        
    // MARK: - TextFieldsEffectsProtocol

    override func drawViewsForRect(_ rect: CGRect) {
        let frame = CGRect(origin: CGPoint.zero, size: CGSize(width: rect.size.width, height: rect.size.height))
        
        foregroundView.frame = frame
        foregroundView.isUserInteractionEnabled = false
        placeholderLabel.frame = frame.insetBy(dx: placeholderInsets.x, dy: placeholderInsets.y)
        placeholderLabel.font = placeholderFontFromFont(font!)
        
        updateForegroundColor()
        updatePlaceholder()
        
        if !text!.isEmpty || isFirstResponder {
            animateViewsForTextEntry()
        }
        
        addSubview(foregroundView)
        addSubview(placeholderLabel)        
    }
    
    // MARK: -
    
    fileprivate func updateForegroundColor() {
        foregroundView.backgroundColor = foregroundColor
    }
    
    fileprivate func updatePlaceholder() {
        placeholderLabel.text = placeholder
        placeholderLabel.textColor = placeholderColor
    }
    
    fileprivate func placeholderFontFromFont(_ font: UIFont) -> UIFont! {
        let smallerFont = UIFont(name: font.fontName, size: font.pointSize * 0.8)
        return smallerFont
    }
    
    override func animateViewsForTextEntry() {
        UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2.0, options: UIViewAnimationOptions.beginFromCurrentState, animations: ({
            self.placeholderLabel.frame.origin = CGPoint(x: self.frame.size.width * 0.65, y: self.placeholderInsets.y)
        }), completion: nil)
        
        UIView.animate(withDuration: 0.45, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.5, options: UIViewAnimationOptions.beginFromCurrentState, animations: ({
            self.foregroundView.frame.origin = CGPoint(x: self.frame.size.width * 0.6, y: 0)
        }), completion: nil)
    }
    
    override func animateViewsForTextDisplay() {
        if (text?.isEmpty)! {
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2.0, options: UIViewAnimationOptions.beginFromCurrentState, animations: ({
                self.placeholderLabel.frame.origin = self.placeholderInsets
            }), completion: nil)
            
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 2.0, options: UIViewAnimationOptions.beginFromCurrentState, animations: ({
                self.foregroundView.frame.origin = CGPoint.zero
            }), completion: nil)
        }
    }
    
    // MARK: - Overrides
        
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        let frame = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width * 0.6, height: bounds.size.height))
        
        return frame.insetBy(dx: textFieldInsets.x, dy: textFieldInsets.y)
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        let frame = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width * 0.6, height: bounds.size.height))
        
        return frame.insetBy(dx: textFieldInsets.x, dy: textFieldInsets.y)
    }
    
}
