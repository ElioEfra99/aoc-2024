import Foundation

let directoryPath = FileManager.default.currentDirectoryPath

let parentDirectoryPath = (directoryPath as NSString).deletingLastPathComponent  // Go one directory up
let filePath = parentDirectoryPath + "/input.txt"

let grid = try! String(contentsOfFile: filePath, encoding: .utf8).components(separatedBy: "\n").map { $0.split(separator: "").map { String($0) } }

func isXMas(_ a: String, _ b: String, _ c: String, _ d: String) -> Bool {
    return (a == "X" && b == "M" && c == "A" && d == "S") || (a == "S" && b == "A" && c == "M" && d == "X")
}

var xMasOccurrences = 0

// Horizontal
for row in 0..<grid.count {
    for col in 0..<grid[row].count - 3 {
        if isXMas(grid[row][col], grid[row][(col + 1)], grid[row][(col + 2)], grid[row][(col + 3)]) { xMasOccurrences += 1 }
    }
}

// Vertical
for row in 0..<grid.count - 3 {
    for col in 0..<grid[row].count {
        if isXMas(grid[row][col], grid[row + 1][col], grid[row + 2][col], grid[row + 3][col]) { xMasOccurrences += 1 }
    }
}

// Diagonal left to right
for row in 0..<grid.count - 3 {
    for col in 0..<grid[row].count - 3 {
        if isXMas(grid[row][col], grid[row + 1][col + 1], grid[row + 2][col + 2], grid[row + 3][col + 3]) { xMasOccurrences += 1 }
    }
}

// Diagonal right to left
for row in 0..<grid.count - 3 {
    for col in stride(from: grid.count - 1, through: 3, by: -1) {
        if isXMas(grid[row][col], grid[row + 1][col - 1], grid[row + 2][col - 2], grid[row + 3][col - 3]) { xMasOccurrences += 1 }
    }
}

print(xMasOccurrences)

// FLAWED: For some reason I couldn't spot while debugging ¯\_(ツ)_/¯
// It seems like the count was a bit lower as compared to the solution above

//var xOccurrences = 0
//for row in 0..<grid.count {
//    for col in 0..<grid[row].count {
//        // When X is our current [row][col], we start looking for the word in all directions
//        if grid[row][col] == "X" {
//            xOccurrences += 1
//            wordOccurrences += searchWord(from: row, and: col)
//        }
//    }
//}
//
//private func searchWord(from row: Int, and col: Int) -> Int {
//    var count = 0
//    if isWordUp(row, col) { count += 1 }
//    if isWordRightUp(row, col) { count += 1 }
//    if isWordRight(row, col) { count += 1 }
//    if isWordRightDown(row, col) { count += 1 }
//    if isWordDown(row, col) { count += 1 }
//    if isWordLeftDown(row, col) { count += 1 }
//    if isWordLeft(row, col) { count += 1 }
//    if isWordLeftUp(row, col) { count += 1 }
//    return count
//}
//
//enum Direction {
//    case up
//    case rightUp
//    case right
//    case rightDown
//    case down
//    case leftDown
//    case left
//    case leftUp
//}
//
//private func isWordUp(_ row: Int, _ col: Int) -> Bool {
//    for (index, char) in "MAS".enumerated() {
//        let stepsUp = index
//        
//        if isLocationSafe(row - stepsUp, col: col, pointing: .up) {
//            if grid[(row - stepsUp - 1)][col] != String(char) {
//                return false
//            }
//        } else {
//            return false
//        }
//    }
//    
//    return true
//}
//
//private func isWordRightUp(_ row: Int, _ col: Int) -> Bool {
//    for (index, char) in "MAS".enumerated() {
//        let stepsUp = index
//        let stepsRight = index
//        
//        if isLocationSafe(row - stepsUp, col: col + stepsRight, pointing: .rightUp) {
//            if grid[(row - stepsUp - 1)][(col + stepsRight + 1)] != String(char) {
//                return false
//            }
//        } else {
//            return false
//        }
//    }
//
//    return true
//}
//
//private func isWordRight(_ row: Int, _ col: Int) -> Bool {
//    for (index, char) in "MAS".enumerated() {
//        let stepsRight = index
//        
//        if isLocationSafe(row, col: col + stepsRight, pointing: .right) {
//            if grid[row][(col + stepsRight + 1)] != String(char) {
//                return false
//            }
//        } else {
//            return false
//        }
//    }
//    
//    return true
//}
//
//private func isWordRightDown(_ row: Int, _ col: Int) -> Bool {
//    for (index, char) in "MAS".enumerated() {
//        let stepsRight = index
//        let stepsDown = index
//        
//        if isLocationSafe(row + stepsDown, col: col + stepsRight, pointing: .rightDown) {
//            if grid[(row + stepsDown + 1)][(col + stepsRight + 1)] != String(char) {
//                return false
//            }
//        } else {
//            return false
//        }
//    }
//    
//    return true
//}
//
//private func isWordDown(_ row: Int, _ col: Int) -> Bool {
//    for (index, char) in "MAS".enumerated() {
//        let stepsDown = index
//        
//        if isLocationSafe(row + stepsDown, col: col, pointing: .down) {
//            if grid[(row + stepsDown + 1)][col] != String(char) {
//                return false
//            }
//        } else {
//            return false
//        }
//    }
//    
//    return true
//}
//
//private func isWordLeftDown(_ row: Int, _ col: Int) -> Bool {
//    for (index, char) in "MAS".enumerated() {
//        let stepsDown = index
//        let stepsLeft = index
//        
//        if isLocationSafe(row + stepsDown, col: col - stepsLeft, pointing: .leftDown) {
//            if grid[(row + stepsDown + 1)][(col - stepsLeft - 1)] != String(char) {
//                return false
//            }
//        } else {
//            return false
//        }
//    }
//    
//    return true
//}
//
//private func isWordLeft(_ row: Int, _ col: Int) -> Bool {
//    for (index, char) in "MAS".enumerated() {
//        let stepsLeft = index
//        
//        if isLocationSafe(row, col: col - stepsLeft, pointing: .left) {
//            if grid[row][(col - stepsLeft - 1)] != String(char) {
//                return false
//            }
//        } else {
//            return false
//        }
//    }
//    
//    return true
//}
//
//private func isWordLeftUp(_ row: Int, _ col: Int) -> Bool {
//    for (index, char) in "MAS".enumerated() {
//        let stepsLeft = index
//        let stepsUp = index
//        
//        if isLocationSafe(row - stepsUp, col: col - stepsLeft, pointing: .leftUp) {
//            if grid[(row - stepsUp - 1)][(col - stepsLeft - 1)] != String(char) {
//                return false
//            }
//        } else {
//            return false
//        }
//    }
//    
//    return true
//}
//
//private func isLocationSafe(_ row: Int, col: Int, pointing inDirection: Direction) -> Bool {
//    let rightBounds = grid[0].count
//    let upperBounds = 0
//    let bottomBounds = grid.count
//    let leftBounds = 0
//    
//    switch inDirection {
//    case .up:
//        return (row - 1) >= upperBounds
//    case .rightUp:
//        return (row - 1) >= upperBounds && (col + 1) < rightBounds
//    case .right:
//        return (col + 1) < rightBounds
//    case .rightDown:
//        return (col + 1) < rightBounds && (row + 1) < bottomBounds
//    case .down:
//        return (row + 1) < bottomBounds
//    case .leftDown:
//        return (col - 1) > leftBounds && (row + 1) < bottomBounds
//    case .left:
//        return (col - 1) > leftBounds
//    case .leftUp:
//        return (col - 1) > leftBounds && (row - 1) >= upperBounds
//    }
//}

