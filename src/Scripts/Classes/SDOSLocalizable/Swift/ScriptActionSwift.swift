//
//  ScriptActionSwift.swift
//  SDOSL10n
//
//  Created by Rafael Fernandez Alvarez on 27/03/2019.
//  Copyright © 2019 Rafael Fernandez Alvarez. All rights reserved.
//

import Foundation

@objc public class ScriptActionSwift: NSObject {
    public var disableInputOutputFilesValidation = false
    public var unlockFiles = false
    public var outputDirectory: String
    public var pwd: String
    
    @objc public required init(outputDirectory: String, pwd: String, unlockFiles: Bool, disableInputOutputFilesValidation: Bool) {
        self.outputDirectory = outputDirectory
        self.pwd = pwd
        self.unlockFiles = unlockFiles
        self.disableInputOutputFilesValidation = disableInputOutputFilesValidation
    }
    
}

public extension ScriptActionSwift {
    enum TypeParams: String {
        case INPUT_FILE
        case INPUT_FILE_LIST
        case OUTPUT_FILE
        case OUTPUT_FILE_LIST
    }
    
    @objc func validateInputOutput(output: String) {
        guard !disableInputOutputFilesValidation else {
            return
        }
        if let tmpDir = ProcessInfo.processInfo.environment["TEMP_DIR"] {
            checkInput(params: parseParams(type: .INPUT_FILE) + parseParams(type: .INPUT_FILE_LIST), sources: ["\(tmpDir)/SDOSL10n-lastrun"])
        }
        checkOutput(params: parseParams(type: .OUTPUT_FILE) + parseParams(type: .OUTPUT_FILE_LIST), sources: [output])
    }
    
    func parseParams(type: TypeParams) -> [String] {
        var params = [String]()
        if let numString = ProcessInfo.processInfo.environment["SCRIPT_\(type.rawValue)_COUNT"] {
            if let num = Int(numString) {
                for i in 0...num {
                    if let param = ProcessInfo.processInfo.environment["SCRIPT_\(type.rawValue)_\(i)"] {
                        if param.hasSuffix(".files") || param.hasSuffix(".xcfilelist") || type == .INPUT_FILE_LIST || type == .OUTPUT_FILE_LIST {
                            if let fileContent = try? String(contentsOfFile: param) {
                                fileContent.split(separator: "\n").map(String.init).forEach {
                                    if !$0.hasPrefix("#") {
                                        params.append(resolvePath(path: $0))
                                    }
                                }
                            }
                        } else {
                            params.append(resolvePath(path: param))
                        }
                    }
                }
            }
        }
        return params
    }
    
    func checkInput(params: [String], sources: [String]) {
        checkInputOutput(params: params, sources: sources, message: "Build phase Intput Files does not contain")
    }
    
    func checkOutput(params: [String], sources: [String]) {
        checkInputOutput(params: params, sources: sources, message: "Build phase Output Files does not contain")
    }
    
    func checkInputOutput(params: [String], sources: [String], message: String) {
        for source in sources {
            let realSource = resolvePath(path: source)
            if !params.contains(realSource) {
                print("[SDOSL10n] - \(message) '\(source.replacingOccurrences(of: pwd, with: "${SRCROOT}"))'.")
                exit(7)
            }
        }
    }
    
    func resolvePath(path: String) -> String {
        var arrayComponents: [String] = path.components(separatedBy: "/").reversed()
        var numComponentsToDelete = 0
        arrayComponents = arrayComponents.compactMap { item -> String? in
            if item == ".." {
                numComponentsToDelete += 1
                return nil
            } else {
                if numComponentsToDelete != 0 {
                    numComponentsToDelete -= 1
                    return nil
                } else {
                    return item
                }
            }
        }
        return arrayComponents.reversed().joined(separator: "/")
    }
}

public extension ScriptActionSwift {
    @objc func unlockFile(_ path: String) {
        if FileManager.default.fileExists(atPath: path) {
            shell("-c", "chmod 644 \(path)")
        }
    }
    
    @objc func lockFile(_ path: String) {
        guard !unlockFiles else {
            return
        }
        if FileManager.default.fileExists(atPath: path) {
            shell("-c", "chmod 444 \(path)")
        }
    }
    
    @objc func createTempFile() {
        if let tmpDir = ProcessInfo.processInfo.environment["TEMP_DIR"] {
            shell("-c", "date > \(tmpDir)/SDOSL10n-lastrun")
        }
    }
    
    @discardableResult
    func shell(_ args: String...) -> Int32 {
        let task = Process()
        task.launchPath = "/bin/bash"
        task.arguments = args
        task.launch()
        task.waitUntilExit()
        return task.terminationStatus
    }
}
