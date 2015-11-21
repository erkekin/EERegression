//
//  EERegressionTests.swift
//  EERegressionTests
//
//  Created by Erk EKİN on 15/11/15.
//  Copyright © 2015 ekin. All rights reserved.
//

import XCTest

@testable import EERegression

class EERegressionTests: XCTestCase {
    
    func regression(degree:Int) -> [Double]{
        
        var X = matrix(columns: 1, rows: 26)
        X.flat.grid = [0, 1, 2, 4, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 18, 19, 20, 21, 22, 24, 25, 26, 27, 28, 29, 30]
        
        var Y = matrix(columns: 1, rows: 26)
        Y.flat.grid = [126.6, 101.8, 71.6, 101.6, 68.1, 62.9, 45.5, 41.9, 46.3, 34.1, 38.2, 41.7, 24.7, 41.5, 36.6, 19.6, 22.8, 29.6, 23.5, 15.3, 13.4, 26.8, 9.8, 18.8, 25.9, 19.3]
        
        let regression = Regression(X: X, Y: Y, degree: degree)

        return regression.betalar!.grid
        
    }
 
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testQuadratic() {

        XCTAssertEqual(  String(format:"%.2f", regression(2)[0]), "110.11")
        XCTAssertEqual(  String(format:"%.2f", regression(2)[1]), "-7.42")
        XCTAssertEqual(  String(format:"%.2f", regression(2)[2]), "0.15")
        
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
    
    func testLinear() {
        
        XCTAssertEqual(  String(format:"%.2f", regression(1)[0]), "87.16")
        XCTAssertEqual(  String(format:"%.2f", regression(1)[1]), "-2.82")
        
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
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
            
        }
    }
    
}
