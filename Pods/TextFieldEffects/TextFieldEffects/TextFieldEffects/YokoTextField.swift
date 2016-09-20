//
//  YokoTextField.swift
//  TextFieldEffects
//
//  Created by Raúl Riera on 30/01/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit

@IBDesignable open class YokoTextField: TextFieldEffects {
    
    override open var placeholder: String? {
        didSet {
            updatePlaceholder()
        }
    }
    
    @IBInspectable open var placeholderColor: UIColor? {
        didSet {
            updatePlaceholder()
        }
    }
    
    @IBInspectable open var foregroundColor: UIColor = UIColor.black {
        didSet {
            updateForeground()
        }
    }
    
    override open var bounds: CGRect {
        didSet {
            updateForeground()
            updatePlaceholder()
        }
    }
    
    fileprivate let foregroundView = UIView()
    fileprivate let foregroundLayer = CALayer()
    fileprivate let borderThickness: CGFloat = 3
    fileprivate let placeholderInsets = CGPoint(x: 6, y: 6)
    fileprivate let textFieldInsets = CGPoint(x: 6, y: 6)
    
    // MARK: - TextFieldsEffectsProtocol
    
    override func drawViewsForRect(_ rect: CGRect) {
        updateForeground()
        updatePlaceholder()
        
        addSubview(foregroundView)
        addSubview(placeholderLabel)
        layer.addSublayer(foregroundLayer)        
    }
    
    fileprivate func updateForeground() {
        foregroundView.frame = rectForForeground(frame)
        foregroundView.isUserInteractionEnabled = false
        foregroundView.layer.transform = rotationAndPerspectiveTransformForView(foregroundView)
        foregroundView.backgroundColor = foregroundColor
        
        foregroundLayer.borderWidth = borderThickness
        foregroundLayer.borderColor = colorWithBrightnessFactor(foregroundColor, factor: 0.8).cgColor
        foregroundLayer.frame = rectForBorder(foregroundView.frame, isFill: true)
    }
    
    fileprivate func updatePlaceholder() {
        placeholderLabel.font = placeholderFontFromFont(font!)
        placeholderLabel.text = placeholder
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.sizeToFit()
        layoutPlaceholderInTextRect()
        
        if isFirstResponder || !(text?.isEmpty)! {
            animateViewsForTextEntry()
        }
    }
    
    fileprivate func placeholderFontFromFont(_ font: UIFont) -> UIFont! {
        let smallerFont = UIFont(name: font.fontName, size: font.pointSize * 0.7)
        return smallerFont
    }
    
    fileprivate func rectForForeground(_ bounds: CGRect) -> CGRect {
        let newRect = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height - (font?.lineHeight)! + textFieldInsets.y - borderThickness)
        
        return newRect
    }
    
    fileprivate func rectForBorder(_ bounds: CGRect, isFill: Bool) -> CGRect {
        var newRect = CGRect(x: 0, y: bounds.size.height, width: bounds.size.width, height: isFill ? borderThickness : 0)
        
        if !CATransform3DIsIdentity(foregroundView.layer.transform) {
            newRect.origin = CGPoint(x: 0, y: bounds.origin.y)
        }
        
        return newRect
    }
    
    fileprivate func layoutPlaceholderInTextRect() {
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
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.6, options: UIViewAnimationOptions.beginFromCurrentState, animations: { () -> Void in
        
                self.foregroundView.layer.transform = CATransform3DIdentity
            
            }, completion: nil)
        
        foregroundLayer.frame = rectForBorder(foregroundView.frame, isFill: false)
    }
    
    override func animateViewsForTextDisplay() {
        if (text?.isEmpty)! {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.6, options: UIViewAnimationOptions.beginFromCurrentState, animations: { () -> Void in
                
                self.foregroundLayer.frame = self.rectForBorder(self.foregroundView.frame, isFill: true)
                self.foregroundView.layer.transform = self.rotationAndPerspectiveTransformForView(self.foregroundView)
            }, completion: nil)
        }
    }
    
    // MARK: -
    
    fileprivate func setAnchorPoint(_ anchorPoint:CGPoint, forView view:UIView) {
        var newPoint:CGPoint = CGPoint(x: view.bounds.size.width * anchorPoint.x, y: view.bounds.size.height * anchorPoint.y)
        var oldPoint:CGPoint = CGPoint(x: view.bounds.size.width * view.layer.anchorPoint.x, y: view.bounds.size.height * view.layer.anchorPoint.y)
        
        newPoint = newPoint.applying(view.transform)
        oldPoint = oldPoint.applying(view.transform)
        
        var position = view.layer.position
        
        position.x -= oldPoint.x
        position.x += newPoint.x
        
        position.y -= oldPoint.y
        position.y += newPoint.y
        
        view.layer.position = position
        view.layer.anchorPoint = anchorPoint
    }
    
    fileprivate func colorWithBrightnessFactor(_ color: UIColor, factor: CGFloat) -> UIColor {
        var hue : CGFloat = 0
        var saturation : CGFloat = 0
        var brightness : CGFloat = 0
        var alpha : CGFloat = 0
        
        if color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return UIColor(hue: hue, saturation: saturation, brightness: brightness * factor, alpha: alpha)
        } else {
            return color;
        }
    }
    
    fileprivate func rotationAndPerspectiveTransformForView(_ view: UIView) -> CATransform3D {
        setAnchorPoint(CGPoint(x: 0.5, y: 1.0), forView:view)
        
        var rotationAndPerspectiveTransform = CATransform3DIdentity
        rotationAndPerspectiveTransform.m34 = 1.0/800
        let radians = ((-90) / 180.0 * CGFloat(M_PI))
        rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, radians, 1.0, 0.0, 0.0)
        return rotationAndPerspectiveTransform
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