//
//  ViewController.swift
//  Calculator
//
//  Created by Sun Huanji on 2016/10/19.
//  Copyright © 2016年 Sun Huanji. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var btnSound:AVAudioPlayer!
    var runningNumber = ""

    enum OPeration:String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOPeration = OPeration.Empty
    var leftValue = ""
    var rightValue = ""
    var result = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do{
          try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        }catch let err as NSError{
        print(err.debugDescription)
        }
        outputLabel.text = "0"
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBOutlet weak var outputLabel: UILabel!

    @IBAction func dividePressed(_ sender: AnyObject) {
        processOperation(operation: .Divide)
    }
    @IBAction func multiplyPressed(_ sender: AnyObject) {
        processOperation(operation: .Multiply)
    }
    @IBAction func subtractPressed(_ sender: AnyObject) {
        processOperation(operation: .Subtract)
    }
    @IBAction func addPressed(_ sender: AnyObject) {
        processOperation(operation: .Add)
    }
    @IBAction func equalPressed(_ sender: AnyObject) {
        processOperation(operation: currentOPeration)
    }
    @IBAction func numberPressed(_ sender: UIButton) {
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLabel.text = runningNumber
    }
    
    func playSound(){
        if btnSound.isPlaying{
           btnSound.stop()
        }
        btnSound.play()
    }

    func processOperation(operation:OPeration){
        playSound()
        if currentOPeration != OPeration.Empty{
            if runningNumber != ""{
              rightValue = runningNumber
              runningNumber = ""
              
                if currentOPeration == OPeration.Multiply {
                    result = "\(Double(leftValue)! * Double(rightValue)!)"
                } else if currentOPeration == OPeration.Divide {
                    result = "\(Double(leftValue)! / Double(rightValue)!)"
                } else if currentOPeration == OPeration.Subtract {
                    result = "\(Double(leftValue)! - Double(rightValue)!)"
                } else if currentOPeration == OPeration.Add {
                    result = "\(Double(leftValue)! + Double(rightValue)!)"
                }
                

                leftValue = result
                print(result)
                outputLabel.text = result
            }
            currentOPeration = operation
        }else{
         leftValue = runningNumber
            runningNumber = ""
            currentOPeration = operation
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

