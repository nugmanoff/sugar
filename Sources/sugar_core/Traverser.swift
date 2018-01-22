//
//  Traverser
//  sugarPackageDescription
//
//  Created by Aidar Nugmanov on 1/22/18.
//

import Foundation
import Commander
import Files

class Traverser: Performable {
    
    private var runner = ScriptRunner()
    
    required init(with runner: ScriptRunner) {
        self.runner = runner
    }
    
    func perform(_ arguments: ArgumentConvertible...){
        do {
            try traverse()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func traverse() throws {
        let folder = try Folder.current
        let file = try folder.file(named: "Podfile")
        var contents = try file.readAsString()
        if let lastIndex = contents.lastIndex(of: "end") {
            contents.insert(contentsOf: "\n  pod 'SomePod'".characters, at: String.Index.init(encodedOffset: lastIndex - 1))
            print(contents)
            print(lastIndex)
        }
    }
}
