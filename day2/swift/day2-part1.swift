import Foundation

let directoryPath = FileManager.default.currentDirectoryPath

// Go back one directory (use ".." to navigate up)
let parentDirectoryPath = (directoryPath as NSString).deletingLastPathComponent  // Go one directory up
let filePath = parentDirectoryPath + "/input.txt"

let fileContents = try! String(contentsOfFile: filePath, encoding: .utf8).components(separatedBy: "\n")

let reports = fileContents.map { $0.split(separator: " ").compactMap { Int($0)} }
let differenceWithinRange: (Int, Int) -> Bool = { left, right in
    let difference = abs(left - right)
    
    return (1...3).contains(difference)
}

let doesNotSatisfyRules: (Int, Int, Bool) -> Bool = { left, right, isAscending in
    if isAscending {
        return left > right || !differenceWithinRange(left, right)
    } else {
        return left < right || !differenceWithinRange(left, right)
    }
}

print(reports.reduce(0) { x, report in
    var isAscending = false
    
    let firstLevel = report[0]
    let secondLevel = report[1]
    
    if firstLevel == secondLevel {
        return unsafe()
    } else if firstLevel < secondLevel {
        isAscending = true
    }
    guard differenceWithinRange(firstLevel, secondLevel) else { return unsafe() }
    
    for index in 1 ..< report.count - 1 {
        let leftLevel = report[index]
        let rightLevel = report[index + 1]
        
        if doesNotSatisfyRules(leftLevel, rightLevel, isAscending) { return unsafe() }
    }
    
    return safe(acc: x)
})

private func safe(acc value: Int) -> Int {
    value + 1
}

private func unsafe() -> Int {
    0
}
