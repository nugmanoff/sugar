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
    
    var wrapper: CommandType {
        switch self {
        case .add:
            return command(
                Argument<String>("pod", description: "Name of the pod to add."),
                Option("version", default: -1.0, flag: "v", description: "Specified version of pod to install."),
                Option("path", default: ".", flag: "p", description: "Specified path to Podfile.")) { pod, version, path in
                    Adder().perform(pod: pod, version: version, path: path)
            }
        }
    }
}
