//
//  ViewController.swift
//  iOS_Swift Calculator
//
//  Created by Arti Annaswamy on 6/20/16.
//  Copyright © 2016 Arti Annaswamy. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }

    @IBOutlet weak var outputLbl: UILabel!
    
    // Variables
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("typewriter_hit", ofType: "m4a")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    // Actions
    
    @IBAction func numberPressed(btn: UIButton!) {
        // playSound()
        
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }

    @IBAction func onDividePressed(sender: UIButton) {
        processOperation(Operation.Divide)
    }

    @IBAction func onMultiplyPressed(sender: UIButton) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: UIButton) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: UIButton) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: UIButton) {
        processOperation(currentOperation)
    }
    
    @IBAction func onClearPressed(sender: UIButton) {
        clearCalculator()
    }
    
    // Functions
    
    func clearCalculator() {
        runningNumber = ""
        rightValStr = "0.0"
        leftValStr = "0.0"
        outputLbl.text = "0"
        result = ""
        currentOperation = Operation.Empty
    }
    
    func processOperation(op: Operation) {
        // playSound()
        
        if currentOperation != Operation.Empty {
            // Run some math
            
            if runningNumber != "" {
            
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result
            }
            
            currentOperation = op
            
        } else {
            // This is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        btnSound.play()
    }
    
}

