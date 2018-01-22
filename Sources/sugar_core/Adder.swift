//
//  Adder
//  sugarPackageDescription
//
//  Created by Aidar Nugmanov on 1/22/18.
//

import Foundation
import Commander
import Files

// MARK: - AdderError

public enum AdderError {
    case failedToLocatePodfile
    case failedToReadContents
    case corruptedStructureError
    case failedToUpdatePodfile
}

extension AdderError: PrintableError {
    public var message: String {
        switch self {
        case .failedToLocatePodfile:
            return "Decoding error occurred"
        case .failedToReadContents:
            return "Network error occurred"
        case .corruptedStructureError:
            return ""
        case .failedToUpdatePodfile:
            return ""
        }
    }
}

// MARK: - Adder

class Adder: Performable {

    private var runner = ScriptRunner()
    private typealias Error = AdderError

    required init(with runner: ScriptRunner) {
        self.runner = runner
    }

    public func perform(_ arguments: ArgumentConvertible...) {
        let version = arguments[0] as! Double
        perform(version: version)
    }
    
    private func perform(version: Double) {

    }
    
    private func addPod(_ pod: String, with version: Double) {
        do {
            var podfile = try getContents()
            let index = try getIndex(for: podfile)
            var entry = "\n  pod '\(pod)'"
            entry += (version != -1.0 ? ", '~> \(version)'" : "")
            podfile.insert(contentsOf: entry.characters, at: String.Index.init(encodedOffset: index))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func updatePodfile(with contents: String) throws {
        guard let file = try? Folder.current.file(named: "Podfile") else {
            throw Error.failedToLocatePodfile
        }
        do {
            try file.write(data: contents.data(using: .utf8)!)
        } catch {
            throw Error.failedToUpdatePodfile
        }
    }
    
    private func getIndex(for podfile: String) throws -> Int {
        guard let lastIndex = podfile.lastIndex(of: "end") else {
            throw Error.corruptedStructureError
        }
        return lastIndex - 1
    }
    
    private func getContents() throws -> String {
        guard let file = try? Folder.current.file(named: "Podfile") else {
            throw Error.failedToLocatePodfile
        }
        guard let contents = try? file.readAsString() else {
            throw Error.failedToReadContents
        }
        return contents
    }
}
