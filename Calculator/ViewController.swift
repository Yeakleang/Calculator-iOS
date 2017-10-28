//
//  ViewController.swift
//  Calculator
//
//  Created by Soeng Saravit on 10/25/17.
//  Copyright © 2017 Soeng Saravit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var zeroButton: customButton!
    @IBOutlet weak var oneButton: customButton!
    @IBOutlet weak var twoButton: customButton!
    @IBOutlet weak var threeButton: customButton!
    @IBOutlet weak var fourButton: customButton!
    @IBOutlet weak var fiveButton: customButton!
    @IBOutlet weak var sixButton: customButton!
    @IBOutlet weak var sevenButton: customButton!
    @IBOutlet weak var eightButton: customButton!
    @IBOutlet weak var nineButton: customButton!
    @IBOutlet weak var pointButton: customButton!
    @IBOutlet weak var resultButton: customButton!
    @IBOutlet weak var addButton: customButton!
    @IBOutlet weak var subButton: customButton!
    @IBOutlet weak var multiButton: customButton!
    @IBOutlet weak var divideButton: customButton!
    @IBOutlet weak var moduloButton: customButton!
    @IBOutlet weak var unaryButton: customButton!
    @IBOutlet weak var clearButton: customButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var historyLabel: UILabel!
    
    var firstVal = "", secondVal = "", op: String = ""
    var canClear = true, hasOp = false, isFirstNum = true, canShow = false
    var lastResult: String = ""
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        zeroButton.addTarget(self, action: #selector(ViewController.getButtonPress(_:)), for: .touchUpInside)
        oneButton.addTarget(self, action: #selector(ViewController.getButtonPress(_:)), for: .touchUpInside)
        twoButton.addTarget(self, action: #selector(ViewController.getButtonPress(_:)), for: .touchUpInside)
        threeButton.addTarget(self, action: #selector(ViewController.getButtonPress(_:)), for: .touchUpInside)
        fourButton.addTarget(self, action: #selector(ViewController.getButtonPress(_:)), for: .touchUpInside)
        fiveButton.addTarget(self, action: #selector(ViewController.getButtonPress(_:)), for: .touchUpInside)
        sixButton.addTarget(self, action: #selector(ViewController.getButtonPress(_:)), for: .touchUpInside)
        sevenButton.addTarget(self, action: #selector(ViewController.getButtonPress(_:)), for: .touchUpInside)
        eightButton.addTarget(self, action: #selector(ViewController.getButtonPress(_:)), for: .touchUpInside)
        nineButton.addTarget(self, action: #selector(ViewController.getButtonPress(_:)), for: .touchUpInside)
        pointButton.addTarget(self, action: #selector(ViewController.getButtonPress(_:)), for: .touchUpInside)
        resultButton.addTarget(self, action: #selector(ViewController.getButtonPress(_:)), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(ViewController.getButtonPress(_:)), for: .touchUpInside)
        subButton.addTarget(self, action: #selector(ViewController.getButtonPress(_:)), for: .touchUpInside)
        multiButton.addTarget(self, action: #selector(ViewController.getButtonPress(_:)), for: .touchUpInside)
        divideButton.addTarget(self, action: #selector(ViewController.getButtonPress(_:)), for: .touchUpInside)
        moduloButton.addTarget(self, action: #selector(ViewController.getButtonPress(_:)), for: .touchUpInside)
        unaryButton.addTarget(self, action: #selector(ViewController.getButtonPress(_:)), for: .touchUpInside)
        clearButton.addTarget(self, action: #selector(ViewController.getButtonPress(_:)), for: .touchUpInside)
    }
    
    @objc func getButtonPress(_ sender : customButton) {
        //print(sender.currentTitle!)
        
        let txt = sender.currentTitle!
        
        switch txt {
        case "+", "-", "×", "÷", "%":
            
            if hasOp {
                op = txt
            }
            
            op = txt
            isFirstNum = false
            hasOp = true
            canShow = true
            
            let t = Double(resultLabel.text!) ?? 0.00
            resultLabel.text = floor(t) == t ? String(format: "%.0f", t) : String(format: "%.2f", t)
            
            historyLabel.text = "\(resultLabel.text!) \(op)"
            
        case "+/-" :

            if isFirstNum {
                
                if firstVal == "" {
                    if resultLabel.text != "0" {
                        firstVal = resultLabel.text!
                    }
                }
                
                if Int(firstVal)! > 0 {
                    firstVal = "-" + firstVal
                    resultLabel.text = firstVal
                }
                else {
                    firstVal = String(abs(Int(firstVal)!))
                    resultLabel.text = firstVal
                }
                
            }
            else {
                
                if Int(secondVal)! > 0 {
                    secondVal = "-" + secondVal
                    resultLabel.text = secondVal
                }
                else {
                    secondVal = String(abs(Int(secondVal)!))
                    resultLabel.text = secondVal
                }
                
            }
            
        case "=":
            
            if Double(resultLabel.text!) != nil {

                if canShow {
                    let t = Double(resultLabel.text!) ?? 0.00
                    resultLabel.text = floor(t) == t ? String(format: "%.0f", t) : String(format: "%.2f", t)
                    historyLabel.text = historyLabel.text! + " \(resultLabel.text!)"
                    
                    let result = calculate()
                    resultLabel.text = floor(result) == result ? String(format: "%.0f", result) : String(format: "%.2f", result)
                    
                    lastResult = resultLabel.text!
                    
                    canShow = false
                }
                
                firstVal = ""
                secondVal = ""
                hasOp = false
                op = ""
                isFirstNum = true
                
            }
            
        case "C":
            
            historyLabel.text = ""
            resultLabel.text = "0"
            firstVal = ""
            secondVal = ""
            op = ""
            isFirstNum = true
            hasOp = false
            lastResult = ""
            
        default:
            var num = txt
            
//            print("Num: \(num), lastResult: \(lastResult), firstVal: \(firstVal), secondVal: \(secondVal), hasOp: \(hasOp), isFirstNum: \(isFirstNum)")
            
            if firstVal == "" && lastResult != "" && hasOp == true {
                isFirstNum = false
                firstVal = lastResult
            }
            
            if isFirstNum {
                
                if txt == "." {
                    if firstVal.contains(".") {
                        num = ""
                    }
                }
                
                firstVal = firstVal + num
                resultLabel.text = firstVal
            }
            else {
                
                if txt == "." {
                    if secondVal.contains(".") {
                        num = ""
                    }
                }
                
                secondVal = secondVal + num
                resultLabel.text = secondVal
            }
            
        }
    }
    
    func calculate() -> Double {
        
        let first = Double(firstVal) ?? 0.00
        let second = Double(secondVal) ?? 0.00

        firstVal = ""
        secondVal = ""
        
        //print("\(first) \(second)")
        
        switch op {
        case "+":
            return first + second
        case "-":
            return first - second
        case "×":
            return first * second
        case "÷":
            return first / second
        case "%":
            return first.truncatingRemainder(dividingBy: second)
        default:
            return 0.0
        }
        
    }

}

@IBDesignable class customButton: UIButton {
    
    @IBInspectable
    public var cornerRadius: CGFloat = 0.0 {
        didSet {
           self.layer.cornerRadius = self.cornerRadius
        }
    }
}
