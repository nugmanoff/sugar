//
//  Group+Add.swift
//  sugarPackageDescription
//
//  Created by Aidar Nugmanov on 1/22/18.
//

import Commander

extension Group {
    func add(command: Command) {
        addCommand(command.name, command.description, command.wrapper)
    }
}
