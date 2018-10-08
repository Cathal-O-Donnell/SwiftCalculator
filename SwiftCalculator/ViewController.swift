//
//  ViewController.swift
//  SwiftCalculator
//
//  Created by Cathal O Donnell on 03/10/2018.
//  Copyright © 2018 Cathal O Donnell. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblResult: UILabel!
    
    var numberOnScreen: Double = 0;
    var previousNumber: Double? = nil;
    var isNewValue = false;
    var operatorSelected: Int = 0;
    var runningTotal: Double = 0;
    var result: Double? = 0;
    var repeatLastOperation = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Reset variables to original values
    func Reset() {
        
        numberOnScreen = 0;
        previousNumber = nil;
        isNewValue = false;
        operatorSelected = 0;
        result = 0;
        runningTotal = 0;
        repeatLastOperation = false;
        
        lblResult.text = "";
    }
    
    // Number click event
    @IBAction func NumberClicked(_ sender: UIButton) {
        
        if isNewValue == true && result != 0 {
            runningTotal = 0;
            previousNumber = nil;
        }
        
        // The user is entering a new value, overwriting the previous number
        if isNewValue == true {

            lblResult.text = String(sender.tag - 1);
            numberOnScreen = Double(lblResult.text!)!;
            
            isNewValue = false;
        } else {
            
            lblResult.text = lblResult.text! + String(sender.tag - 1);
            
            numberOnScreen = Double(lblResult.text!)!;
        }
    }
    
    // Operator click event
    @IBAction func OperatorClicked(_ sender: UIButton) {
        
        // Number is entered and operator is not clear or equals
        if lblResult.text != "" && sender.tag != 16 && sender.tag != 11 {
            
            repeatLastOperation = false;
            operatorSelected = sender.tag;
            isNewValue = true;
            
            switch sender.tag {
                // +
                case 12:
                    if previousNumber != nil {
                        runningTotal = previousNumber! + numberOnScreen;
                    }
                    
                    // Store the previously entered number
                    previousNumber = numberOnScreen
                    
                    lblResult.text = "+";
                    
                    break;
                
                // -
                case 13:
                    if previousNumber != nil {
                        runningTotal = previousNumber! - numberOnScreen;
                    }
                    
                    // store the previously entered number
                    previousNumber = numberOnScreen;
                    
                    lblResult.text = "-";
                    
                    break;
                
                // x
                case 14:
                    if previousNumber != nil {
                        runningTotal = previousNumber! * numberOnScreen;
                    }
                    
                    // store the previously entered number
                    previousNumber = numberOnScreen;
                    
                    lblResult.text = "x";
                    
                    break;
                
                // ÷
                default:
                    if previousNumber != nil {
                        runningTotal = previousNumber! / numberOnScreen;
                    }
                    
                    // store the previously entered number
                    previousNumber = numberOnScreen;
                
                    lblResult.text = "÷";
                    
                    break;
            }
        } else if sender.tag == 11 {
            
            if operatorSelected == 12 {
                
                if repeatLastOperation == true {
                    result = result! + previousNumber!;
                } else if runningTotal != 0 {
                    result = numberOnScreen + runningTotal;
                } else {
                    result = previousNumber! + numberOnScreen;
                }
                
            } else if operatorSelected == 13 {
                
                if repeatLastOperation == true {
                    result = result! - previousNumber!;
                } else if runningTotal != 0 {
                    result = numberOnScreen - runningTotal;
                } else {
                    result = previousNumber! - numberOnScreen;
                }

            } else if operatorSelected == 14 {
                
                if repeatLastOperation == true {
                    result = result! * previousNumber!;
                } else if runningTotal != 0 {
                    result = numberOnScreen * runningTotal;
                } else {
                    result = previousNumber! * numberOnScreen;
                }
                
            } else if operatorSelected == 15 {
                
                if repeatLastOperation == true {
                    result = result! / previousNumber!;
                } else if runningTotal != 0 {
                    result = numberOnScreen / runningTotal;
                } else {
                    result = previousNumber! / numberOnScreen;
                }
            }
            
            // Check if result is a whole number
            let isInteger = result!.truncatingRemainder(dividingBy: 1) == 0
            
            if isInteger {
                let intResult: Int = Int(result!);
                
                lblResult.text = String(intResult)
            } else {
                lblResult.text = String(result!);
            }
            
            repeatLastOperation = true;
            isNewValue = true;
        } else {
            
            Reset();
        }
    }
}

