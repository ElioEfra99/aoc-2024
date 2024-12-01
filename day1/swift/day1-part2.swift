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

var similarityScore = 0

var numberToOccurrences: [Int: Int] = [:]
for num1 in list1 {
    var numberOccurrences = 0
    for num2 in list2 {
        if num2 == num1 {
            numberOccurrences += 1
        }
    }
    
    numberToOccurrences[num1] = numberOccurrences
}

for (key, value) in numberToOccurrences {
    similarityScore += key * value
}

print(similarityScore)
