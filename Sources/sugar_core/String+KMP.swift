//
//  String+KMP.swift
//  sugarPackageDescription
//
//  Created by Aidar Nugmanov on 1/22/18.
//

import Foundation

extension String {
    
    func lastIndex(of ptrn: String) -> Int? {
        guard let indexes = indexesOf(ptrn: ptrn) else {
            return nil
        }
        return indexes.last
    }
    
    fileprivate func indexesOf(ptrn: String) -> [Int]? {
        
        let text = Array(self.characters)
        let pattern = Array(ptrn.characters)
        
        let textLength: Int = text.count
        let patternLength: Int = pattern.count
        
        guard patternLength > 0 else {
            return nil
        }
        
        var suffixPrefix: [Int] = [Int](repeating: 0, count: patternLength)
        var textIndex: Int = 0
        var patternIndex: Int = 0
        var indexes: [Int] = [Int]()
        
        let zeta = zetaAlgorithm(ptrn: ptrn)
        
        for patternIndex in (1 ..< patternLength).reversed() {
            textIndex = patternIndex + zeta![patternIndex] - 1
            suffixPrefix[textIndex] = zeta![patternIndex]
        }
        
        textIndex = 0
        patternIndex = 0
        
        while textIndex + (patternLength - patternIndex - 1) < textLength {
            
            while patternIndex < patternLength && text[textIndex] == pattern[patternIndex] {
                textIndex += 1
                patternIndex += 1
            }
            
            if patternIndex == patternLength {
                indexes.append(textIndex - patternIndex)
            }
            
            if patternIndex == 0 {
                textIndex += 1
            } else {
                patternIndex = suffixPrefix[patternIndex - 1]
            }
        }
        
        guard !indexes.isEmpty else {
            return nil
        }
        return indexes
    }
}
