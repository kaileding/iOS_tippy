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
    let tipPercentages: [Float] = [0.18, 0.2, 0.25]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        let defaultSel = defaults.integerForKey("defaultTippingRateSelection")
        self.tipRate.selectedSegmentIndex = defaultSel
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(sender: AnyObject) {
        let billNum = Float(billField.text!) ?? 0.0
        let tipNum = billNum*tipPercentages[tipRate.selectedSegmentIndex]
        let totalNum = billNum + tipNum
        self.tipLabel.text = String(format: "$%.2f", tipNum)
        self.totalLabel.text = String(format: "$%.2f", totalNum)
    }
}

