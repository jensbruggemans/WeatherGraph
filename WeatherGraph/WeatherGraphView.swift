//
//  WeatherGraphView.swift
//  WeatherGraph
//
//  Created by Jens Bruggemans on 29/07/15.
//  Copyright (c) 2015 Embur. All rights reserved.
//

import UIKit

class WeatherGraphView: UIView {
    
    let gradientTopColor = UIColor(red: 0.457, green: 0.623, blue: 0.636, alpha: 1.000)
    let gradientBottomColor = UIColor(red: 0.153, green: 0.224, blue: 0.330, alpha: 1.000)
    
    let padding:CGFloat = 40
    let gridLineColor = UIColor(red: 0.584, green: 0.651, blue: 0.898, alpha: 1.000)
    let textColor = UIColor(red: 0.584, green: 0.651, blue: 0.898, alpha: 1.000)
    
    let maxTemp:Int = 30
    let numberOfDays = 7
    
    let dayStrings = ["Mon", "Tue", "Wed","Thu","Fri","Sat","Sun"]
    let temperatures:[CGFloat] = [13,12,23,23.5,16,16.5,29,28,18.5,17.5,24.5,22.5,16,15,21.5,20.5,14,13,22.5,22,14.5,14,25,24.5,17,16.5,26.5,25,16]
    let maxTemperatures:[CGFloat] = [13.5,12.5,24,24,17,17,31,29.5,20,19,26,24,17.5,16.5,23,22,16,15,26.5,25,16.5,16,28,27,19,18.5,30,28,18]
    let minTemperatures:[CGFloat] = [12.5,11.5,22.5,23,15.5,16,28,27,17.5,16.5,23,21,14.5,13.5,20,19,13,12,21,20,13,13,24,23,14.5,14,24,23,13.5]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createLabels()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.createLabels()
    }
    
    func createLabels() {
        self.createDayLabels()
        self.createTemperatureLabels()
    }
    
    func createDayLabels() {
        // Calculate available space
        let availableWidth = self.availableWidth()
        let availableHeight = self.availableHeight()
        
        // Calculate the size of the labels
        let labelWidth = availableWidth / CGFloat(self.numberOfDays)
        let labelHeight = padding
        
        for var i = 0; i < self.numberOfDays; i++ {
            // Create, position and add to view
            let label = UILabel()
            label.frame = CGRect(x: padding + CGFloat(i) * labelWidth, y: padding + availableHeight, width: labelWidth, height: labelHeight)
            self.addSubview(label)
            
            // Set look of label and text
            label.textAlignment = NSTextAlignment.Center
            label.text = self.dayStrings[i]
            label.textColor = self.textColor
        }
    }
    
    func createTemperatureLabels() {
        // Calculate available space
        let availableWidth = self.availableWidth()
        let availableHeight = self.availableHeight()
        
        // Calculate the size of the labels
        let labelWidth = padding
        let labelHeight : CGFloat = 24
        
        for var i = 0; i <= self.maxTemp; i += 10 {
            // Create, position and add to view
            let label = UILabel()
            label.frame = CGRect(x: 0.0, y: padding + availableHeight - labelHeight / 2 - (availableHeight / CGFloat(maxTemp)) * CGFloat(i), width: labelWidth, height: labelHeight)
            self.addSubview(label)
            
            // Set look of label and text
            label.textAlignment = NSTextAlignment.Center
            label.text = "\(i)"
            label.textColor = self.textColor
        }
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        self.drawBackgroundGradient()
        self.drawGrid()
        self.drawTemperatureArea()
        self.drawTemperatureLine()
        self.drawAxis()
    }
    
    func drawBackgroundGradient() {
        // Get graphics
        let context = UIGraphicsGetCurrentContext()
        
        // Create gradient
        let gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [gradientTopColor.CGColor, gradientBottomColor.CGColor], [0, 1])
        
        // Rectangle frame
        let rectanglePath = UIBezierPath(rect: self.bounds)
        let startPoint = CGPointMake(0, 0)
        let endPoint = CGPointMake(0, self.bounds.size.height)
        
        // Draw the gradient rectangle
        CGContextSaveGState(context)
        rectanglePath.addClip()
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0)
        CGContextRestoreGState(context)
    }
    
    func drawAxis() {
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
        gridLineColor.setStroke()
        bezierPath.lineWidth = 2
        bezierPath.stroke()
    }
    
    func availableHeight() -> CGFloat {
        return CGRectGetHeight(self.bounds) - 2 * padding
    }
    
    func availableWidth() -> CGFloat {
        return CGRectGetWidth(self.bounds) - 2 * padding
    }
    
    func drawGrid() {
        // Calculate available space
        let availableHeight = self.availableHeight()
        let availableWidth = self.availableWidth()
        
        // We draw a line every 5 degrees
        let numberOfHorizontalLines = maxTemp / 5
        
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
                bezierPath.lineWidth = 0.5
            }
            
            // Draw the line
            gridLineColor.setStroke()
            bezierPath.stroke()
        }
        
        // Draw vertical lines
        for (var i = 1; i <= self.numberOfDays; i++) {
            let x = padding + CGFloat(i) * CGFloat(availableWidth) / CGFloat(self.numberOfDays)
            let p1 = CGPointMake(x, padding)
            let p2 = CGPointMake(x, padding + availableHeight)
            
            // Create the path
            let bezierPath = UIBezierPath()
            bezierPath.moveToPoint(p1)
            bezierPath.addLineToPoint(p2)
            
            // Draw the line
            bezierPath.lineWidth = 1
            gridLineColor.setStroke()
            bezierPath.stroke()
        }
    }
    
    func drawTemperatureLine() {
        // Calculate available space
        let availableHeight = self.availableHeight()
        let availableWidth = self.availableWidth()

        // Create the path and move it to the first point
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(padding, padding + availableHeight - temperatures[0] * availableHeight / CGFloat(self.maxTemp)))
        
        // Add a line segment for each temperature
        for var i = 1; i < temperatures.count; i++ {
            let x = padding + CGFloat(i) * availableWidth / CGFloat(temperatures.count - 1)
            let y = padding + availableHeight - temperatures[i] * availableHeight / CGFloat(self.maxTemp)
            bezierPath.addLineToPoint(CGPointMake(x,y))
        }
        
        // Draw the path, using the stroke function
        bezierPath.lineWidth = 2
        UIColor.whiteColor().setStroke()
        bezierPath.stroke()
    }
    
    func drawTemperatureArea() {
        let availableHeight = self.availableHeight()
        let availableWidth = self.availableWidth()
        
        let bezierPath = UIBezierPath()
        // Go to first position
        bezierPath.moveToPoint(CGPointMake(padding, padding + availableHeight - maxTemperatures[0] * availableHeight / 30))
        
        // Draw top part
        for var i = 1; i < maxTemperatures.count; i++ {
            let x = padding + CGFloat(i) * availableWidth / CGFloat(maxTemperatures.count - 1)
            let y = padding + availableHeight - maxTemperatures[i] * availableHeight / 30
            bezierPath.addLineToPoint(CGPointMake(x,y))
        }
        
        // Draw bottom part, in reverse order
        for var i = minTemperatures.count - 1; i >= 0; i-- {
            let x = padding + CGFloat(i) * availableWidth / CGFloat(minTemperatures.count - 1)
            let y = padding + availableHeight - minTemperatures[i] * availableHeight / 30
            bezierPath.addLineToPoint(CGPointMake(x,y))
        }
        
        // Connect the first and last point
        bezierPath.closePath()
        
        // Draw the path, using the fill function
        bezierPath.lineWidth = 1
        UIColor(white: 0.8, alpha: 0.5).setFill()
        bezierPath.fill()
    }
}
