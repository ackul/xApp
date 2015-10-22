//
//  DisplayViewController.swift
//  xApp
//
//  Created by Achin Kulshrestha on 10/21/15.
//  Copyright © 2015 Achin Kulshrestha. All rights reserved.
//

import UIKit

class DisplayViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    var currentName : Name?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLabel.text = currentName?.description
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
