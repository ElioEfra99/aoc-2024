import Foundation

let directoryPath = FileManager.default.currentDirectoryPath

let parentDirectoryPath = (directoryPath as NSString).deletingLastPathComponent  // Go one directory up
let filePath = parentDirectoryPath + "/input.txt"

let fileContents = try! String(contentsOfFile: filePath, encoding: .utf8)

let fileParts = fileContents.split(separator: "\n\n")

let orderingRules = fileParts[0].components(separatedBy: "\n").map { $0.components(separatedBy: "|").map { Int($0)! } }
let pages = fileParts[1].components(separatedBy: "\n").map { $0.components(separatedBy: ",").map { Int($0)! } }


