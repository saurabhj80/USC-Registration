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
    
    // IBOutlets
    @IBOutlet weak var courseTitle: UILabel!
    @IBOutlet weak var mainTextLabel: UILabel!
    @IBOutlet weak var segControlOut: UISegmentedControl!

    // IBAction
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
        
        // Segmented Control
        segControlOut.selectedSegmentIndex = 0
        
        var courseString = currentCourse?.description
        var styledParagraph = NSMutableParagraphStyle()
        styledParagraph.alignment = NSTextAlignment.Justified
        var justifiedDescription = NSAttributedString(string: courseString!, attributes: [NSParagraphStyleAttributeName:styledParagraph, NSBaselineOffsetAttributeName: NSNumber(float: 0)])
        mainTextLabel?.attributedText = justifiedDescription
        
        }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

