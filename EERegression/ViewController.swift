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
        
        quadratic()
        
        // time("yeni", fa: quadratic)
    }
    
    func quadratic() -> [Double]{
        
        var Y = matrix(columns: 1, rows: 26)
        Y.flat.grid = [126.6, 101.8, 71.6, 101.6, 68.1, 62.9, 45.5, 41.9, 46.3, 34.1, 38.2, 41.7, 24.7, 41.5, 36.6, 19.6, 22.8, 29.6, 23.5, 15.3, 13.4, 26.8, 9.8, 18.8, 25.9, 19.3]
        
        var X1 = matrix(columns: 1, rows: 26)
        X1.flat.grid = [0, 1, 2, 4, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 18, 19, 20, 21, 22, 24, 25, 26, 27, 28, 29, 30]
        
        var X2 = matrix(columns: 1, rows: 26)
        X2.flat.grid = [0, 1, 4, 16, 36, 64, 81, 100, 121, 144, 169, 196, 225, 256, 324, 361, 400, 441, 484, 576, 625, 676, 729, 784, 841, 900]
        
        
        
        
        var X = matrix(columns: 2, rows: Y.count)
        X.flat = concat(X1.flat, y: X2.flat)
        
        //  let a = bind(X1.flat, y: X2.flat)
        
        let ar = LinearRegression(X: X, Y: Y)
        return ar.betalar!.grid
        
        //        Call:
        //        lm(formula = Counts ~ Time + Time2)
        //        Residuals:
        //        Min       1Q   Median       3Q     Max
        //        -24.2649 -4.9206 -0.9519   5.5860 18.7728
        //
        //        Coefficients:
        //        Estimate Std. Error t value Pr(>|t|)
        //        (Intercept) 110.10749   5.48026 20.092 4.38e-16 ***
        //        Time         -7.42253   0.80583 -9.211 3.52e-09 ***
        //        Time2         0.15061   0.02545   5.917 4.95e-06 ***
        //        ---
        //        Signif. codes: 0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
        //
        //        Residual standard error: 9.754 on 23 degrees of freedom
        //        Multiple R-squared: 0.9014,   Adjusted R-squared: 0.8928
        //        F-statistic: 105.1 on 2 and 23 DF, p-value: 2.701e-12
    }
    
    func linear(){
        
        var Y = matrix(columns: 1, rows: 26)
        Y.flat.grid = [126.6, 101.8, 71.6, 101.6, 68.1, 62.9, 45.5, 41.9, 46.3, 34.1, 38.2, 41.7, 24.7, 41.5, 36.6, 19.6, 22.8, 29.6, 23.5, 15.3, 13.4, 26.8, 9.8, 18.8, 25.9, 19.3]
        
        var X = matrix(columns: 1, rows: 26)
        X.flat.grid = [0, 1, 2, 4, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 18, 19, 20, 21, 22, 24, 25, 26, 27, 28, 29, 30]
        
        let ar = LinearRegression(X: X, Y: Y)
        
        print(ar.betalar!.grid)
        
        //        Call:
        //        lm(formula = Counts ~ Time)
        //
        //        Residuals:
        //        Min      1Q  Median      3Q     Max
        //        -20.084  -9.875  -1.882   8.494  39.445
        //
        //        Coefficients:
        //        Estimate Std. Error t value Pr(>|t|)
        //        (Intercept)  87.1550     6.0186  14.481 2.33e-13 ***
        //        Time         -2.8247     0.3318  -8.513 1.03e-08 ***
        //        ---
        //        Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
        //
        //        Residual standard error: 15.16 on 24 degrees of freedom
        //        Multiple R-squared:  0.7512,	Adjusted R-squared:  0.7408
        //        F-statistic: 72.47 on 1 and 24 DF,  p-value: 1.033e-08
        
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

