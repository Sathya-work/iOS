    //
    //  ViewController.swift
    //  Mallipudi_CalculatorApp
    //
    //  Created by Sathyanarayana on 2/23/25.
    //

    import UIKit

    class ViewController: UIViewController {
        
        var firstNumber: Double = 0
        var secondNumber: Double = 0
        var currentOperation: String = ""
        var isWaitingForSecondNumber: Bool = false

        override func viewDidLoad() {
            super.viewDidLoad()
            resultOutlet.text! = "0"
        }

        @IBOutlet weak var resultOutlet: UILabel!
        
        @IBAction func buttonZero(_ sender: UIButton) {
            if isWaitingForSecondNumber {
                    resultOutlet.text = "0"
                    isWaitingForSecondNumber = false
                }
            else {
                    if resultOutlet.text == "0" || resultOutlet.text == "" {
                        resultOutlet.text = "0"
                    } else {
                        resultOutlet.text! += "0"
                    }
                }
        }
        @IBAction func buttonOne(_ sender: UIButton) {
            if isWaitingForSecondNumber {
                    resultOutlet.text = "1"
                    isWaitingForSecondNumber = false
                }
            else {
                    if resultOutlet.text == "0" || resultOutlet.text == "" {
                        resultOutlet.text = "1"
                    } else {
                        resultOutlet.text! += "1"
                    }
                }
        }
        @IBAction func buttonTwo(_ sender: UIButton) {
            if isWaitingForSecondNumber {
                    resultOutlet.text = "2"
                    isWaitingForSecondNumber = false
                }
            else {
                    if resultOutlet.text == "0" || resultOutlet.text == "" {
                        resultOutlet.text = "2"
                    } else {
                        resultOutlet.text! += "2"
                    }
                }
        }
        @IBAction func buttonThree(_ sender: UIButton) {
            if isWaitingForSecondNumber {
                    resultOutlet.text = "3"
                    isWaitingForSecondNumber = false
                }
            else {
                    if resultOutlet.text == "0" || resultOutlet.text == "" {
                        resultOutlet.text = "3"
                    } else {
                        resultOutlet.text! += "3"
                    }
                }
        }
        @IBAction func buttonFour(_ sender: UIButton) {
            if isWaitingForSecondNumber {
                    resultOutlet.text = "4"
                    isWaitingForSecondNumber = false
                }
            else {
                    if resultOutlet.text == "0" || resultOutlet.text == "" {
                        resultOutlet.text = "4"
                    } else {
                        resultOutlet.text! += "4"
                    }
                }
        }
        @IBAction func buttonFive(_ sender: UIButton) {
            if isWaitingForSecondNumber {
                    resultOutlet.text = "5"
                    isWaitingForSecondNumber = false
                }
            else {
                    if resultOutlet.text == "0" || resultOutlet.text == "" {
                        resultOutlet.text = "5"
                    } else {
                        resultOutlet.text! += "5"
                    }
                }
        }
        @IBAction func buttonSix(_ sender: UIButton) {
            if isWaitingForSecondNumber {
                    resultOutlet.text = "6"
                    isWaitingForSecondNumber = false
                }
            else {
                    if resultOutlet.text == "0" || resultOutlet.text == "" {
                        resultOutlet.text = "6"
                    } else {
                        resultOutlet.text! += "6"
                    }
                }
        }
        @IBAction func buttonSeven(_ sender: UIButton) {
            if isWaitingForSecondNumber {
                    resultOutlet.text = "7"
                    isWaitingForSecondNumber = false
                }
            else {
                    if resultOutlet.text == "0" || resultOutlet.text == "" {
                        resultOutlet.text = "7"
                    } else {
                        resultOutlet.text! += "7"
                    }
                }
        }
        @IBAction func buttonEight(_ sender: UIButton) {
            if isWaitingForSecondNumber {
                    resultOutlet.text = "8"
                    isWaitingForSecondNumber = false
                }
            else {
                    if resultOutlet.text == "0" || resultOutlet.text == "" {
                        resultOutlet.text = "8"
                    } else {
                        resultOutlet.text! += "8"
                    }
                }
        }
        @IBAction func buttonNine(_ sender: UIButton) {
            if isWaitingForSecondNumber {
                    resultOutlet.text = "9"
                    isWaitingForSecondNumber = false
                }
            else {
                    if resultOutlet.text == "0" || resultOutlet.text == "" {
                        resultOutlet.text = "9"
                    } else {
                        resultOutlet.text! += "9"
                    }
                }
        }
        @IBAction func buttonEquals(_ sender: UIButton) {
            performOperation(currentOperation)
            currentOperation = ""
        }
        @IBAction func buttonAdd(_ sender: UIButton) {
            performOperation("+")
        }
        @IBAction func buttonSubtract(_ sender: UIButton) {
            performOperation("-")
        }
        @IBAction func buttonMultiply(_ sender: UIButton) {
            performOperation("*")
        }
        @IBAction func buttonDivide(_ sender: UIButton) {
            performOperation("/")
        }
        @IBAction func buttonClear(_ sender: UIButton) {
            resultOutlet.text = "0"
        }
        @IBAction func buttonDecimal(_ sender: UIButton) {
            resultOutlet.text! += "."
        }
        @IBAction func buttonPercentage(_ sender: UIButton) {
            firstNumber = Double(resultOutlet.text!) ?? 0
            currentOperation = "%"
            isWaitingForSecondNumber = true
        }
        @IBAction func buttonSignChange(_ sender: UIButton) {
            if let lastChar = resultOutlet.text?.last, "+-*/%".contains(lastChar) {
                    resultOutlet.text!.removeLast()
                    resultOutlet.text! += lastChar == "-" ? "+" : "-"
                } else if var value = Int(resultOutlet.text!) {
                    value *= -1
                    resultOutlet.text = String(value)
                }
        }
        @IBAction func buttonAllClear(_ sender: UIButton) {
            firstNumber = 0
            secondNumber = 0
            currentOperation = ""
            resultOutlet.text = "0"
        }
        
        func performOperation(_ newOperation: String) {
            if !currentOperation.isEmpty {
                secondNumber = Double(resultOutlet.text!) ?? 0
                switch currentOperation {
                case "+": firstNumber += secondNumber
                case "-": firstNumber -= secondNumber
                case "*": firstNumber *= secondNumber
                case "/":
                    if secondNumber == 0 {
                        resultOutlet.text = "NaN"
                        return
                    }
                    firstNumber /= secondNumber
                case "%":
                    firstNumber = firstNumber.truncatingRemainder(dividingBy: secondNumber)
                    resultOutlet.text = String(format: "%.1f", firstNumber)
                    return
                default: break
                }
                resultOutlet.text = firstNumber.truncatingRemainder(dividingBy: 1) == 0 ? String(Int(firstNumber)) : String(firstNumber)
            } else {
                firstNumber = Double(resultOutlet.text!) ?? 0
            }
            currentOperation = newOperation
            isWaitingForSecondNumber = true
        }
    }

