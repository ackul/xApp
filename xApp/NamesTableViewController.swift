//
//  NamesTableViewController.swift
//  xApp
//
//  Created by Achin Kulshrestha on 10/21/15.
//  Copyright © 2015 Achin Kulshrestha. All rights reserved.
//

import UIKit

class NamesTableViewController: UITableViewController, NSURLConnectionDataDelegate, NSURLConnectionDelegate {
    
    var names = [Name]()
    var data: NSMutableData!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.data = NSMutableData()
        
        // Do any additional setup after loading the view, typically from a nib.
        let url: NSURL = NSURL(string: "http://pages.cs.wisc.edu/~achink/cs407.json")!
        let req: NSURLRequest = NSURLRequest(URL: url)
        let connection: NSURLConnection = NSURLConnection(request: req, delegate: self)!
        
        connection.start()
        
        
        var newName = Name(name: "Hellp", description: "Hi there")
        names.append(newName)
        
        
        newName = Name(name: "we", description: "sdfdsfsd")
        names.append(newName)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return names.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("nameCell", forIndexPath: indexPath)

        // Configure the cell...
        let currentName = names[indexPath.row]
        
        cell.textLabel?.text = currentName.name

        return cell
    }
    
    // MARK: NSURLConnection functions
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
            self.data.length = 0
        
        
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        self.data.appendData(data)
        
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        do {
            if let jsonResult = try NSJSONSerialization.JSONObjectWithData(self.data, options: []) as? NSDictionary {
                print(jsonResult)
                let postsArray: NSArray = jsonResult.objectForKey("names") as! NSArray
                
                for(var i = 0; i < postsArray.count; i++){
                    let entry: NSDictionary = postsArray.objectAtIndex(i) as! NSDictionary
                    
                    let theName: NSString = entry.objectForKey("name") as! NSString
                    let theDescription: NSString = entry.objectForKey("description") as! NSString
                    
                    let newName: Name = Name(name: theName as String, description: theDescription as String)
                    
                    names.append(newName)
                }
                self.tableView.reloadData()

            }
        } catch {
            print(error)
        }
        
        connection.cancel()
    }
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        print("Error During Connection: \(error.description)")
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        var descScene = segue.destinationViewController as! DisplayViewController
        // Pass the selected object to the new view controller.
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let selectedName = names[indexPath.row]
            descScene.currentName = selectedName
        }
    }
    

}
