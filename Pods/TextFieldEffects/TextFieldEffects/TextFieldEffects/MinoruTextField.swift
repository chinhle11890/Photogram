//
//  MinoruTextField.swift
//  TextFieldEffects
//
//  Created by Raúl Riera on 27/01/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit

@IBDesignable open class MinoruTextField: TextFieldEffects {
    
    @IBInspectable open var placeholderColor: UIColor? {
        didSet {
            updatePlaceholder()
        }
    }
    
    override open var backgroundColor: UIColor? {
        set {
            backgroundLayerColor = newValue!
        }
        get {
            return backgroundLayerColor
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
    
    fileprivate let borderThickness: CGFloat = 1
    fileprivate let placeholderInsets = CGPoint(x: 6, y: 6)
    fileprivate let textFieldInsets = CGPoint(x: 6, y: 6)
    fileprivate let borderLayer = CALayer()
    fileprivate var backgroundLayerColor: UIColor?    
    
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
        borderLayer.backgroundColor = backgroundColor?.cgColor
    }
    
    fileprivate func updatePlaceholder() {
        placeholderLabel.text = placeholder
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.sizeToFit()
        layoutPlaceholderInTextRect()
        
        if isFirstResponder {
            animateViewsForTextEntry()
        }
    }
    
    fileprivate func placeholderFontFromFont(_ font: UIFont) -> UIFont! {
        let smallerFont = UIFont(name: font.fontName, size: font.pointSize * 0.65)
        return smallerFont
    }
    
    fileprivate func rectForBorder(_ bounds: CGRect) -> CGRect {
        let newRect = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height - (font?.lineHeight)! + textFieldInsets.y)
        
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
        borderLayer.borderColor = textColor?.cgColor
        borderLayer.shadowOffset = CGSize.zero
        borderLayer.borderWidth = borderThickness
        borderLayer.shadowColor = textColor?.cgColor
        borderLayer.shadowOpacity = 0.5
        borderLayer.shadowRadius = 1
    }
    
    override func animateViewsForTextDisplay() {
        borderLayer.borderColor = nil
        borderLayer.shadowOffset = CGSize.zero
        borderLayer.borderWidth = 0
        borderLayer.shadowColor = nil
        borderLayer.shadowOpacity = 0
        borderLayer.shadowRadius = 0
    }
    
    // MARK: - Overrides
        
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        let newBounds = rectForBorder(bounds)
        return newBounds.insetBy(dx: textFieldInsets.x, dy: 0)
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        let newBounds = rectForBorder(bounds)

        return newBounds.insetBy(dx: textFieldInsets.x, dy: 0)
    }

}
