import Foundation

let directoryPath = FileManager.default.currentDirectoryPath

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

var totalSafeReportCount = 0
for report in reports {
    print("Inspecting report \(report)")
    var safeReportCount = 0
    for index in 0 ..< report.count {
        var variantReport = report
        variantReport.remove(at: index)
        
        if isReportSafe(variantReport) {
            print("Variant report \(variantReport) from original \(report) seems to be safe")
            safeReportCount += 1
        }
    }
    
    if safeReportCount >= 1 {
        print("Report \(report) is safe, increasing count by 1...")
        totalSafeReportCount += 1
    }
}
print(totalSafeReportCount)

private func isReportSafe(_ report: [Int]) -> Bool {
    var isAscending: Bool?
    
    for index in 0 ..< report.count - 1 {
        let leftLevel = report[index]
        let rightLevel = report[index + 1]
        
        if let isAscending {
            if doesNotSatisfyRules(leftLevel, rightLevel, isAscending) { return false }
        } else {
            guard leftLevel != rightLevel else {
                return false
            }
            
            isAscending = leftLevel < rightLevel
            if doesNotSatisfyRules(leftLevel, rightLevel, isAscending!) { return false }
        }
    }
    
    return true
}

private func safe(acc value: Int) -> Int {
    value + 1
}

private func unsafe() -> Int {
    0
}
