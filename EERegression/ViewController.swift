//
//  ViewController.swift
//  EERegression
//
//  Created by Erk EKİN on 15/11/15.
//  Copyright © 2015 ekin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var chartView: RegressionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func tapped(sender: UITapGestureRecognizer) {
        
        let tapPositionOneFingerTap = sender.locationInView(chartView)
          print("y: \(chartView.frame.height - tapPositionOneFingerTap.y)")
        print("X: \(tapPositionOneFingerTap.x) - Y: \(tapPositionOneFingerTap.y)")
        
//        NSLog(@"one tap detec");
        //
    }
       
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
}

