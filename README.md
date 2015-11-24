# EERegression
General purpose multivariate linear and quadratic Regression library for Swift 2.1.


![regression gif](https://github.com/erkekin/EERegression/blob/master/EERegression/reg.gif?raw=true)

### Usage 
```swift
// X is one or multi column matrix, Y is a vector (o column matrix)
//degree is polynomial order. (1 for linear regression)
let regression = Regression(X: X, Y: Y, degree: degree)

let prediction = regression.predict(x)
```
### Test
EERegression.swift includes regression coefficients and prediction tests.

For any idea or contribution, please DT me.
@erkekin

### Thanks
Scott for swix.
