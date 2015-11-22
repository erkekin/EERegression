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
        return layer
        
        //
        //        let rwColor = UIColor(red: 11/255.0, green: 86/255.0, blue: 14/255.0, alpha: 1.0)
        //        let rwPath = UIBezierPath()
        //        let rwLayer = CAShapeLayer()
        //
        //        rwPath.moveToPoint(CGPointMake(0.22, 124.79))
        //        rwPath.addLineToPoint(CGPointMake(0.22, 249.57))
        //        rwPath.addLineToPoint(CGPointMake(124.89, 249.57))
        //        rwPath.addLineToPoint(CGPointMake(249.57, 249.57))
        //        rwPath.addLineToPoint(CGPointMake(249.57, 143.79))
        //        rwPath.addCurveToPoint(CGPointMake(249.37, 38.25), controlPoint1: CGPointMake(249.57, 85.64), controlPoint2: CGPointMake(249.47, 38.15))
        //        rwPath.addCurveToPoint(CGPointMake(206.47, 112.47), controlPoint1: CGPointMake(249.27, 38.35), controlPoint2: CGPointMake(229.94, 71.76))
        //        rwPath.addCurveToPoint(CGPointMake(163.46, 186.84), controlPoint1: CGPointMake(182.99, 153.19), controlPoint2: CGPointMake(163.61, 186.65))
        //        rwPath.addCurveToPoint(CGPointMake(146.17, 156.99), controlPoint1: CGPointMake(163.27, 187.03), controlPoint2: CGPointMake(155.48, 173.59))
        //        rwPath.addCurveToPoint(CGPointMake(128.79, 127.08), controlPoint1: CGPointMake(136.82, 140.43), controlPoint2: CGPointMake(129.03, 126.94))
        //        rwPath.addCurveToPoint(CGPointMake(109.31, 157.77), controlPoint1: CGPointMake(128.59, 127.18), controlPoint2: CGPointMake(119.83, 141.01))
        //        rwPath.addCurveToPoint(CGPointMake(89.83, 187.86), controlPoint1: CGPointMake(98.79, 174.52), controlPoint2: CGPointMake(90.02, 188.06))
        //        rwPath.addCurveToPoint(CGPointMake(56.52, 108.28), controlPoint1: CGPointMake(89.24, 187.23), controlPoint2: CGPointMake(56.56, 109.11))
        //        rwPath.addCurveToPoint(CGPointMake(64.02, 102.25), controlPoint1: CGPointMake(56.47, 107.75), controlPoint2: CGPointMake(59.24, 105.56))
        //        rwPath.addCurveToPoint(CGPointMake(101.42, 67.57), controlPoint1: CGPointMake(81.99, 89.78), controlPoint2: CGPointMake(93.92, 78.72))
        //        rwPath.addCurveToPoint(CGPointMake(108.38, 30.65), controlPoint1: CGPointMake(110.28, 54.47), controlPoint2: CGPointMake(113.01, 39.96))
        //        rwPath.addCurveToPoint(CGPointMake(10.35, 0.41), controlPoint1: CGPointMake(99.66, 13.17), controlPoint2: CGPointMake(64.11, 2.16))
        //        rwPath.addLineToPoint(CGPointMake(0.22, 0.07))
        //        rwPath.addLineToPoint(CGPointMake(0.22, 124.79))
        //        rwPath.closePath()
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
//
//override func viewDidLoad() {
//    super.viewDidLoad()
//
//    // 4
//    setUpRWPath()
//    setUpRWLayer()
//    someView.layer.addSublayer(rwLayer)
//}