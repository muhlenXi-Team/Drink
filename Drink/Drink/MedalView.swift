//
//  MedalView.swift
//  TestController
//
//  Created by muhlenXi on 2019/8/1.
//  Copyright © 2019 muhlenXi. All rights reserved.
//

import UIKit

class MedalView: UIImageView {

    lazy var medalImage: UIImage = self.createMedalImage()
    
    func showMedal(show: Bool) {
        image = show == true ? medalImage : nil
    }
    
    func createMedalImage() -> UIImage {

        let size = CGSize(width: 120, height: 200)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()!
        
        //Gold colors
        let darkGoldColor = UIColor(red: 0.6, green: 0.5, blue: 0.15, alpha: 1.0)
        let midGoldColor = UIColor(red: 0.86, green: 0.73, blue: 0.3, alpha: 1.0)
        let lightGoldColor = UIColor(red: 1.0, green: 0.98, blue: 0.9, alpha: 1.0)
        
        //Add Shadow
        let shadow: UIColor = UIColor.black.withAlphaComponent(0.80)
        let shadowOffset = CGSize(width: 2.0, height: 2.0)
        let shadowBlurRadius: CGFloat = 5
        
        context.setShadow(offset: shadowOffset, blur: shadowBlurRadius, color: shadow.cgColor)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        context.endTransparencyLayer()
        
        
        // Lower Ribbon
        let lowerRibbonPath = UIBezierPath()
        lowerRibbonPath.move(to: CGPoint.zero)
        lowerRibbonPath.addLine(to: CGPoint(x: 40, y: 0))
        lowerRibbonPath.addLine(to: CGPoint(x: 78, y: 70))
        lowerRibbonPath.addLine(to: CGPoint(x: 38, y: 70))
        lowerRibbonPath.close()
        UIColor.red.setFill()
        lowerRibbonPath.fill()
        
        // clasp
        let claspPath = UIBezierPath(roundedRect: CGRect(x: 36, y: 62, width: 43, height: 20), cornerRadius: 5)
        claspPath.lineWidth = 5.0
        darkGoldColor.setStroke()
        claspPath.stroke()
        
        // medallion
        let medallionPath = UIBezierPath(ovalIn: CGRect(x: 8, y: 72, width: 100, height: 100))
        context.saveGState()
        medallionPath.addClip()
        
        let colors = [darkGoldColor.cgColor, midGoldColor.cgColor, lightGoldColor.cgColor] as CFArray
        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors, locations: [0, 0.51, 1])!
        context.drawLinearGradient(gradient, start: CGPoint(x: 40, y: 40), end: CGPoint(x: 100, y: 162), options: [])
        context.restoreGState()
        
        // create a transform
        var transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        transform = transform.translatedBy(x: 15, y: 30)
        medallionPath.lineWidth = 2.0
        
        medallionPath.apply(transform)
        medallionPath.stroke()
        
        // upper Ribbon
        let upperRibbonPath = UIBezierPath()
        upperRibbonPath.move(to: CGPoint(x: 68, y: 0))
        upperRibbonPath.addLine(to: CGPoint(x: 108, y: 0))
        upperRibbonPath.addLine(to: CGPoint(x: 78, y: 70))
        upperRibbonPath.addLine(to: CGPoint(x: 38, y: 70))
        upperRibbonPath.close()
        
        UIColor.blue.setFill()
        upperRibbonPath.fill()
        
        // Number One
        let numberOne = "1" as NSString
        let numberOneRect = CGRect(x: 47, y: 100, width: 50, height: 50)
        let font = UIFont(name: "Academy Engraved LET", size: 60)!
        let numberOneAttributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: darkGoldColor
        ]
        numberOne.draw(in: numberOneRect, withAttributes: numberOneAttributes)
        
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image!
    }
}
