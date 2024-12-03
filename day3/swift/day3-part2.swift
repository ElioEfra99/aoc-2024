import Foundation

let directoryPath = FileManager.default.currentDirectoryPath

let parentDirectoryPath = (directoryPath as NSString).deletingLastPathComponent  // Go one directory up
let filePath = parentDirectoryPath + "/input.txt"

let corruptedFile = try! String(contentsOfFile: filePath, encoding: .utf8)

let pattern = "(mul\\((\\d{1,3}),(\\d{1,3})\\)|do\\(\\)|don't\\(\\))"
var uncorruptedInstructionsSum = 0
let regex = try! NSRegularExpression(pattern: pattern, options: [])

var mulIsEnabled = true
regex.enumerateMatches(in: corruptedFile, options: [], range: NSRange(location: 0, length: corruptedFile.utf16.count)) { match, flags, stop in
    guard let match, let fullMatchRange = Range(match.range, in: corruptedFile) else { return }
    var matchedString = corruptedFile[fullMatchRange]
    
    if matchedString.contains("mul"), mulIsEnabled {
        let firstIndex = matchedString.startIndex
        let fourthIndex = matchedString.index(firstIndex, offsetBy: 4)
        matchedString.removeSubrange(firstIndex..<fourthIndex)
        
        let lastIndex = matchedString.endIndex
        let beforeLastIndex = matchedString.index(before: lastIndex)
        matchedString.removeSubrange(beforeLastIndex..<lastIndex)
        
        let array = Array(matchedString.split(separator: ","))
        let num1 = Int(array[0])!
        let num2 = Int(array[1])!
        
        uncorruptedInstructionsSum += num1 * num2
    } else if matchedString == "do()" {
        mulIsEnabled = true
    } else if matchedString == "don't()" {
        mulIsEnabled = false
    }
}

print(uncorruptedInstructionsSum)
