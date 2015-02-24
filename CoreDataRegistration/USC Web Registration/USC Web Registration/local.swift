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
    
   // var termcode: String
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
        
        println(context)
        
        var request =  NSURLRequest(URL: NSURL(string : "http://petri.esd.usc.edu/socAPI/Schools/ALL")!)
        
        var task = NSURLSession.sharedSession().dataTaskWithRequest(request,
            
            completionHandler: { (data, response, error) -> Void in
            
            var err: NSError?
            var json = JSON(data: data)
            
            for i in 0 ... json.arrayValue.count {
            
               let tempSchool = NSEntityDescription.insertNewObjectForEntityForName("School", inManagedObjectContext: context!) as School
                
                tempSchool.schoolDescription = json[i]["SOC_SCHOOL_DESCRIPTION"].stringValue
                tempSchool.schoolCode = json[i]["SOC_SCHOOL_CODE"].stringValue
                
                for j in 0 ... json[i]["SOC_DEPARTMENT_CODE"].arrayValue.count {
                    
                        let tempDept = NSEntityDescription.insertNewObjectForEntityForName("Department", inManagedObjectContext: context!) as Department
                        tempDept.departmentCode = json[i]["SOC_DEPARTMENT_CODE"][j]["SOC_DEPARTMENT_CODE"].stringValue
                        tempDept.departmentDescription = json[i]["SOC_DEPARTMENT_CODE"][j]["SOC_DEPARTMENT_DESCRIPTION"].stringValue
                        tempDept.schoolCode = json[i]["SOC_DEPARTMENT_CODE"][j]["SOC_SCHOOL_CODE"].stringValue
                    
                }
                
            }
                
        println("fetched all schools")
                
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
                
                println(json[i]["V_SOC_SECTION"].arrayValue.count)
                for j in 0 ... json[i]["V_SOC_SECTION"].arrayValue.count {
                    
                
                    let tempSection = NSEntityDescription.insertNewObjectForEntityForName("Section", inManagedObjectContext: context!) as Section
                    
                    tempSection.termCode = json[i]["V_SOC_SECTION"][j]["TERM_CODE"].stringValue
                    tempSection.courseID = json[i]["V_SOC_SECTION"][j]["COURSE_ID"].doubleValue
                    tempSection.sisCourseID = json[i]["V_SOC_SECTION"][j]["SIS_COURSE_ID"].stringValue
                    tempSection.name = json [i]["V_SOC_SECTION"][j]["NAME"].stringValue
                    tempSection.section = json[i]["V_SOC_SECTION"][j]["SECTION"].stringValue
                    tempSection.session = json[i]["V_SOC_SECTION"][j]["SESSION"].stringValue
                    tempSection.units = json[i]["V_SOC_SECTION"][j]["UNIT_CODE"].doubleValue
                    tempSection.type = json[i]["V_SOC_SECTION"][j]["TYPE"].stringValue
                    tempSection.beginTime = json[i]["V_SOC_SECTION"][j]["BEGIN_TIME"].stringValue
                    tempSection.endTime = json[i]["V_SOC_SECTION"][j]["END_TIME"].stringValue
                    tempSection.day = json[i]["V_SOC_SECTION"][j]["DAY"].stringValue
                    tempSection.numRegistered = json[i]["V_SOC_SECTION"][j]["REGISTERED"].doubleValue
                    tempSection.numSeats = json[i]["V_SOC_SECTION"][j]["SEATS"].doubleValue
                    tempSection.instructor = json[i]["V_SOC_SECTION"][j]["INSTRUCTOR"].stringValue
                    tempSection.location = json[i]["V_SOC_SECTION"][j]["LOCATION"].stringValue
                    tempSection.addDate = json[i]["V_SOC_SECTION"][j]["ADD_DATE"].stringValue
                    tempSection.cancelDate = json[i]["V_SOC_SECTION"][j]["CANCEL_DATE"].stringValue
                    tempSection.publishFlag = json[i]["V_SOC_SECTION"][j]["PUBLISH_FLAG"].stringValue
                    if (arc4random_uniform(10) < 5) {
                        
                        tempSection.inCourseBin = 0
                        
                    }
                    
                    else { tempSection.inCourseBin = 1}
                    
                }
                
                
            }
            println("fetched all courses and sections")
        })
        
        task.resume()
        
    }
    
    class func getCurrentSections() -> [section]{ //returns array of sections currently enrolled in 
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context = appDelegate.managedObjectContext
        
        println(context)
        
        
        let fetchRequest = NSFetchRequest(entityName: "Section")
        let sortDescriptor = NSSortDescriptor (key: "inCourseBin", ascending: true)
        let predicate = NSPredicate(format: "inCourseBin == 1")
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = predicate
        
        var toReturn: [section] = []
        
        
        var error: NSError?
        
        if let fetchResults = context!.executeFetchRequest(fetchRequest, error: &error) as [Section]? {
          
            if (fetchResults.count != 0) {
                
                for i in 0 ... (fetchResults.count - 1)  {
                    
                    var tempSection = section(courseID: fetchResults[i].courseID, sisCourseID: fetchResults[i].sisCourseID, name: fetchResults[i].name, section: fetchResults[i].section, session: fetchResults[i].session, units: fetchResults[i].units, type: fetchResults[i].type, beginTime: fetchResults[i].beginTime, endTime: fetchResults[i].endTime, day: fetchResults[i].day, numRegistered: fetchResults[i].numRegistered, numSeats: fetchResults[i].numSeats, instructor: fetchResults[i].instructor, location: fetchResults[i].location, addDate: fetchResults[i].addDate, cancelDate: fetchResults[i].cancelDate, PublishFlag: fetchResults[i].publishFlag)
                    
                    println("appended")
                    toReturn.append(tempSection)
        
                }
                
            }
                
        }
    
    
        return toReturn
        
    
    }
    
    class func getSchoolList () -> [school] {
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest (entityName: "School")
        
        var toReturn : [school] = []
        
        if let fetchResult = context!.executeFetchRequest(fetchRequest, error: nil) as [School]? {
            
            if (fetchResult.count != 0) {
                
                for i in 0 ... (fetchResult.count - 1)  {
            
            toReturn.append(school(schoolCode: fetchResult[i].schoolCode, schoolDescription: fetchResult[i].schoolDescription))
                    
                }
                
            }
            
        }
        
        return toReturn
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
            
    
            return []

            
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