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
            return "Failed to located Podfile in the current directory."
        case .failedToReadContents:
            return "Failed to read contents of Podfile."
        case .corruptedStructureError:
            return "Corrupted structure of Podfile detected."
        case .failedToUpdatePodfile:
            return "Failed to update Podfile."
        }
    }
}

// MARK: - Adder

public final class Adder {

    private var runner = ScriptRunner()
    private typealias Error = AdderError
    
    // MARK: - Init

    public init() {
    }

    public func perform(pod: String, version: Double, path: String) {
        addPod(pod, with: version, and: path)
    }
    
    // MARK: - Private

    private func addPod(_ pod: String, with version: Double, and path: String) {
        do {
            var podfile = try getContents(from: path)
            let index = try getIndex(for: podfile)
            var entry = "\n  pod '\(pod)'"
            entry += (version != -1.0 ? ", '~> \(version)'" : "")
            podfile.insert(contentsOf: entry.characters, at: String.Index.init(encodedOffset: index))
            try updatePodfile(with: podfile, at: path)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func updatePodfile(with contents: String, at path: String) throws {
        guard let file = try? Folder(path: path).file(named: "Podfile") else {
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
    
    private func getContents(from path: String) throws -> String {
        guard let file = try? Folder(path: path).file(named: "Podfile") else {
            throw Error.failedToLocatePodfile
        }
        guard let contents = try? file.readAsString() else {
            throw Error.failedToReadContents
        }
        return contents
    }
}
