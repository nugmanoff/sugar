//
//  Command.swift
//  indexifyPackageDescription
//
//  Created by Aidar Nugmanov on 1/4/18.
//

import Foundation
import Commander
import Releases

// MARK: - Error

public enum CommandManagerError {
    case failedToResolveVersion
}

extension CommandManagerError: PrintableError {
    public var message: String {
        switch self {
        case .failedToResolveVersion:
            return "Failed to resolve release version"
        }
    }
}

// MARK: - CommandManager

public final class CommandManager {
    
    private typealias Error = CommandManagerError
    
    private var version = String()
    private var group = Group()
    private var repo = "https://github.com/nugmanoff/indexify.git"
    
    // MARK: - Init
    
    public init() {
        resolveCommands()
        resolveVersion()
    }
    
    public convenience init(with version: String) {
        self.init()
        self.version = version
    }
    
    public func run() {
        group.run(version)
    }
    
    // MARK: - Private
    
    private func resolveCommands() {
        group.add(command: .add)
    }
    
    private func resolveVersion() {
        do {
            let url = URL(string: repo)!
            let releases = try! Releases.versions(for: url)
            guard let latestRelease = releases.last?.string else {
                throw Error.failedToResolveVersion
            }
            version = latestRelease
        } catch {
            print(Error.failedToResolveVersion)
        }
    }
}
