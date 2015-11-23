//
//  RegressionView.swift
//  EERegression
//
//  Created by Erk EKİN on 22/11/15.
//  Copyright © 2015 ekin. All rights reserved.
//

import UIKit

class node {
    
    var point:CGPoint!
    var layer:CAShapeLayer!
    
    
    init(point:CGPoint, layer:CAShapeLayer){
        self.point = point
        self.layer = layer
        
    }
}

class RegressionView: UIView {
    
    var nodes:[node] = []
    var reg = Regression()
    var modelLine:CAShapeLayer?
    
    let gridWidth: CGFloat = 0.5
    var columns: Int = 25
    
    init(frame: CGRect, columns: Int) {
        // Set size of grid
        self.columns = columns - 1
        super.init(frame: frame)
        
        // Set view to be transparent
        self.opaque = false;
        self.backgroundColor = UIColor(red:0.73, green:0.84, blue:0.95, alpha:1);
    }
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.opaque = false;
        self.backgroundColor = UIColor.whiteColor()
        let tap = UITapGestureRecognizer(target: self, action: "tapped:")
        self.addGestureRecognizer(tap)
        
        let pan = UIPanGestureRecognizer(target: self, action: "tapped:")
        self.addGestureRecognizer(pan)
        
        let longTap = UILongPressGestureRecognizer(target: self, action: "removeAll")
        self.addGestureRecognizer(longTap)
    }
    
    func removeAll(){
        
        
        modelLine?.removeFromSuperlayer()
        for onelayer in nodes{
            
            onelayer.layer.removeFromSuperlayer()
            
        }
        self.nodes = []
        
    }
    
    func findQuadraticPoints(){
        
        for i in 0..<1000{
            
            let value = Double(i) / 10
            
        }
        
    }
    
    override func drawRect(rect: CGRect) {
        let context: CGContextRef = UIGraphicsGetCurrentContext()!
        CGContextSetLineWidth(context, gridWidth)
        CGContextSetStrokeColorWithColor(context, UIColor(red:0.73, green:0.84, blue:0.95, alpha:1).CGColor)
        
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
    
    
    @IBAction func tapped(sender: UITapGestureRecognizer) {
        
        let tapPositionOneFingerTap = sender.locationInView(self)
        let nodea = node(point: tapPositionOneFingerTap, layer: setUpRWPath(tapPositionOneFingerTap))
        nodes.append(nodea)
        
        layer.addSublayer(nodea.layer)
        let tapCount = sender.numberOfTouches()
        print(tapCount)
        
        reg = regressionForValues(tapCount > 0 ? tapCount : 1)
        
        modelLine?.removeFromSuperlayer()
        modelLine = drawLinearModel()
        
        layer.addSublayer(modelLine!)
        
    }
    
    func drawLinearModel() -> CAShapeLayer
    {
        
        let width = Double(frame.width)
        var axeStartX = matrix(columns: 1, rows: 1)
        axeStartX.flat.grid = [0]
        let axeStartY = reg.predict(axeStartX).flat.grid.first
        
        var axeEndX = matrix(columns: 1, rows: 1)
        axeEndX.flat.grid = [width]
        let axeEndY = reg.predict(axeEndX).flat.grid.first
        
        let axialPoints = (x: CGPointMake(0, CGFloat(axeStartY!)),y: CGPointMake(CGFloat(width), CGFloat(axeEndY!)))
        
        return lineBetweenPoints(axialPoints.x, p2: axialPoints.y)

    }
    
    func regressionForValues(degree: Int) -> Regression{
        
        var X = matrix(columns: 1, rows: nodes.count)
        X.flat.grid = nodes.map({ (nodea) -> Double in
            
            return Double(nodea.point.x)
        })
        
        var Y = matrix(columns: 1, rows: nodes.count)
        
        Y.flat.grid = nodes.map({ (nodea) -> Double in
            
            return Double(nodea.point.y)
        })
        
        return Regression(X: X, Y: Y, degree: degree)
        
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
        return layer
        
    }
    
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