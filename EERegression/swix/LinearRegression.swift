//
//  LinearRegression.swift
//  swix
//
//  Created by Erk EKİN on 15/07/15.
//  Copyright (c) 2015 com.scott. All rights reserved.
//
import UIKit

extension matrix{
    
      private func addOnes() -> matrix{
        let ones = [Double](count: self.rows, repeatedValue: 1.0)
        
        let onedXGrid = ones + self.flat.grid
        
        var onedX =  matrix(columns: self.rows*(self.columns + 1), rows: 1)
        onedX.flat.grid = onedXGrid
        
        onedX.columns = self.rows
        onedX.rows = self.columns + 1
        onedX.shape = (onedX.rows, onedX.columns)
        onedX = transpose(onedX)
        return onedX
        
    }
}
class LinearRegression {
    
    var betalar:ndarray?
    
    init(X:matrix, Y:matrix){
        
        betalar = self.findBetas(X, Y: Y)
    }
    
    private func findBetas(X:matrix, Y:matrix) -> ndarray {
        
        assert(X.rows == Y.rows, "Sizes of input arguments do not match")
        assert(Y.columns == 1, "Columns of Y should be 1")
        
        //      |1  x01 x02 x0n|      |y0|
        //      |1  x11 x12 x1n|      |y1|
        //  X = |1  x21 x22 x2n|  Y = |y2|  ß = (X'X)^-1 * X'Y'
        //      |1  x31 x32 x3n|      |y3|
        //      |1  x41 x42 x4n|      |y4|
        //      |1  xm1 xm2 xmn|      |ym|
        
        print(X)
        
        
        let onedXNew = X.addOnes()
        print(onedXNew)
        //let betas = solve(X'X, X'Y')
        let betas = solve(transpose(onedXNew)*!onedXNew, b: (transpose(onedXNew)*!Y).flat)
        
        return betas
        
    }
    
//    func test(X:matrix) -> matrix{
//        
//        //let y:[Double] = [73,50,128,170,87,108,135,69,148,132]
//        //var Y = matrix(columns: 1, rows: y.count)
//        //Y.flat.grid = y
//        
//        return  X *! X
//        
//    }
}


