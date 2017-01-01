//
//  ViewController.swift
//  calculator
//
//  Created by jag singh on 2016-04-10.
//  Copyright © 2016 jag singh. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Equals = "="
        case Empty = "Empty"
        
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let path =
        Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundUrl = URL (fileURLWithPath: path!)
        
        
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }

    @IBAction func numberPressed(_ btn: UIButton!)  {
        btnSound.play()
        
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
        
    }
    
    @IBAction func onDividePressed(_ sender: AnyObject) {
        processOperation(Operation.Divide)
        
        
    }
    
    @IBAction func onMultiplyPressed(_ sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(_ sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(_ sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(_ sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    func processOperation(_ op: Operation) {
         playSound()
        
        if currentOperation != Operation.Empty {
            // run some math
            
            // a user selected a operator buth then selected another operator without first entering a number
            if runningNumber != "" {
            
            rightValStr = runningNumber
            runningNumber = ""
            
            
            
            if currentOperation == Operation.Multiply {
                result = "\(Double(leftValStr)! * Double(rightValStr)!)"
            } else if currentOperation == Operation.Divide {
                result = "\(Double(leftValStr)! / Double(rightValStr)!)"
            } else if currentOperation == Operation.Subtract {
                result = "\(Double(leftValStr)! - Double(rightValStr)!)"
            } else if currentOperation == Operation.Add {
                result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                
            }
            
            leftValStr = result
            outputLbl.text = result
                
                
            }
            
            currentOperation = op
            
            
            
        } else {
            // this is the first time a operator is being pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    
}
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()


}
        
        
}




