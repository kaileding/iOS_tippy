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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = self.settingsTable.cellForRowAtIndexPath(indexPath)
        let defaults = NSUserDefaults.standardUserDefaults()
        let oldSel = defaults.integerForKey("defaultTippingRateSelection")
        let oldCell = self.settingsTable.cellForRowAtIndexPath(NSIndexPath(forRow: oldSel, inSection: 0))
        oldCell?.accessoryType = .None
        cell!.accessoryType = .Checkmark
        defaults.setInteger(indexPath.row, forKey: "defaultTippingRateSelection")
        defaults.synchronize()
        print("### selected \(indexPath.row)")
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
