//
//  ScriptRunner.swift
//  sugarPackageDescription
//
//  Created by Aidar Nugmanov on 1/22/18.
//

import Foundation

public final class ScriptRunner {
    
    private var count = 0
    private let runLoop = RunLoop.current
    
    public func lock() {
        count += 1
    }
    public func unlock() {
        count -= 1
    }
    public func wait() {
        while count > 0 &&
            runLoop.run(mode: RunLoopMode.defaultRunLoopMode, before: Date(timeIntervalSinceNow: 0.1)) {
        }
    }
}
