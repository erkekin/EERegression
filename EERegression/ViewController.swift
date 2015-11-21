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
        
        // time("yeni", fa: quadratic)
    }
    
       
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func test1(){
        
        let b:[Double] = [2,-1,0,3,1,0]
        var B = matrix(columns: 2, rows: 3)
        B.flat.grid = b
        
        let a:[Double] = [0,1,4,-1,-2,0,0,2]
        var A = matrix(columns: 4, rows: 2)
        A.flat.grid = a
        
        print(B *! A)
        //        matrix([2.000, 2.000, 8.000, -4.000],
        //            -6.000, 0.000, 0.000, 6.000],
        //            0.000, 1.000, 4.000, -1.000])
    }
    
    func test2(){
        
        let b:[Double] = [1,2,3,4]
        var B = matrix(columns: 2, rows: 2)
        B.flat.grid = b
        
        let a:[Double] = [2,0,1,2]
        var A = matrix(columns: 2, rows: 2)
        A.flat.grid = a
        
        let x:[Double] = [4,4,10,8]
        var X = matrix(columns: 2, rows: 2)
        X.flat.grid = x
        
        print( solve(X, b: A.flat))
        print(B *! A)
        //        let x:[Double] = [4,4,10,8]
        
        
        //X = B *! A
        // A-1*X = B
        //    |1        2||2    0| |4    4|
        //    |3        4||1    2| |10   8|
    }
    //
    //class Matriks<T>{
    //
    //    var cols:Int, rows:Int
    //    var matrix:[T]
    //
    //    init(cols:Int, rows:Int, defaultValue:T){
    //        self.cols = cols
    //        self.rows = rows
    //        matrix = Array(count:cols*rows,repeatedValue:defaultValue)
    //    }
    //
    //    subscript(col:Int, row:Int) -> T {
    //        get{
    //            return matrix[cols * row + col]
    //        }
    //        set{
    //            matrix[cols * row + col] = newValue
    //        }
    //    }
    //
    //    func colCount() -> Int {
    //        return self.cols
    //    }
    //
    //    func rowCount() -> Int {
    //        return self.rows
    //    }
    //}
}

