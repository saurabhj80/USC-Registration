//
//  ViewController.swift
//  USC Web Registration
//
//  Created by Darvish Kamalia on 2/21/15.
//  Copyright (c) 2015 Darvish Kamalia. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBAction func fetchBtn(sender: AnyObject) {
        
        localStorage.getAPIdata()
        
    }
    @IBAction func uiButton(sender: AnyObject) {
        
        var courseBin = localStorage.getCurrentSections()
        println(courseBin)


        
    }
    override func viewDidLoad() {
        
        let context = self
        super.viewDidLoad()
        
      //localStorage.getAPIdata()
        // Do any additional setup after loading the view, typically from a nib.
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

