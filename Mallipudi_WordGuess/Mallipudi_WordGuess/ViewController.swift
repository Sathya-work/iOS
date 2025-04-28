//
//  ViewController.swift
//  Mallipudi_WordGuess
//
//  Created by Sathyanarayana on 3/2/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var wordsGuessedLabel: UILabel!
    
    @IBOutlet weak var wordsRemainingLabel: UILabel!
    
    @IBOutlet weak var totalWordsLabel: UILabel!
    
    @IBOutlet weak var userGuessLabel: UILabel!
    
    @IBOutlet weak var guessLetterField: UITextField!
    
    @IBOutlet weak var guessALetterBtn: UIButton!
    
    @IBOutlet weak var hintLabel: UILabel!
    
    @IBOutlet weak var guessCountLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var playAgainButton: UIButton!
    
    @IBOutlet weak var displayImage: UIImageView!
    
    var words = [["JAVA", "Programming Language"],["DOG", "Animal"],["COLD", "Weather Condition"],["APPLE", "Fruit"],["HP","Laptop Brand"]]
    
    var currentWordIndex = 0
    var count = 0;
    var word = ""
    var lettersGuessed = ""
    var totalWords = 5
    var wordsGuessed = 0
    var maxNumOfWrongGuesses = 10
    var wrongGuesses = 0
    let letterEntered = ""
    var totalGuesses = 0
    var wordFlag = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playAgainButton.isHidden = true
        wordsGuessedLabel.text = "Total number of words guessed successfully: 0"
        wordsRemainingLabel.text = "Total number of words remaining in game: 5"
        totalWordsLabel.text = "Total number of words in game: \(words.count)"
        resetGame()
    }
    
    func resetGame() {
        
        if wrongGuesses == maxNumOfWrongGuesses && !userGuessLabel.text!.contains("_") {
                guessCountLabel.text = "Wow! You have made 10 guesses and guessed the word correctly!"
                playAgainButton.isHidden = false
                guessLetterField.isEnabled = false
                wordFlag = true
            }
            
            if currentWordIndex >= words.count {
                statusLabel.text = "Congratulations, You are done! Please start over again."
                wordsGuessedLabel.text = "Total number of words guessed successfully: \(wordsGuessed)"
                wordsRemainingLabel.text = "Total number of words remaining in game: 0"
                totalWordsLabel.text = "Total number of words in game: \(words.count)"
                playAgainButton.isHidden = false
                guessLetterField.isEnabled = false
                return
            }
            
            word = words[currentWordIndex][0]
            lettersGuessed = ""
            wrongGuesses = 0
            totalGuesses = 0
            guessCountLabel.text = "You have made Zero guesses"
            statusLabel.text = ""
            guessLetterField.text = ""
            guessLetterField.isEnabled = true
            playAgainButton.isHidden = true
            displayImage.image = nil
            hintLabel.text = "Hint: \(words[currentWordIndex][1])"
            
            updateWordDisplay()
        
        if currentWordIndex >= words.count {
            statusLabel.text = "Congratulations, You are done, Please start over again"
            playAgainButton.isHidden = false
            guessLetterField.isEnabled = false
            return
        }
        
        word = words[currentWordIndex][0]
        lettersGuessed = ""
        wrongGuesses = 0
        wordsGuessed = 0
        guessCountLabel.text = "You have made Zero guesses"
        statusLabel.text = ""
        guessLetterField.text = ""
        guessLetterField.isEnabled = true
        playAgainButton.isHidden = true
        displayImage.image = nil
        hintLabel.text = "Hint: \(words[currentWordIndex][1])"
        updateWordDisplay()
    }
    
    func updateWordDisplay() {
        userGuessLabel.text = ""
        
        for letter in word {
            if lettersGuessed.contains(letter) {
                userGuessLabel.text! += "\(letter) "
            } else {
                userGuessLabel.text! += "_ "
            }
        }
    }
    
    @IBAction func guessLetterButtonPressed(_ sender: UIButton) {
        
        guessALetterBtn.isEnabled = false
        let letter = guessLetterField.text?.uppercased()
        if letter == "" {
            return
        }
        
        if !lettersGuessed.contains(letter!) {
            lettersGuessed += letter!
        }
        
        totalGuesses+=1
        updateWordDisplay()
        
        if word.contains(letter!) {
            wrongGuesses += 1
            statusLabel.text = "Good guess!"
        }
        else {
            wrongGuesses += 1
            statusLabel.text = "Wrong guess. Try again."
        }
        
        if !userGuessLabel.text!.contains("_") {
                wordsGuessed += 1
                wordsGuessedLabel.text = "Total number of words guessed successfully: \(wordsGuessed)"
                wordsRemainingLabel.text = "Total number of words remaining in game: \(words.count - wordsGuessed)"
                
                if wordsGuessed == words.count {
                    statusLabel.text = "Congratulations, You are done! Please start over again."
                    wordsRemainingLabel.text = "Total number of words remaining in game: 0"
                    displayImage.image = UIImage(named: word)
                    playAgainButton.isHidden = false
                    guessLetterField.isEnabled = false
                } else {
                    statusLabel.text = "You've guessed it correctly! '\(word)'"
                    displayImage.image = UIImage(named: word)
                    playAgainButton.isHidden = false
                    guessLetterField.isEnabled = false
                }
            }
        
        if(wrongGuesses == maxNumOfWrongGuesses && !userGuessLabel.text!.contains("_"))
        {
            guessCountLabel.text = "Wow! You have made 10 guesses and guessed the word correctly!"
            playAgainButton.isHidden = false
            guessLetterField.isEnabled = false
        }
        else if wrongGuesses >= maxNumOfWrongGuesses
        {
            statusLabel.text = "You have used all the available guesses, Please play again."
            guessCountLabel.text = "You have made 10 guesses"
            guessLetterField.text = ""
            playAgainButton.isHidden = false
            guessLetterField.isEnabled = false
            return
        }
        else
        {
            guessCountLabel.text = "You have made \(totalGuesses) \(totalGuesses == 1 ? "guess": "guesses")"
        }

        guessLetterField.text = ""
    }
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        if wrongGuesses < maxNumOfWrongGuesses || !userGuessLabel.text!.contains("_") {
            currentWordIndex += 1
        }
        resetGame()
    }
    
    @IBAction func textFieldEditingChanged(_ textField: UITextField) {
        if let text = textField.text, text.count > 1 {
            textField.text = String(text.last!)
        }
        
        guessLetterField.text = textField.text
        guessALetterBtn.isEnabled = textField.text?.isEmpty == false
    }
    
}

