//
//  Command.swift
//  sugarPackageDescription
//
//  Created by Aidar Nugmanov on 1/22/18.
//

import Foundation
import Commander

internal enum Command: String {
    case add
}

extension Command {
    
    var name: String {
        switch self {
        case .add:
            return "add"
        }
    }
    
    var description: String {
        switch self {
        case .add:
            return "Add pod entry to Podfile"
        }
    }
    
    var task: Performable {
        let runner = ScriptRunner()
        switch self {
        case .add:
            return Adder(with: runner)
        }
    }
    
    var wrapper: CommandType {
        switch self {
        case .add:
            return command(
                Option("version", default: -1.0, flag: "v", description: "Specified version of pod to install.")) { version in
                        self.task.perform(version)
            }
        }
    }
}
