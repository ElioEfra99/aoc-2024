import Foundation

let directoryPath = FileManager.default.currentDirectoryPath

// Go back one directory (use ".." to navigate up)
let parentDirectoryPath = (directoryPath as NSString).deletingLastPathComponent  // Go one directory up
let filePath = parentDirectoryPath + "/input.txt"

let fileContents = try! String(contentsOfFile: filePath, encoding: .utf8)

let pairs = fileContents
    .components(separatedBy: "\n")
    .map { $0.split(separator: " ") }

var list1 = [Int]()
var list2 = [Int]()

for pair in pairs {
    list1.append(Int(pair[0])!)
    list2.append(Int(pair[1])!)
}

list1.sort()
list2.sort()

var totalDistance = 0
for i in 0..<list1.count {
    totalDistance += abs(list1[i] - list2[i])
}

print(totalDistance)
