import Foundation

let directoryPath = FileManager.default.currentDirectoryPath

let parentDirectoryPath = (directoryPath as NSString).deletingLastPathComponent  // Go one directory up
let filePath = parentDirectoryPath + "/input.txt"

let grid = try! String(contentsOfFile: filePath, encoding: .utf8).components(separatedBy: "\n").map { $0.split(separator: "").map { String($0) } }

func isXMas(_ a: String, _ b: String, _ c: String, _ d: String) -> Bool {
    return (a == "X" && b == "M" && c == "A" && d == "S") || (a == "S" && b == "A" && c == "M" && d == "X")
}

func isX_Mas(_ ul: String, _ ur: String, _ m: String, _ dl: String, _ dr: String) -> Bool {
    return ((ul == "M" && m == "A" && dr == "S") || (ul == "S" && m == "A" && dr == "M")) && ((dl == "M" && m == "A" && ur == "S") || (dl == "S" && m == "A" && ur == "M"))
}

var xMasOccurrences = 0

// Diagonal left to right
for row in 0..<grid.count - 2 {
    for col in 0..<grid[row].count - 2 {
        if isX_Mas(grid[row][col], grid[row][(col + 2)], grid[(row + 1)][(col + 1)], grid[(row + 2)][col], grid[(row + 2)][(col + 2)]) { xMasOccurrences += 1 }
    }
}

print(xMasOccurrences)
