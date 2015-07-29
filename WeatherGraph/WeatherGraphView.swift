//
//  WeatherGraphView.swift
//  WeatherGraph
//
//  Created by Jens Bruggemans on 29/07/15.
//  Copyright (c) 2015 Embur. All rights reserved.
//

import UIKit

class WeatherGraphView: UIView {
    
    let padding:CGFloat = 40
    let graphLineColor = UIColor(red: 0.584, green: 0.651, blue: 0.898, alpha: 1.000)
    
    
    let minTemp:Int = -10 // should be multiples of 5
    let maxTemp:Int = 35
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
//        self.drawBackgroundGradient()
        
        self.drawGrid()
        self.drawTemperatureLine()
        self.drawGraphLines()
    }
    
    func drawBackgroundGradient() {
        // Get graphics
        let context = UIGraphicsGetCurrentContext()
        
        // Color declarations
        let topColor = UIColor(red: 0.457, green: 0.623, blue: 0.636, alpha: 1.000)
        let bottomColor = UIColor(red: 0.153, green: 0.224, blue: 0.330, alpha: 1.000)
        
        // Gradient declarations
        let gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [topColor.CGColor, bottomColor.CGColor], [0, 1])
        
        // Rectangle frame
        let rectanglePath = UIBezierPath(rect: self.bounds)
        let startPoint = CGPointMake(0, 0)
        let endPoint = CGPointMake(0, self.bounds.size.height)
        
        // Draw the rectangle
        CGContextSaveGState(context)
        rectanglePath.addClip()
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0)
        CGContextRestoreGState(context)
    }
    
    func drawGraphLines() {
        // Calculate the points in the path
        let origin = CGPointMake(padding, CGRectGetMaxY(self.bounds) - padding)
        let xTop = CGPointMake(padding, padding - 8)
        let yTop = CGPointMake(CGRectGetMaxX(self.bounds) - padding + 8, CGRectGetMaxY(self.bounds) - padding)
        
        // Create the path
        var bezierPath = UIBezierPath()
        bezierPath.moveToPoint(xTop)
        bezierPath.addLineToPoint(origin)
        bezierPath.addLineToPoint(yTop)
        
        // Draw the path
        graphLineColor.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()
    }
    
    func drawGrid() {
        // Calculate available space
        let availableHeight = CGRectGetHeight(self.bounds) - 2 * padding
        let availableWidth = CGRectGetWidth(self.bounds) - 2 * padding
        
        let numberOfHorizontalLines = 30 / 5
        
        // Draw horizontal lines
        for (var i = 1; i <= numberOfHorizontalLines; i++) {
            // Calculate start and end point
            let y = padding + CGFloat(numberOfHorizontalLines - i) * CGFloat(availableHeight) / CGFloat(numberOfHorizontalLines)
            let p1 = CGPointMake(padding, y)
            let p2 = CGPointMake(padding + availableWidth, y)
            
            // Create the path
            let bezierPath = UIBezierPath()
            bezierPath.moveToPoint(p1)
            bezierPath.addLineToPoint(p2)
            
            // Set the line width
            if i % 2 == 0 { // Draw normal line
                bezierPath.lineWidth = 1
            } else { // Draw thin line
                bezierPath.lineWidth = 1
            }
            
            // Draw the line
            graphLineColor.setStroke()
            bezierPath.stroke()
        }
        
        // Draw vertical lines
        let numberOfVerticalLines = 7
        for (var i = 1; i <= numberOfVerticalLines; i++) {
            let x = padding + CGFloat(i) * CGFloat(availableWidth) / CGFloat(numberOfVerticalLines)
            let p1 = CGPointMake(x, padding)
            let p2 = CGPointMake(x, padding + availableHeight)
            
            // Create the path
            let bezierPath = UIBezierPath()
            bezierPath.moveToPoint(p1)
            bezierPath.addLineToPoint(p2)
            
            // Draw the line
            bezierPath.lineWidth = 1
            graphLineColor.setStroke()
            bezierPath.stroke()
        }
    }
    
    func drawTemperatureLine() {
        // generate random data
        let availableHeight = CGRectGetHeight(self.bounds) - 2 * padding
        let availableWidth = CGRectGetWidth(self.bounds) - 2 * padding
        let temperatures = [CGPoint(x:0,y:13),
            CGPoint(x:0.25,y:12),
            CGPoint(x:0.5,y:23),
            CGPoint(x:0.75,y:23.5),
            CGPoint(x:1,y:16),
            CGPoint(x:1.25,y:16.5),
            CGPoint(x:1.5,y:29),
            CGPoint(x:1.75,y:28),
            CGPoint(x:2,y:19),
            CGPoint(x:2.25,y:17.5),
            CGPoint(x:2.5,y:24.5),
            CGPoint(x:2.75,y:22.5),
            CGPoint(x:3,y:16),
            CGPoint(x:3.25,y:15),
            CGPoint(x:3.5,y:21.5),
            CGPoint(x:3.75,y:20.5),
            CGPoint(x:4,y:14),
            CGPoint(x:4.25,y:13),
            CGPoint(x:4.5,y:22.5),
            CGPoint(x:4.75,y:22),
            CGPoint(x:5,y:14.5),
            CGPoint(x:5.25,y:14),
            CGPoint(x:5.5,y:25),
            CGPoint(x:5.75,y:24.5),
            CGPoint(x:6,y:17),
            CGPoint(x:6.25,y:16.5),
            CGPoint(x:6.5,y:26.5),
            CGPoint(x:6.75,y:25),
            CGPoint(x:7,y:16)]
        
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(padding + temperatures.first!.x * availableWidth / 7, padding + availableHeight - temperatures.first!.y * availableHeight / 30))
        for p in temperatures {
            bezierPath.addLineToPoint(CGPointMake(padding + p.x * availableWidth / 7, padding + availableHeight - p.y * availableHeight / 30))
        }
        bezierPath.lineWidth = 1
        UIColor.whiteColor().setStroke()
        bezierPath.stroke()
    }
}
