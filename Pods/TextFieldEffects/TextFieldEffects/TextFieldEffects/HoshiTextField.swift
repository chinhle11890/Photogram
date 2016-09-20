//
//  HoshiTextField.swift
//  TextFieldEffects
//
//  Created by Raúl Riera on 24/01/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit

@IBDesignable open class HoshiTextField: TextFieldEffects {
    
   @IBInspectable open var borderInactiveColor: UIColor? {
        didSet {
            updateBorder()
        }
    }
    @IBInspectable open var borderActiveColor: UIColor? {
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
    
    fileprivate let borderThickness: (active: CGFloat, inactive: CGFloat) = (active: 2, inactive: 0.5)
    fileprivate let placeholderInsets = CGPoint(x: 0, y: 6)
    fileprivate let textFieldInsets = CGPoint(x: 0, y: 12)
    fileprivate let inactiveBorderLayer = CALayer()
    fileprivate let activeBorderLayer = CALayer()
    
    fileprivate var inactivePlaceholderPoint: CGPoint = CGPoint.zero
    fileprivate var activePlaceholderPoint: CGPoint = CGPoint.zero
    
    // MARK: - TextFieldsEffectsProtocol
    
    override func drawViewsForRect(_ rect: CGRect) {
        let frame = CGRect(origin: CGPoint.zero, size: CGSize(width: rect.size.width, height: rect.size.height))
        
        placeholderLabel.frame = frame.insetBy(dx: placeholderInsets.x, dy: placeholderInsets.y)
        placeholderLabel.font = placeholderFontFromFont(self.font!)
        
        updateBorder()
        updatePlaceholder()
        
        layer.addSublayer(inactiveBorderLayer)
        layer.addSublayer(activeBorderLayer)
        addSubview(placeholderLabel)
        
        inactivePlaceholderPoint = placeholderLabel.frame.origin
        activePlaceholderPoint = CGPoint(x: placeholderLabel.frame.origin.x, y: placeholderLabel.frame.origin.y - placeholderLabel.frame.size.height - placeholderInsets.y)
    }
    
    fileprivate func updateBorder() {
        inactiveBorderLayer.frame = rectForBorder(borderThickness.inactive, isFill: true)
        inactiveBorderLayer.backgroundColor = borderInactiveColor?.cgColor
        
        activeBorderLayer.frame = rectForBorder(borderThickness.active, isFill: false)
        activeBorderLayer.backgroundColor = borderActiveColor?.cgColor
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
            return CGRect(origin: CGPoint(x: 0, y: frame.height-thickness), size: CGSize(width: frame.width, height: thickness))
        } else {
            return CGRect(origin: CGPoint(x: 0, y: frame.height-thickness), size: CGSize(width: 0, height: thickness))
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
        placeholderLabel.frame = CGRect(x: originX, y: textRect.height/2,
            width: placeholderLabel.bounds.width, height: placeholderLabel.bounds.height)
    }
    
    override func animateViewsForTextEntry() {
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.beginFromCurrentState, animations: ({ [unowned self] in
            
            if (self.text?.isEmpty)! {
                self.placeholderLabel.frame.origin = CGPoint(x: 10, y: self.placeholderLabel.frame.origin.y)
                self.placeholderLabel.alpha = 0
            }
            }), completion: { [unowned self] (completed) in
                
                self.layoutPlaceholderInTextRect()
                
                self.placeholderLabel.frame.origin = self.activePlaceholderPoint
                
                UIView.animate(withDuration: 0.2, animations: { () -> Void in
                    self.placeholderLabel.alpha = 0.5
                })
            })
        
        self.activeBorderLayer.frame = self.rectForBorder(self.borderThickness.active, isFill: true)
    }
    
    override func animateViewsForTextDisplay() {
        if (text?.isEmpty)! {
            UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2.0, options: UIViewAnimationOptions.beginFromCurrentState, animations: ({ [unowned self] in
                self.layoutPlaceholderInTextRect()
                self.placeholderLabel.alpha = 1
                }), completion: nil)
            
            self.activeBorderLayer.frame = self.rectForBorder(self.borderThickness.active, isFill: false)
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
