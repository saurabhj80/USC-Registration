//
//  CourseDetailsViewController.swift
//  USC Reg
//
//  Created by Chaitu on 2/23/15.
//  Copyright (c) 2015 Saurabh Jain. All rights reserved.
//

import UIKit

class CourseDetailsViewController: UIViewController {
    
  var currentCourse : course?
    
    @IBOutlet weak var courseTitle: UILabel!
    
    
    @IBOutlet weak var mainTextLabel: UILabel!
    
    @IBOutlet weak var segControlOut: UISegmentedControl!
    
    @IBAction func segmentControlChange(sender: AnyObject) {
        
        switch segControlOut.selectedSegmentIndex
        {
            
        case 0:
            var courseString = currentCourse?.description
            var styledParagraph = NSMutableParagraphStyle()
            styledParagraph.alignment = NSTextAlignment.Justified
            var justifiedDescription = NSAttributedString(string: courseString!, attributes: [NSParagraphStyleAttributeName:styledParagraph, NSBaselineOffsetAttributeName: NSNumber(float: 0)])
            mainTextLabel?.attributedText = justifiedDescription
            
        case 1:
            mainTextLabel?.text = "blah"
            
        default:
            break;
            
        }

        
    }
   // @IBOutlet weak var contentLabel: UILabel!
   
    
  /* @IBOutlet weak var segmentControl: CourseDescriptionSegmentController!
    
    @IBAction func segmentControlChange(sender: AnyObject) {
        
        switch segmentControlOut.selectedSegmentIndex
        {
        
        case 0:
            var courseString = currentCourse?.description
            var styledParagraph = NSMutableParagraphStyle()
            styledParagraph.alignment = NSTextAlignment.Justified
            var justifiedDescription = NSAttributedString(string: courseString!, attributes: [NSParagraphStyleAttributeName:styledParagraph, NSBaselineOffsetAttributeName: NSNumber(float: 0)])
            contentLabel?.attributedText = justifiedDescription

        case 1:
            contentLabel?.text = "blah"
            
        default:
            break;
    
        }
    }
    
*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title  = currentCourse?.sisCourseID
        courseTitle?.text = currentCourse!.title
        
                
        segControlOut.selectedSegmentIndex = 0
        
        var courseString = currentCourse?.description
        var styledParagraph = NSMutableParagraphStyle()
        styledParagraph.alignment = NSTextAlignment.Justified
        var justifiedDescription = NSAttributedString(string: courseString!, attributes: [NSParagraphStyleAttributeName:styledParagraph, NSBaselineOffsetAttributeName: NSNumber(float: 0)])
        mainTextLabel?.attributedText = justifiedDescription
        
        }
       
     

        // Do any additional setup after loading the view.
    

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

