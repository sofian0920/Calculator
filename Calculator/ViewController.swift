//
//  ViewController.swift
//  Calculator
//
//  Created by Sofia Norina on 28.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var operationButton: UIButton!
    @IBOutlet weak var devButton: UIButton!
    @IBOutlet weak var multbutton: UIButton!
    @IBOutlet weak var minButton: UIButton!
    @IBOutlet weak var plusbutton: UIButton!
    
    var stillTyping = false
    var dotSimbol = false
    var firstOperant : Double = 0
    var secondOperant : Double = 0
    var operationSign: String = ""
    var currentInput: Double {
        get{
            return Double(resultLabel.text!)!
        }
        set {
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: ".")
            if valueArray[1] == "0"{
                resultLabel.text = "\(valueArray[0])"
            }
            else{
                resultLabel.text = "\(newValue)"}
            stillTyping = false
        }
    }
    @IBAction func numberAdded(_ sender: UIButton) {
        let number = sender.currentTitle!
        if  resultLabel.text?.count ?? 0 < 13{
        if stillTyping {
            resultLabel.text = resultLabel.text! + number}
            else{
                resultLabel.text = number
                stillTyping = true
            }
        }
    }
    @IBAction func cleningField(_ sender: UIButton) {
        resultLabel.text = "0"
        stillTyping = false
        dotSimbol = false
    }
    @objc func onDown (){
        multbutton.backgroundColor = .white
    
    }
    @objc func onClik(){
        multbutton.backgroundColor = .systemYellow
    }
    @IBAction func actionNumber(_ sender: UIButton) {
        multbutton.addTarget(self, action: #selector(onClik), for: .touchUpInside)
        multbutton.addTarget(self, action: #selector(onDown), for: .touchDown)
        operationSign = sender.currentTitle!
        firstOperant = currentInput
        stillTyping = false
        dotSimbol = false
    }
    @IBAction func percentButtonPresed(_ sender: UIButton) {
        if firstOperant == 0 {
            currentInput = currentInput / 100
        }
    }
    @IBAction func dotPresed(_ sender: UIButton) {
        if !dotSimbol && stillTyping {
            resultLabel.text = resultLabel.text! + "."
            dotSimbol = true
        } else if !dotSimbol && !stillTyping {
            resultLabel.text = "0."
        }
    }
    @IBAction func plusMinusPresed(_ sender: UIButton) {
        currentInput = -currentInput
    }
    func operationTwoOperands (operation : (Double,Double) -> Double){
        currentInput = operation(firstOperant, secondOperant)
        stillTyping = false
    }
    @IBAction func resultingButton(_ sender: UIButton) {
        
        if stillTyping {
            secondOperant = currentInput
        }
        switch operationSign{
        case "+":
            operationTwoOperands{$0 + $1}
        case "-":
            operationTwoOperands{$0 - $1}
            
        case "÷":
            if firstOperant == 0 {
                currentInput = 0
            }
            else {operationTwoOperands{$0 / $1}}
        case "×":
            operationTwoOperands{$0 * $1}
        default: break
        }
    }
    func swipeObservers() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handelSwipe))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
    }
    @objc func handelSwipe(gester: UISwipeGestureRecognizer){
        if resultLabel.text != "0" {
            resultLabel.text?.removeLast()}
    }
}
 
 
