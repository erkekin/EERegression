//
//  ViewController.swift
//  EERegression
//
//  Created by Erk EKİN on 15/11/15.
//  Copyright © 2015 ekin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        time(yeni, name: "yeni")
        
        //        let y:[Double] = [1,2,3,4]
        //        var Y = matrix(columns: 2, rows: 2)
        //        Y.flat.grid = y
        //
        //        let a:[Double] = [2,0,1,2]
        //        var A = matrix(columns: 2, rows: 2)
        //        A.flat.grid = a
        //
        //        print(Y *! A)
        // |4    4|
        // |10   8|
    }
    
    func yeni(){
        
        var Y = matrix(columns: 1, rows: 10)
        Y.flat.grid = [1,2,3,4,5,6,7,8,9,10]
        
        var X = matrix(columns: 2, rows: 10)
        X.flat.grid = [1,2,3,4,5,6,7,8,9,10,1,2,3,4,5,6,7,8,9,10]
        
        
        
        let ar = LinearRegression(X: X, Y: Y)
        
        print(ar.betalar!.grid)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

