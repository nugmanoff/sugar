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
            return "eval"
        }
    }
    
    var description: String {
        switch self {
        case .add:
            return "Evaluate deposit splitting using current Market Cap"
        }
    }
    
    var task: Performable {
        let runner = ScriptRunner()
        switch self {
        case .add:
            return Traverser(with: runner)
        }
    }
    
    var wrapper: CommandType {
        switch self {
        case .add:
            return command(
                Option("amount", default: 100.0, flag: "a", description: "Amount of money (USD) to invest."),
                Option("threshold", default: 3.0, flag: "t", description: "Threshold percentage of Total " +
                    "Market Cap Index of currency.")) { amount, threshold in
                        self.task.perform(amount, threshold)
            }
        }
    }
}
