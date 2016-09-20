//
//  MadokaTextField.swift
//  TextFieldEffects
//
//  Created by Raúl Riera on 05/02/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit

@IBDesignable open class MadokaTextField: TextFieldEffects {
    
    @IBInspectable open var placeholderColor: UIColor? {
        didSet {
            updatePlaceholder()
        }
    }
    
    @IBInspectable open var borderColor: UIColor? {
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
    
    fileprivate let borderThickness: CGFloat = 1
    fileprivate let placeholderInsets = CGPoint(x: 6, y: 6)
    fileprivate let textFieldInsets = CGPoint(x: 6, y: 6)
    fileprivate let borderLayer = CAShapeLayer()
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
        //let path = CGPathCreateWithRect(rectForBorder(bounds), nil)
        let rect = rectForBorder(bounds)
        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.origin.x + borderThickness, y: rect.height - borderThickness))
        path.addLine(to: CGPoint(x: rect.width - borderThickness, y: rect.height - borderThickness))
        path.addLine(to: CGPoint(x: rect.width - borderThickness, y: rect.origin.y + borderThickness))
        path.addLine(to: CGPoint(x: rect.origin.x + borderThickness, y: rect.origin.y + borderThickness))
        path.close()
        borderLayer.path = path.cgPath
        borderLayer.lineCap = kCALineCapSquare
        borderLayer.lineWidth = borderThickness
        borderLayer.fillColor = nil
        borderLayer.strokeColor = borderColor?.cgColor
        borderLayer.strokeEnd = percentageForBottomBorder()
    }
    
    fileprivate func percentageForBottomBorder() -> CGFloat {
        let borderRect = rectForBorder(bounds)
        let sumOfSides = (borderRect.width * 2) + (borderRect.height * 2)
        return (borderRect.width * 100 / sumOfSides) / 100
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
    
    fileprivate func rectForBorder(_ bounds: CGRect) -> CGRect {
        let newRect = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height - (font?.lineHeight)! + textFieldInsets.y)
        
        return newRect
    }
    
    fileprivate func layoutPlaceholderInTextRect() {
        
        if !(text?.isEmpty)! {
            return
        }
        
        placeholderLabel.transform = CGAffineTransform.identity
        
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
        
        placeholderLabel.frame = CGRect(x: originX, y: textRect.height - placeholderLabel.bounds.height - placeholderInsets.y,
            width: placeholderLabel.bounds.width, height: placeholderLabel.bounds.height)
    }
    
    override func animateViewsForTextEntry() {
        borderLayer.strokeEnd = 1
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            let translate = CGAffineTransform(translationX: -self.placeholderInsets.x, y: self.placeholderLabel.bounds.height + (self.placeholderInsets.y * 2))
            let scale = CGAffineTransform(scaleX: 0.9, y: 0.9)
            
            self.placeholderLabel.transform = translate.concatenating(scale)
        })
    }
    
    override func animateViewsForTextDisplay() {
        if (text?.isEmpty)! {
            borderLayer.strokeEnd = percentageForBottomBorder()
            
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                self.placeholderLabel.transform = CGAffineTransform.identity
            })
        }
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
