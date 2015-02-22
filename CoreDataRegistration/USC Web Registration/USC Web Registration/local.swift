//
//  local.swift
//
//
//  Created by Darvish Kamalia on 2/20/15.
//
//

import Foundation
import CoreData
import UIKit

struct section {
    
    var termCode: String
    var courseID: Double
    var sisCourseID: String
    var name: String
    var section: String //the section code
    var session: String
    var units: Double
    
    
    //"Lab", "Lecture", etc
    //note that the first letter is uppercase
    var type: String
    
    var beginTime: String
    var endTime: String
    var day: String
    var numRegistered: Double //number of students already registered
    var numSeats: Double //total number of seats
    var instructor: String
    var location: String
    
    //These probably wont be very useful
    var addDate: String
    var cancelDate: String
    var PublishFlag: String
    
    
}

struct course {
    
    var courseID: Double
    var sisCourseID: String //the name of the course. Ex. "CS 103"
    var title: String //Ex. Introduction to Programming
    var minUnits: Double
    var maxUnits: Double //this will probably be the more useful one
    var totalMax: Double
    var description: String //course description
    var divFlag: String //"Y" indicates that diversity requirement is fulfilled
    var effecTerm: String //Semester that the course belongs to
    
}

struct department {
    
    var departmentCode: String
    var departmentDescription: String
    var schoolCode: String
    
}



struct school {
    
    var schoolCode: String
    var schoolDescription: String
    
    
}

class localStorage {
    
    
    
    class func getAPIdata () {
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context = appDelegate.managedObjectContext
        
        var request =  NSURLRequest(URL: NSURL(string : "http://petri.esd.usc.edu/socAPI/Schools/ALL")!)
        
        var task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) ->
            Void in
            
            var err: NSError?
            var json = JSON(data: data)
            
            for i in 0 ... json.arrayValue.count {
            
               let tempSchool = NSEntityDescription.insertNewObjectForEntityForName("School", inManagedObjectContext: context!) as School
                
                tempSchool.schoolDescription = json[i]["SOC_SCHOOL_DESCRIPTION"].stringValue
                tempSchool.schoolCode = json[i]["SOC_SCHOOL_CODE"].stringValue
                
                for j in 0 ... json[i]["SOC_DEPARTMENT_CODE"].arrayValue.count {
                    
                        let tempDept = NSEntityDescription.insertNewObjectForEntityForName("Department", inManagedObjectContext: context!) as Department
                        tempDept.departmentCode = json[i][j]["SOC_DEPARTMENT_CODE"].stringValue
                        tempDept.departmentDescription = json[i][j]["SOC_DEPARTMENT_DESCRIPTION"].stringValue
                        tempDept.schoolCode = json[i][j]["SOC_SCHOOL_CODE"].stringValue
                    
                }
                
            }
            println("fetched schools and deparments")
        })
        
        task.resume()
    
        request =  NSURLRequest(URL: NSURL(string : "http://petri.esd.usc.edu/socAPI/Courses/20151/ALL")!)
        
        task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) ->
            Void in
            
            var err: NSError?
            var json = JSON(data: data)
            
            for i in 0 ... json.arrayValue.count {
                
                let tempCourse = NSEntityDescription.insertNewObjectForEntityForName("Course", inManagedObjectContext: context!) as Course
                
                tempCourse.courseID = json[i]["COURSE_ID"].doubleValue
                tempCourse.sisCourseID = json[i]["SIS_COURSE_ID"].stringValue
                tempCourse.title = json[i]["TITLE"].stringValue
                tempCourse.minUnits = json[i]["MIN_UNITS"].doubleValue
                tempCourse.maxUnits = json[i]["MAX_UNITS"].doubleValue
                tempCourse.totalMax = json[i]["TOTAL_MAX_UNITS"].doubleValue
                tempCourse.courseDescription = json[i]["DECRIPTION"].stringValue
                tempCourse.divFlag = json[i]["DIVERSITY_FLAG"].stringValue
                tempCourse.effecTerm = json[i]["EFFECTIVE_TERM_CODE"].stringValue


                for j in 0 ... json[i].arrayValue.count {
                    
                
                    let tempSection = NSEntityDescription.insertNewObjectForEntityForName("Section", inManagedObjectContext: context!) as Section
                    
                    tempSection.termCode = json[i][j]["TERM_CODE"].stringValue
                    tempSection.courseID = json[i][j]["COURSE_ID"].doubleValue
                    tempSection.sisCourseID = json[i][j]["SIS_COURSE_ID"].stringValue
                    tempSection.name = json [i][j]["NAME"].stringValue
                    tempSection.section = json[i][j]["SECTION"].stringValue
                    tempSection.session = json[i][j]["SESSION"].stringValue
                    tempSection.units = json[i][j]["UNIT_CODE"].doubleValue
                    tempSection.type = json[i][j]["TYPE"].stringValue
                    tempSection.beginTime = json[i][j]["BEGIN_TIME"].stringValue
                    tempSection.endTime = json[i][j]["END_TIME"].stringValue
                    tempSection.day = json[i][j]["DAY"].stringValue
                    tempSection.numRegistered = json[i][j]["REGISTERED"].doubleValue
                    tempSection.numSeats = json[i][j]["SEATS"].doubleValue
                    tempSection.instructor = json[i][j]["INSTRUCTOR"].stringValue
                    tempSection.location = json[i][j]["LOCATION"].stringValue
                    tempSection.addDate = json[i][j]["ADD_DATE"].stringValue
                    tempSection.cancelDate = json[i][j]["CANCEL_DATE"].stringValue
                    tempSection.publishFlag = json[i][j]["PUBLISH_FLAG"].stringValue
                    tempSection.inCourseBin = 0
                    
                }
                
                
            }
            println("fetched all courses and sections")
        })
        
        task.resume()
        
    }
    
    class func getCurrentSections() -> [section]{ //returns array of sections currently enrolled in 
        
        /*
        
        var cs104lec = section(termCode: "term code", courseID: 1234, sisCourseID: "CS 104", name: "Data Structures and stuff", section: "2777R", session: "Srping 2015", units: 10, type: "Lecture", beginTime: "10 AM", endTime: "11 AM" , day: "MWF", numRegistered: 12, numSeats: 50, instructor: "Mark Redekopp", location: "ZHS 252" , addDate: "na", cancelDate: "na", PublishFlag: "y")
        
    
        var cs104dis = section(termCode: "term code", courseID: 1234, sisCourseID: "CS 104", name: "Data Structures and stuff", section: "2772R", session: "Srping 2015", units: 10, type: "Lab", beginTime: "10 AM", endTime: "11 AM" , day: "TTh", numRegistered: 12, numSeats: 50, instructor: "na", location: "SAL 126" , addDate: "na", cancelDate: "na", PublishFlag: "y")*/
        
        
        
     
        
        return []
        
    
    }
    
    class func getSchoolList () -> [School] {
        
        /*
        
        var Viterbi = school(schoolCode: "ENGR", schoolDescription: "Viterbi School of Engineering", departments: [])
        var Marshall = school(schoolCode: "BUAD", schoolDescription: "Marshall School of Business", departments: [])
        
            */
        return []
    }
    
    class func getDeptBySchool (schoolname: String) -> [department] {
        
        
        if (schoolname == "Viterbi"){
      
            var compsci = department (departmentCode: "CSCI", departmentDescription: "Computer Science", schoolCode: "ENGR")
           
            var meche = department(departmentCode: "MECH", departmentDescription: "Mechanical Engineering", schoolCode: "ENGR")
            
            return [compsci, meche]
            
        }
        
        else {return []}
        
    }
    
    class func getCourseByDept (deptname: String) -> [course] {
        /*
        
        if (deptname == "CSCI"){
            var cs103 = course (courseID: 12345, sisCourseID: "CS 103", title: "Introduction to Programming", minUnits: 0, maxUnits: 10, totalMax: 10, description: "Learn About Programming", divFlag: "Y", effecTerm: "spring 2015", sectionList: [])
         
            
           var cs104 = course (courseID: 1234, sisCourseID: "CS 104", title: "Introduction to Data Structures", minUnits: 0, maxUnits: 10, totalMax: 10, description: "Learn About Data Structures", divFlag: "Y", effecTerm: "spring 2015", sectionList: [])
            
            return [cs103, cs104]*/
        
        
        return []
        
    }
    
     class func getSectionsByCourse (coursename: String) -> [section] {
        
        
        if (coursename == "CS 104") {
            
            
            var cs104lec = section(termCode: "term code", courseID: 1234, sisCourseID: "CS 104", name: "Data Structures and stuff", section: "2777R", session: "Srping 2015", units: 10, type: "Lecture", beginTime: "10 AM", endTime: "11 AM" , day: "MWF", numRegistered: 12, numSeats: 50, instructor: "Mark Redekopp", location: "ZHS 252" , addDate: "na", cancelDate: "na", PublishFlag: "y")
            
            
            var cs104dis = section(termCode: "term code", courseID: 1234, sisCourseID: "CS 104", name: "Data Structures and stuff", section: "2772R", session: "Srping 2015", units: 10, type: "Lab", beginTime: "10 AM", endTime: "11 AM" , day: "TTh", numRegistered: 12, numSeats: 50, instructor: "na", location: "SAL 126" , addDate: "na", cancelDate: "na", PublishFlag: "y")
            
            
            
            return [cs104lec, cs104dis]

            
        }
        
        else {return []}
        
    }
    
    class func addSectiontoCourseBin (toAdd: Double){ //pass the course ID
        
        //TODO
        
        
    }
    
    class func removeSectionFromCourseBin (toRemove: Double) { //pass the course ID
    
    //TODO
    
    }
}