//
//  ViewController.swift
//  WordGuessApp
//
//  Created by Sathyanarayana on 2/13/25.
//

import UIKit

class ViewController: UIViewController {
      
    @IBOutlet weak var displayOL: UILabel!
    
    @IBOutlet weak var hintOL: UILabel!
    
    @IBOutlet weak var guessOL: UITextField!
    
    @IBOutlet weak var checkBtnOL: UIButton!
    
    @IBOutlet weak var congratsOL: UILabel!
    
    @IBOutlet weak var playAgainOL: UIButton!
    
    //Declare variables and store and array of data
    var words = [["JAVA", "Programming Language"],["DOG", "Animal"],["COLD", "Weather Condition"],["APPLE", "Fruit"]]
    
    var count = 0;
    var word = ""
    var lettersGuessed = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Disable check button
        checkBtnOL.isEnabled = false
        word = words[count][0]
        
        displayOL.text = ""
        for letter in word {
            displayOL.text!.append(" _")
        }
        hintOL.text = "Hint: " + words[count][1]
        congratsOL.text = ""
    }
    
    @IBAction func checkBtnClick(_ sender: UIButton) {
        //read input from texxt field and store it
        var letters = guessOL.text!
        //store all the input given by the user
        lettersGuessed += letters
        var newDisplay = ""
        for letter in word {
            if lettersGuessed.contains(String(letter)) {
                newDisplay += "\(letter)"
            } else {
                newDisplay += "_ "
            }
        }
        //Change value in the displayOL with new value and make the text field empty again
        displayOL.text = newDisplay
        guessOL.text = ""
        
        //Condition for enabling and Hiding playagain and check buttons
        if displayOL.text?.contains("_") == false {
            playAgainOL.isHidden = false
            checkBtnOL.isEnabled = false
        }
    }
    
    @IBAction func playAgainBtn(_ sender: UIButton) {
        playAgainOL.isHidden = true
        displayOL.text = ""
        count += 1
        lettersGuessed = ""
        //If all words are completed display congratulations message else iterate to the next word
        if count == words.count {
            congratsOL.text = "Congratulations! You Win!"
            hintOL.text = ""
        }
        else{
            word = words[count][0]
            hintOL.text = "Hint: " + words[count][1]
            checkBtnOL.isEnabled = true
            
            displayOL.text = ""
            updateUnderscores()
        }
    }
    
    @IBAction func lettersEntered(_ sender: UITextField) {
        var letters = guessOL.text!
        letters = String(letters.last ?? " ")
        guessOL.text = letters
        
        if letters.isEmpty{
            checkBtnOL.isEnabled = false
        } else {
            checkBtnOL.isEnabled = true
        }
    }
    
    //To update the underscores in displayLabel based on the number of letters
    func updateUnderscores(){
            for letter in word{
                displayOL.text! += "_ "
            }
        }
    
}

