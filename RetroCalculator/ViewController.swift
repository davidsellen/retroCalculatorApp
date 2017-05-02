//
//  ViewController.swift
//  RetroCalculator
//
//  Created by David Santos on 30/04/17.
//  Copyright © 2017 dscode. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var btnSound : AVAudioPlayer!
    
    @IBOutlet weak var calcLbl: UILabel!
   
    var firstNumber : String = ""
    var secondNumber : String = ""
    var operation : String = ""
    var result : String = ""
    var justCalculated : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundUrl)
            btnSound.prepareToPlay()
        }catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    @IBAction func numberPressed(sender: UIButton ){
        setNumber(sender.tag)
        playSound()
    }
    
    func playSound() {
        
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func setCalcLabel () {
        calcLbl.text = "\(firstNumber) \(operation) \(secondNumber)"
    }
    
    func setNumber(_ numb : Int) {
        if operation == ""{
            if justCalculated {
                firstNumber = String(numb)
                justCalculated = false
            } else {
                firstNumber = firstNumber + String(numb)
            }
        } else {
            secondNumber = secondNumber + String(numb)
        }
        setCalcLabel ()
    }

    
    @IBAction func divideBtnPressed(_ sender: Any) {
        setCurrentOperation("/")
    }
    @IBAction func multiplyBtnPressed(_ sender: Any) {
        setCurrentOperation("*")
    }
    @IBAction func minusBtnPressed(_ sender: Any) {
        setCurrentOperation("-")
    }
    @IBAction func addBtnPressed(_ sender: Any) {
        setCurrentOperation("+")
    }
    
    func setCurrentOperation (_ operationOperator: String) {
        if firstNumber != ""{
            operation = operationOperator
            setCalcLabel()
        }
    }
    @IBAction func equalBtnPressed(_ sender: Any) {
        if firstNumber != "" && secondNumber != "" {
            let first = Double(firstNumber)!
            let second = Double(secondNumber)!
            let result = calculate(operation: operation, first: first, second: second)
            operation = ""
            firstNumber = result
            secondNumber = ""
            calcLbl.text = result
            justCalculated = true
            
        }
    }
    
    func calculate (operation: String, first: Double, second: Double) -> String {
        
        var result: Double = 0
        
        switch operation {
        case "/":
            result = first / second
        case "*":
            result = first * second
        case "-":
            result = first - second
        case "+":
            result = first + second
        default:
            print("not supported operation \(operation)")
        }
        
        return "\(result)"
    }
    
    @IBAction func clearBtnPressed(_ sender: Any) {
        operation = ""
        firstNumber = result
        secondNumber = ""
        calcLbl.text = result
        justCalculated = false
    }
}

