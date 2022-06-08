//
//  ViewController.swift
//  WORDLE HELPER V2
//
//  Created by Rory Ellis on 08/05/2022.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
        
    @IBOutlet weak var availableWordsLabel: UILabel!
    @IBOutlet weak var wordTextField: UITextField!
    @IBOutlet weak var firstLetter: UIButton!
    @IBOutlet weak var secondLetter: UIButton!
    @IBOutlet weak var thirdLetter: UIButton!
    @IBOutlet weak var fourthLetter: UIButton!
    @IBOutlet weak var fifthLetter: UIButton!
    
    var words = Words()
    var wordleLogic = WordleLogic()
    var correctLetters: [String] = []
    let colours = [ #colorLiteral(red: 1, green: 0.768627451, blue: 0.1450980392, alpha: 1), #colorLiteral(red: 0.05490196078, green: 0.8392156863, blue: 0.2666666667, alpha: 1), #colorLiteral(red: 0.4280608296, green: 0.4266190529, blue: 0.4291911125, alpha: 1), ]
    var buttonArray: [UIButton]?
    var allOutcomes: [[UIColor]] = []
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        buttonArray = [firstLetter, secondLetter, thirdLetter, fourthLetter, fifthLetter]
        wordTextField.delegate = self
        for button in buttonArray! {
            button.backgroundColor = #colorLiteral(red: 0.4280608296, green: 0.4266190529, blue: 0.4291911125, alpha: 1)
        }
        words.fiveLetterWords = sort()

        for word in words.startingWords {
            availableWordsLabel.text?.append("\(word)\n")
        }
    }
    
    
    @IBAction func colourPressed(_ sender: UIButton) {
        if sender.backgroundColor == #colorLiteral(red: 0.4280608296, green: 0.4266190529, blue: 0.4291911125, alpha: 1) {
            sender.backgroundColor = #colorLiteral(red: 1, green: 0.768627451, blue: 0.1450980392, alpha: 1)
        } else if sender.backgroundColor == #colorLiteral(red: 1, green: 0.768627451, blue: 0.1450980392, alpha: 1) {
            sender.backgroundColor = #colorLiteral(red: 0.05490196078, green: 0.8392156863, blue: 0.2666666667, alpha: 1)
        } else {
            sender.backgroundColor = #colorLiteral(red: 0.4280608296, green: 0.4266190529, blue: 0.4291911125, alpha: 1)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        wordTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        let usersWord = textField.text
        if usersWord?.count == 5 {
            return true
        } else {
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let userWord = textField.text!
        let userWordArray = Array(userWord)
        textField.text = ""
        var i = 0
        for button in buttonArray! {
            button.setTitle(String(userWordArray[i]), for: .normal)
            i += 1
        }
    
    }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        
        if let buttons = buttonArray {
            checkColours(senders: buttons)
        }
        words.fiveLetterWords = sort()

        displayWords()
        
        for button in buttonArray! {
            button.backgroundColor = #colorLiteral(red: 0.4280608296, green: 0.4266190529, blue: 0.4291911125, alpha: 1)
            button.setTitle("", for: .normal)
        }
    }
    
    func displayWords() {
        availableWordsLabel.text = ""
        if words.fiveLetterWords.count >= 20 {
            for number in 1...20 {
                availableWordsLabel.text?.append("\(words.fiveLetterWords[number])\n")
            }
        } else {
            for word in words.fiveLetterWords {
                availableWordsLabel.text?.append("\(word)\n")
            }
        }
    }
    
    func checkColours(senders: [UIButton]) {
        for sender in senders {
            if let title = sender.currentTitle {
                if let position = buttonArray?.firstIndex(of: sender) as? Int {
                    let positionString = String(position)
                    
                    switch sender.backgroundColor {
                    case #colorLiteral(red: 1, green: 0.768627451, blue: 0.1450980392, alpha: 1):
                        words.fiveLetterWords = wordleLogic.letterNotAtPosition(letter: title, position: positionString, wordSet: words.fiveLetterWords)
                        words.fiveLetterWords = wordleLogic.contains(title, wordSet: words.fiveLetterWords)
                        correctLetters.append(title)
                    case #colorLiteral(red: 0.05490196078, green: 0.8392156863, blue: 0.2666666667, alpha: 1):
                        words.fiveLetterWords = wordleLogic.letterAtPosition(letter: title, position: positionString, wordSet: words.fiveLetterWords)
                        correctLetters.append(title)
                    default:
                        if correctLetters.contains(title.uppercased()) == false {
                            words.fiveLetterWords = wordleLogic.notContains(letter: title, wordSet: words.fiveLetterWords)
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func resetPressed(_ sender: UIButton) {
        words.fiveLetterWords = words.resetWords
        correctLetters = []
        for button in buttonArray! {
            button.backgroundColor = #colorLiteral(red: 0.4280608296, green: 0.4266190529, blue: 0.4291911125, alpha: 1)
            button.setTitle("", for: .normal)
        }
    }
    func reset() {
        
    }
    
    func sort() -> [String] {
        if words.fiveLetterWords.count > 1 {
            var i = 1
            repeat {
                if words.informationDictionary[words.fiveLetterWords[i]]! > words.informationDictionary[words.fiveLetterWords[i - 1]]! {
                    words.fiveLetterWords.swapAt(i, i - 1)
                    if i != 1 {
                        i -= 1
                    }
                } else {
                    i += 1
                }
            } while i < words.fiveLetterWords.count
        }
        return words.fiveLetterWords
    }
}
