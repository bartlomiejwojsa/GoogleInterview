import UIKit

var greeting = "Hello, playground"

func resolvePascalTriange(forRows rowsNum: Int) -> [[Int]] {
    if rowsNum < 1 {
        return []
    }
    var result = [[Int]]()
    // check current row len
    let firstRowNumbers = [1]
    var previousRowNumbers = [Int]()
    for i in 1...rowsNum {
        let currentRowNumbers = i == 1 ? firstRowNumbers : getRowNumbers(prevRowNumbers: previousRowNumbers)
        result.append(currentRowNumbers)
        previousRowNumbers = currentRowNumbers
    }
    return result
}

func getRowNumbers(prevRowNumbers: [Int]) -> [Int] {
    var result = [Int]()
    var calcRowNumbers = prevRowNumbers
    calcRowNumbers.insert(0, at: 0)
    calcRowNumbers.insert(0, at: calcRowNumbers.count)
    // every time base to calculation is like 0,x,x,x,x,x,...,0
    // and with that array we compute array
    print(calcRowNumbers)
    calcRowNumbers.enumerated().forEach { index,value in
        if index < calcRowNumbers.count-1 {
            result.append(value+calcRowNumbers[index+1])
        }
    }
    return result
}

resolvePascalTriange(forRows: 3)
