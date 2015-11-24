# EERegression
General purpose multivaritate and quadratic Regression library for Swift 2.1


![regression gif](https://github.com/erkekin/EERegression/blob/master/EERegression/reg.gif?raw=true)
### Usage 
```swift
// X is one or multi column matrix, Y is a vector (o column matrix), degree is polynomial order. (1 for linear regression)
let regression = Regression(X: X, Y: Y, degree: degree)

let prediction = regression.predict(x)
```
### Test
All tests are located in EERegression.swift

For any idea or contribution, please DT me.
@erkekin

### Thanks
Scott for swix.
