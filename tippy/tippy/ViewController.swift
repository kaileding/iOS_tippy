//
//  ViewController.swift
//  tippy
//
//  Created by DINGKaile on 9/12/16.
//  Copyright © 2016 myPersonalProjects. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipRate: UISegmentedControl!
    @IBOutlet weak var horizontalBar: UIView!
    
    var justRestore: Bool = false
    let tipPercentages: [Float] = [0.18, 0.2, 0.25]
    var currencySymbol: String = "$"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let appLocale = NSLocale.currentLocale()
        self.currencySymbol = appLocale.objectForKey(NSLocaleCurrencySymbol) as! String
        print("-------- currencySymbol is " + self.currencySymbol)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if (!self.justRestore) {
            self.billField.center.x += self.view.bounds.width
            self.tipLabel.center.x += self.view.bounds.width
            self.totalLabel.center.x += self.view.bounds.width
            self.horizontalBar.center.x += self.view.bounds.width
        }
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let defaultSel = defaults.integerForKey("defaultTippingRateSelection")
        self.tipRate.selectedSegmentIndex = defaultSel
        updateTip()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if (!self.justRestore) {
            UIView.animateWithDuration(0.5, delay: 0.0, options: [.CurveEaseInOut], animations: {
                self.billField.center.x -= self.view.bounds.width
                }, completion: nil)
            UIView.animateWithDuration(0.5, delay: 0.3, options: [.CurveEaseInOut], animations: {
                self.tipLabel.center.x -= self.view.bounds.width
                }, completion: nil)
            UIView.animateWithDuration(0.5, delay: 0.4, options: [.CurveEaseInOut], animations: {
                self.horizontalBar.center.x -= self.view.bounds.width
                }, completion: nil)
            UIView.animateWithDuration(0.5, delay: 0.5, options: [.CurveEaseInOut], animations: {
                self.totalLabel.center.x -= self.view.bounds.width
                }, completion: nil)
        }
        self.justRestore = false
        self.billField.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
        UIView.animateWithDuration(0.5) {
            self.view.backgroundColor = UIColor.whiteColor()
        }
    }
    
    @IBAction func calculateTip(sender: AnyObject) {
        updateTip()
    }
    
    func updateTip() {
//        let billNum = Float(billField.text!) ?? 0.0
        let billNum = formatNumber()
        let tipNum = billNum*tipPercentages[tipRate.selectedSegmentIndex]
        let totalNum = billNum + tipNum
        self.tipLabel.text = self.currencySymbol + addSeparator(String(format: "%.2f", tipNum))
        self.totalLabel.text = self.currencySymbol + addSeparator(String(format: "%.2f", totalNum))
    }
    
    @IBAction func changeBackground(sender: AnyObject) {
        UIView.animateWithDuration(0.5) { 
            self.view.backgroundColor = UIColor(red: 102.0/255.0, green: 255.0/255.0, blue: 178.0/255.0, alpha: 1.0)
        }
    }
    
    override func encodeRestorableStateWithCoder(coder: NSCoder) {
        if self.billField.text != nil {
            coder.encodeObject(self.billField.text, forKey: "billField")
        }
        super.encodeRestorableStateWithCoder(coder)
    }
    
    override func decodeRestorableStateWithCoder(coder: NSCoder) {
        let oldBill = coder.decodeObjectForKey("billField")
        if oldBill != nil {
            self.billField.text = oldBill as? String
        }
        self.justRestore = true
        
        super.decodeRestorableStateWithCoder(coder)
    }
    
    func addSeparator(number: String) -> String {
        var numStr: String = (number=="") ? "0" : number
        let zeroTest: Int = Int(numStr) ?? -1
        if zeroTest >= 0 && numStr.characters.first == "0" {
            numStr = String(numStr.characters.last!)
        }
        let cStr = numStr.cStringUsingEncoding(8)!
        let cStrLen = cStr.count
        var i: Int = cStrLen-4
        let decimalIndex = cStr.indexOf(46) // '.' has ASCII value of 46
        if decimalIndex != nil {
            i = decimalIndex!-3
            if decimalIndex!+4<cStrLen {
                numStr = numStr.stringByPaddingToLength(decimalIndex!+3, withString: "", startingAtIndex: 0)
            }
        }
        let mutableStr: NSMutableString = NSMutableString(string: numStr)
        while i>0 {
            mutableStr.insertString(",", atIndex: i)
            i -= 3
        }
        
        return String(mutableStr)
    }
    
    func formatNumber() -> Float {
        var actualNum: Float = 0.0
        let rawStr = self.billField.text!
        let parsedNum = rawStr.stringByReplacingOccurrencesOfString(self.currencySymbol, withString: "").stringByReplacingOccurrencesOfString(",", withString: "")
        actualNum = Float(parsedNum) ?? 0.0
        self.billField.text = self.currencySymbol + addSeparator(parsedNum)
        
        return actualNum
    }
}

