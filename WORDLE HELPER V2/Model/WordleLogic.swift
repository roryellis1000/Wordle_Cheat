//
//  WordleLogic.swift
//  WORDLE HELPER V2
//
//  Created by Rory Ellis on 08/05/2022.
//

import UIKit

struct WordleLogic {
    var words = Words()
    var commonWords = [""]
    var wordNumber = 1
    
    mutating func contains(_ letter: String, wordSet: [String]) -> [String] {
        var wordss = wordSet
        if wordNumber > 1 {
            wordss = words.resetWords
            wordNumber = 1
        }
        let lowerLetter = letter.lowercased()
        wordss = wordSet.filter { $0.contains(lowerLetter)}
        
        return wordss
    }
    
    mutating func notContains(letter: String, wordSet: [String]) -> [String] {
        var wordss = wordSet
        if wordNumber > 1 {
            wordss = words.resetWords
            wordNumber = 1
        }
        let lowerLetter = letter.lowercased()
        wordss = wordss.filter { $0.contains(lowerLetter) == false}
        return wordss
    }
    
    mutating func letterAtPosition(letter: String, position: String, wordSet: [String]) -> [String] {
        var wordss = wordSet
        if wordNumber > 1 {
            wordss = words.resetWords
            wordNumber = 1
        }
        let lowerLetter = letter.lowercased()
        wordss = wordss.filter({ word in
            let arrayWord = Array(word)
                if arrayWord[Int(position)!] == Character(lowerLetter) {
                    return true
                } else {
                    return false
                }
            })
        return wordss
    }
    
    mutating func letterNotAtPosition(letter: String, position: String, wordSet: [String]) -> [String] {
        var wordss = wordSet
        if wordNumber > 1 {
            wordss = words.resetWords
            wordNumber = 1
        }
        let lowerLetter = letter.lowercased()
        wordss = wordss.filter({ word in
            let arrayWord = Array(word)
                if arrayWord[Int(position)!] != Character(lowerLetter) {
                    return true
                } else {
                    return false
                }
            })
        return wordss
    }
}

extension Array {
    
    func getAverage() -> Double {
        var total: Double = 0
        if self.count > 1 {
            
            for number in self {
                total += number as! Double
            }
        }
       
        return Double(total) / Double(5754)
    }
        
}
