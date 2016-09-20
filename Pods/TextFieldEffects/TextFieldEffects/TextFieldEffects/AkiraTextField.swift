//
//  AkiraTextField.swift
//  TextFieldEffects
//
//  Created by Mihaela Miches on 5/31/15.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit

@IBDesignable open class AkiraTextField : TextFieldEffects {
    
    fileprivate let borderSize : (active: CGFloat, inactive: CGFloat) = (1,3)
    fileprivate let borderLayer = CALayer()
    fileprivate let textFieldInsets = CGPoint(x: 6, y: 0)
    fileprivate let placeHolderInsets = CGPoint(x: 6, y: 0)
    
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
        }
    }
    
    override open func drawViewsForRect(_ rect: CGRect) {
        updateBorder()
        updatePlaceholder()
        
        addSubview(placeholderLabel)
        layer.addSublayer(borderLayer)
    }
    
    override func animateViewsForTextEntry() {
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.updateBorder()
            self.updatePlaceholder()
        })
    }
    
    override func animateViewsForTextDisplay() {
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.updateBorder()
            self.updatePlaceholder()
        })
    }
    
    fileprivate func updatePlaceholder()
    {
        placeholderLabel.frame = placeholderRect(forBounds: bounds)
        placeholderLabel.text = placeholder
        placeholderLabel.font = placeholderFontFromFont(self.font!)
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.textAlignment = textAlignment
    }
    
    fileprivate func updateBorder() {
        borderLayer.frame = rectForBounds(bounds)
        borderLayer.borderWidth = (isFirstResponder || !(text?.isEmpty)!) ? borderSize.active : borderSize.inactive
        borderLayer.borderColor = borderColor?.cgColor
    }
    
    fileprivate func placeholderFontFromFont(_ font: UIFont) -> UIFont! {
        let smallerFont = UIFont(name: font.fontName, size: font.pointSize * 0.7)
        return smallerFont
    }
    
    fileprivate var placeholderHeight : CGFloat
    {
        return placeHolderInsets.y + placeholderFontFromFont(self.font!).lineHeight;
    }
    
    fileprivate func rectForBounds(_ bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x, y: bounds.origin.y + placeholderHeight, width: bounds.size.width, height: bounds.size.height - placeholderHeight)
    }
    
    open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        if isFirstResponder || !(text?.isEmpty)! {
            return CGRect(x: placeHolderInsets.x, y: placeHolderInsets.y, width: bounds.width, height: placeholderHeight)
        } else {
            return textRect(forBounds: bounds)
        }
    }
    
    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.offsetBy(dx: textFieldInsets.x, dy: textFieldInsets.y + placeholderHeight/2)
    }
}

