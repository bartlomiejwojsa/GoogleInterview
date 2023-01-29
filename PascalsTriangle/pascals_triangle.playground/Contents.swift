import UIKit

//MARK: - Possible Errors
enum ComputingError: Error {
    case intOverflow(lastAvailableNumber: Int)
}

//MARK: - Solution
func resolvePascalTriange(forRows rowsNum: Int) -> [[Int]] {
    if rowsNum < 1 {
        return []
    }
    var result = [[Int]]()
    let firstRowNumbers = [1]
    var previousRowNumbers = [Int]()
    do {
        for i in 1...rowsNum {
            let currentRowNumbers = i == 1 ? firstRowNumbers : try getRowNumbers(prevRowNumbers: previousRowNumbers)
            result.append(currentRowNumbers)
            previousRowNumbers = currentRowNumbers
        }
    } catch ComputingError.intOverflow(let lastAvailableNumber) {
        print("Passed rows number (\(rowsNum)) is to big. Last correctly computed triangle element: \(lastAvailableNumber)")
    } catch {
        print("Unexpected error", error)
    }
    
    return result
}

func getRowNumbers(prevRowNumbers: [Int]) throws -> [Int] {
    var result = [Int]()
    var calcRowNumbers = prevRowNumbers
    // let put 0 on beggining & end of input array to compute new array as its always larger by 1
    calcRowNumbers.insert(0, at: 0)
    calcRowNumbers.insert(0, at: calcRowNumbers.count)
    
    var preOverflowNumber: Int?
    calcRowNumbers.enumerated().forEach { index,value in
        if preOverflowNumber != nil { return }
        if index < calcRowNumbers.count-1 {
            if case let (newNumber, overflow) = value.addingReportingOverflow(calcRowNumbers[index+1]), !overflow {
                result.append(newNumber)
            } else {
                preOverflowNumber = value
            }
        }
    }
    if let overflowNumber = preOverflowNumber {
        throw ComputingError.intOverflow(lastAvailableNumber: overflowNumber)
        
    }
    return result
}

//MARK: - Tests

resolvePascalTriange(forRows: -10)
resolvePascalTriange(forRows: 0)
resolvePascalTriange(forRows: 1)
resolvePascalTriange(forRows: 3)
resolvePascalTriange(forRows: 5)
resolvePascalTriange(forRows: 60)
resolvePascalTriange(forRows: 68)
resolvePascalTriange(forRows: 100)

