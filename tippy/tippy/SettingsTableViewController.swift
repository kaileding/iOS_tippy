//
//  SettingsTableViewController.swift
//  tippy
//
//  Created by DINGKaile on 9/12/16.
//  Copyright © 2016 myPersonalProjects. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet var settingsTable: UITableView!
    let simpleTableIdentifier = "SimpleTableIdentifier"
    
    @IBOutlet weak var numSlider: UISlider!
    @IBOutlet weak var sliderIndicator: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // select the old row
        let defaults = NSUserDefaults.standardUserDefaults()
        let oldSel = defaults.integerForKey("defaultTippingRateSelection")
        let oldIndexPath = NSIndexPath(forRow: oldSel, inSection: 0)
        let oldCell = self.settingsTable.cellForRowAtIndexPath(oldIndexPath)
        oldCell?.accessoryType = .Checkmark
        let oldNum = defaults.integerForKey("defaultPeopleNumberSelection")
        self.sliderIndicator.text = "\(oldNum)"
        self.numSlider.setValue(Float(oldNum), animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    /*
    // MARK: - User Interactions
    */
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = self.settingsTable.cellForRowAtIndexPath(indexPath)
        let defaults = NSUserDefaults.standardUserDefaults()
        let oldSel = defaults.integerForKey("defaultTippingRateSelection")
        let oldCell = self.settingsTable.cellForRowAtIndexPath(NSIndexPath(forRow: oldSel, inSection: 0))
        oldCell?.accessoryType = .None
        cell!.accessoryType = .Checkmark
        defaults.setInteger(indexPath.row, forKey: "defaultTippingRateSelection")
        defaults.synchronize()
    }

    @IBAction func sliderChanged(sender: UISlider) {
        let progress = lroundf(sender.value)
        self.sliderIndicator.text = "\(progress)"
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(progress, forKey: "defaultPeopleNumberSelection")
        defaults.synchronize()
    }
    
    
    
}
