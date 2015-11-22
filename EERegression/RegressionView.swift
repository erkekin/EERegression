//
//  RegressionView.swift
//  EERegression
//
//  Created by Erk EKİN on 22/11/15.
//  Copyright © 2015 ekin. All rights reserved.
//

import UIKit

class RegressionView: UIView {
    
    var points:[CGPoint] = []
    var modelLine:CAShapeLayer?
    let gridWidth: CGFloat = 0.5
    var columns: Int = 50
    
    init(frame: CGRect, columns: Int) {
        // Set size of grid
        self.columns = columns - 1
        super.init(frame: frame)
        
        // Set view to be transparent
        self.opaque = false;
        self.backgroundColor = UIColor(white: 0.0, alpha: 0.0);
    }
    

    override func drawRect(rect: CGRect) {
        let context: CGContextRef = UIGraphicsGetCurrentContext()!
        CGContextSetLineWidth(context, gridWidth)
        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
        
        // Calculate basic dimensions
        let columnWidth: CGFloat = self.frame.size.width / (CGFloat(self.columns) + 1.0)
        let rowHeight: CGFloat = columnWidth;
        let numberOfRows: Int = Int(self.frame.size.height)/Int(rowHeight);
        
        // ---------------------------
        // Drawing column lines
        // ---------------------------
        for i in 1...self.columns {
            let startPoint: CGPoint = CGPoint(x: columnWidth * CGFloat(i), y: 0.0)
            let endPoint: CGPoint = CGPoint(x: startPoint.x, y: self.frame.size.height)
            
            CGContextMoveToPoint(context, startPoint.x, startPoint.y);
            CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
            CGContextStrokePath(context);
        }
        
        // ---------------------------
        // Drawing row lines
        // ---------------------------
        for j in 1...numberOfRows {
            let startPoint: CGPoint = CGPoint(x: 0.0, y: rowHeight * CGFloat(j))
            let endPoint: CGPoint = CGPoint(x: self.frame.size.width, y: startPoint.y)
            
            CGContextMoveToPoint(context, startPoint.x, startPoint.y);
            CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
            CGContextStrokePath(context);
        }
    }
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        let tap = UITapGestureRecognizer(target: self, action: "tapped:")
        self.addGestureRecognizer(tap)
        
    }
    
    @IBAction func tapped(sender: UITapGestureRecognizer) {
        
        let tapPositionOneFingerTap = sender.locationInView(self)
        
        points.append(tapPositionOneFingerTap)
        
        layer.addSublayer(setUpRWPath(tapPositionOneFingerTap))
        
        let axialPoints = regressionWithPoint()
        
        modelLine?.removeFromSuperlayer()
        modelLine = lineBetweenPoints(axialPoints.x, p2: axialPoints.y)
      
        layer.addSublayer(modelLine!)
        
    }
    
    func regressionWithPoint() -> (x:CGPoint, y:CGPoint){
        
        var X = matrix(columns: 1, rows: points.count)
        X.flat.grid = points.map({ (point) -> Double in
            
            return Double(point.x)
        })
        
        var Y = matrix(columns: 1, rows: points.count)
        
        Y.flat.grid = points.map({ (point) -> Double in
            
            return Double(point.y)
        })
        
        let reg = Regression(X: X, Y: Y, degree: 1)
        
        let width = Double(frame.width)
        var axeStartX = matrix(columns: 1, rows: 1)
        axeStartX.flat.grid = [0]
        let axeStartY = reg.predict(axeStartX).flat.grid.first
        
        var axeEndX = matrix(columns: 1, rows: 1)
        axeEndX.flat.grid = [width]
        let axeEndY = reg.predict(axeEndX).flat.grid.first
        
        return (CGPointMake(0, CGFloat(axeStartY!)),CGPointMake(CGFloat(width), CGFloat(axeEndY!)))
    }
    
    func lineBetweenPoints(p1:CGPoint, p2: CGPoint) -> CAShapeLayer{
        
        let rwColor = UIColor.blueColor()
        let rwPath = UIBezierPath()
        let rwLayer = CAShapeLayer()
        rwPath.moveToPoint(p1)
        rwPath.addLineToPoint(p2)
        rwPath.closePath()
        rwLayer.path = rwPath.CGPath
        rwLayer.lineWidth = 1.0
        rwLayer.fillColor = rwColor.CGColor
        rwLayer.strokeColor = rwColor.CGColor
        
        return rwLayer
    }
    
    func setUpRWPath(point:CGPoint) -> CAShapeLayer{
        
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: CGRect(x: point.x - 2.5, y: point.y - 2.5, width: 5, height: 5), cornerRadius: 2.5).CGPath
        layer.fillColor = UIColor.redColor().CGColor
        return layer    }
    
    
}
//
//// 3
//func setUpRWLayer() {
//    rwLayer.path = rwPath.CGPath
//    rwLayer.fillColor = rwColor.CGColor
//    rwLayer.fillRule = kCAFillRuleNonZero
//    rwLayer.lineCap = kCALineCapButt
//    rwLayer.lineDashPattern = nil
//    rwLayer.lineDashPhase = 0.0
//    rwLayer.lineJoin = kCALineJoinMiter
//    rwLayer.lineWidth = 1.0
//    rwLayer.miterLimit = 10.0
//    rwLayer.strokeColor = rwColor.CGColor
//}