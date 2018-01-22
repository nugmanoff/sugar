//
//  Performable.swift
//  sugarPackageDescription
//
//  Created by Aidar Nugmanov on 1/22/18.
//

import Commander

internal protocol Performable {
    init(with runner: ScriptRunner)
    func perform(_ arguments: ArgumentConvertible...)
}
