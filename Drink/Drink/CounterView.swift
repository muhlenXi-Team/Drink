//
//  CounterView.swift
//  TestController
//
//  Created by muhlenXi on 2019/7/31.
//  Copyright © 2019 muhlenXi. All rights reserved.
//

import UIKit

@IBDesignable
class CounterView: UIView {

    private struct Constants {
        static let numberOfGlasses = 8
        static let lineWidth: CGFloat = 5.0
        static let arcWidth: CGFloat = 76
        
        static var halfOfLineWidth: CGFloat {
            return lineWidth / 2
        }
    }
    
    @IBInspectable var counter: Int = 5 {
        didSet {
            if counter <= Constants.numberOfGlasses {
                setNeedsDisplay()
            }
        }
    }
    
    
    @IBInspectable var outlineColor: UIColor = UIColor.blue
    @IBInspectable var counterColor: UIColor = UIColor.orange
    
    override func draw(_ rect: CGRect) {
        
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius: CGFloat = max(bounds.width, bounds.height)
        let startAngle: CGFloat = 3 * .pi / 4
        let endAngle: CGFloat = .pi / 4
        
        let path = UIBezierPath(arcCenter: center, radius: radius/2-Constants.arcWidth/2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        path.lineWidth = Constants.arcWidth
        counterColor.setStroke()
        path.stroke()
        
        
        let angleDifference: CGFloat = 2 * .pi - startAngle + endAngle
        let arcLengthPerGlass = angleDifference / CGFloat(Constants.numberOfGlasses)
        let outlineEndAngle = arcLengthPerGlass * CGFloat(counter) + startAngle
        
        let outlinePath = UIBezierPath(arcCenter: center, radius: bounds.width/2-Constants.halfOfLineWidth, startAngle: startAngle, endAngle: outlineEndAngle, clockwise: true)
        
        outlinePath.addArc(withCenter: center, radius: bounds.width/2-Constants.arcWidth+Constants.halfOfLineWidth, startAngle: outlineEndAngle, endAngle: startAngle, clockwise: false)
        
        outlinePath.close()
        
        outlineColor.setStroke()
        outlinePath.lineWidth = Constants.lineWidth
        outlinePath.stroke()
        
        // Counter View markers
        let context = UIGraphicsGetCurrentContext()!
        context.saveGState()
        outlineColor.setFill()
        
        let markerWidth: CGFloat = 5.0
        let markerSize: CGFloat = 10.0
        
        let markerPath = UIBezierPath(rect: CGRect(x: -markerWidth/2, y: 0, width: markerWidth, height: markerSize))
        context.translateBy(x: rect.width/2, y: rect.height/2)
        
        for i in 1...Constants.numberOfGlasses {
            context.saveGState()
            let angle = arcLengthPerGlass*CGFloat(i) + startAngle - .pi/2
            context.rotate(by: angle)
            context.translateBy(x: 0, y: rect.height/2-markerSize)
            markerPath.fill()
            context.restoreGState()
        }
        
        context.restoreGState()
    }
}
