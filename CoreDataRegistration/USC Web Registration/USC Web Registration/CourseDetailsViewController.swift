// edited file
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
    
    @IBOutlet weak var Units: UILabel!
    
    @IBOutlet weak var diversity: UILabel!
    
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
            diversity.hidden = false
            Units.hidden = false
            
        case 1:
            mainTextLabel?.text = "Will displace the rating of the course and the professor from the course evaluation website. The API has not been provided. This will include a rating out of 5 and possibly reviews from students."
            diversity.hidden = true
            Units.hidden = true
        
        case 2:
            mainTextLabel?.text = "Will display the syllabus for the course to give the student information about what exactly is going to be taught in the class"
            
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
        
        
        //self.view.backgroundColor = UIColor.blueColor()
        
        
       let unitsString = "\(currentCourse!.maxUnits)"
        
        Units.text = "Units: " + unitsString
        
        if currentCourse?.divFlag == "Y"
        {
            diversity.text = "Diversity Requirement: Fullfilled"
        }
        else
        {
            diversity.text = "Diversity Requirement: Not Fullfilled"
        }
    
      let cardinalcolor : UIColor = UIColor(red: 140/255, green: 38/255, blue: 38/255, alpha: 1)
       segControlOut.tintColor = cardinalcolor
       
     
    }
        // Do any additional setup after loading the view.
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var sections = segue.destinationViewController as DisLecLabTableViewController
        
        // Get the new view controller using segue.destinationViewController.
        
        
        // Pass the selected object to the new view controller.
        
        sections.courseSections = currentCourse
        
    }
    

}

