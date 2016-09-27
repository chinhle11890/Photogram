//
//  Extensions.swift
//  Photogram
//
//  Created by Bao Nguyen on 9/20/16.
//  Copyright © 2016 Chinh Le. All rights reserved.
//

import UIKit

extension UIView {
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewDictionary))
    }
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIViewController {
    var appDelegate:AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}

extension UIImageView {
    func polygon() {
        let lineWidth: CGFloat = 2.0;
        let path = UIBezierPath(roundedPolygonPathWithRect:self.frame, lineWidth: lineWidth, sides: 8, cornerRadius: 6)
        
        let mask = CAShapeLayer()
        mask.path            = path.cgPath
        mask.lineWidth       = lineWidth
        mask.strokeColor     = UIColor.clear.cgColor
        mask.fillColor       = UIColor.white.cgColor
        self.layer.mask = mask
        
        let border = CAShapeLayer()
        border.path          = path.cgPath
        border.lineWidth     = lineWidth
        border.strokeColor   = UIColor.lightGray.cgColor
        border.fillColor     = UIColor.clear.cgColor
        self.layer.addSublayer(border)
    }
}

extension UIBezierPath {
    
    /// Create UIBezierPath for regular polygon with rounded corners
    ///
    /// - parameter roundedPolygonPathWithRect:  The CGRect of the square in which the path should be created.
    /// - parameter lineWidth:                   The width of the stroke around the polygon. The polygon will be inset such that the stroke stays within the above square.
    /// - parameter sides:                       How many sides to the polygon (e.g. 6=hexagon; 8=octagon, etc.).
    /// - parameter cornerRadius:                The radius to be applied when rounding the corners.
    
    convenience init(roundedPolygonPathWithRect rect: CGRect, lineWidth: CGFloat, sides: NSInteger, cornerRadius: CGFloat) {
        self.init()
        
        let theta = CGFloat(2.0 * M_PI) / CGFloat(sides)                            // how much to turn at every corner
        let offset = CGFloat(cornerRadius) * CGFloat(tan(theta / 2.0))              // offset from which to start rounding corners
        let squareWidth = min(rect.size.width, rect.size.height)          // width of the square
        
        // calculate the length of the sides of the polygon
        
        var length = squareWidth - lineWidth
        if sides % 4 != 0 {                                               // if not dealing with polygon which will be square with all sides ...
            length = length * CGFloat(cos(theta / 2.0)) + offset/2.0               // ... offset it inside a circle inside the square
        }
        let sideLength = length * CGFloat(tan(theta / 2.0))
        
        // start drawing at `point` in lower right corner
        
        var point = CGPoint(x: squareWidth / 2.0 + sideLength / 2.0 - offset, y: squareWidth - (squareWidth - length) / 2.0)
        var angle = CGFloat(M_PI)
        move(to: point)
        
        // draw the sides and rounded corners of the polygon
        
        for _ in 0 ..< sides {
            point = CGPoint(x: point.x + CGFloat(sideLength - offset * 2.0) * CGFloat(cos(angle)), y: point.y + CGFloat(sideLength - offset * 2.0) * CGFloat(sin(angle)))
            addLine(to: point)
            
            let center = CGPoint(x: point.x + cornerRadius * CGFloat(cos(angle + CGFloat(M_PI_2))), y: point.y + cornerRadius * CGFloat(sin(angle + CGFloat(M_PI_2))))
            addArc(withCenter: center, radius:CGFloat(cornerRadius), startAngle:angle - CGFloat(M_PI_2), endAngle:angle + theta - CGFloat(M_PI_2), clockwise:true)
            
            point = currentPoint // we don't have to calculate where the arc ended ... UIBezierPath did that for us
            angle += theta
        }
        
        close()
    }
    
}
