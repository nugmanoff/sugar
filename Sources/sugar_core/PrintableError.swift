//
//  PrintableError.swift
//  sugarPackageDescription
//
//  Created by Aidar Nugmanov on 1/22/18.
//

import Foundation

public protocol PrintableError: Error, Equatable, CustomStringConvertible {
    var message: String { get }
}

public extension PrintableError {
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.message == rhs.message
    }
    
    var description: String {
        let description = "💥  \(message)"
        return description
    }
}
