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
        
        let url =  NSURL(string : "http://petri.esd.usc.edu/socAPI/Schools/ALL")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!,
            
            completionHandler: { (data, response, error) -> Void in
            
            var err: NSError?
            var json = JSON(data: data)
            let x = json.arrayValue.count
            println("Number of Schools")
                println(x)
            
            for i in 0 ... json.arrayValue.count {
            
               let tempSchool = NSEntityDescription.insertNewObjectForEntityForName("School", inManagedObjectContext: context!) as School
                
                tempSchool.schoolDescription = json[i]["SOC_SCHOOL_DESCRIPTION"].stringValue
                tempSchool.schoolCode = json[i]["SOC_SCHOOL_CODE"].stringValue
                context?.save(nil)
                
                let x = json[i]["SOC_DEPARTMENT_CODE"].arrayValue.count
                println("Number of Departments ", x )
                for j in 0 ... json[i]["SOC_DEPARTMENT_CODE"].arrayValue.count {
                    
                        let tempDept = NSEntityDescription.insertNewObjectForEntityForName("Department", inManagedObjectContext: context!) as Department
                        tempDept.departmentCode = json[i]["SOC_DEPARTMENT_CODE"][j]["SOC_DEPARTMENT_CODE"].stringValue
                        tempDept.departmentDescription = json[i]["SOC_DEPARTMENT_CODE"][j]["SOC_DEPARTMENT_DESCRIPTION"].stringValue
                        tempDept.schoolCode = json[i]["SOC_DEPARTMENT_CODE"][j]["SOC_SCHOOL_CODE"].stringValue
                        context?.save(nil)
                    
                }
                
            }
                
        println("fetched all schools")
                
        })
        
        task.resume()
    
        /*
       let  request =  NSURLRequest(URL: NSURL(string : "http://petri.esd.usc.edu/socAPI/Courses/20151/ALL")!)
        
        let task2 = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) ->
            Void in
            
            var err: NSError?
            var json = JSON(data: data)
            
            for i in 0 ... json.arrayValue.count {
                
                let tempCourse = NSEntityDescription.insertNewObjectForEntityForName("Course", inManagedObjectContext: context!) as Course
                
                tempCourse.courseID = json[i]["COURSE_ID"].doubleValue
                
                var courseID = json[i]["SIS_COURSE_ID"].stringValue
                tempCourse.sisCourseID = courseID
                tempCourse.deparmentCode = courseID.substringWithRange(Range<String.Index>(start: courseID.startIndex, end: advance(courseID.startIndex, 4)))
                tempCourse.title = json[i]["TITLE"].stringValue
                tempCourse.minUnits = json[i]["MIN_UNITS"].doubleValue
                tempCourse.maxUnits = json[i]["MAX_UNITS"].doubleValue
                tempCourse.totalMax = json[i]["TOTAL_MAX_UNITS"].doubleValue
                tempCourse.courseDescription = json[i]["DECRIPTION"].stringValue
                tempCourse.divFlag = json[i]["DIVERSITY_FLAG"].stringValue
                tempCourse.effecTerm = json[i]["EFFECTIVE_TERM_CODE"].stringValue
                
                context?.save(nil)
                
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
                    
                    context?.save(nil)
                    
                    if (arc4random_uniform(10) < 5) {
                        
                        tempSection.inCourseBin = 0
                        
                    }
                    
                    else { tempSection.inCourseBin = 1}
                    
                }
                
                
            }
            println("fetched all courses and sections")
            
            
        })
        
        task2.resume()
        
    */

    }
    
    class func getCurrentSections() -> [section]{ //returns array of sections currently enrolled in 
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context = appDelegate.managedObjectContext
        
        println(context)
        
        
        let fetchRequest = NSFetchRequest(entityName: "Section")
        let predicate = NSPredicate(format: "inCourseBin == 1")
        fetchRequest.predicate = predicate
        
        var toReturn: [section] = []
        
        var error: NSError?
        
        if let fetchResults = context!.executeFetchRequest(fetchRequest, error: &error) as [Section]? {
          
            if (fetchResults.count != 0) {
                
                println("count %d",fetchResults.count)
                for i in 0 ... (fetchResults.count - 1)  {
                  
                    
                    var tempSection = section(courseID: fetchResults[i].courseID, sisCourseID: fetchResults[i].sisCourseID, name: fetchResults[i].name, section: fetchResults[i].section, session: fetchResults[i].session, units: fetchResults[i].units, type: fetchResults[i].type, beginTime: fetchResults[i].beginTime, endTime: fetchResults[i].endTime, day: fetchResults[i].day, numRegistered: fetchResults[i].numRegistered, numSeats: fetchResults[i].numSeats, instructor: fetchResults[i].instructor, location: fetchResults[i].location, addDate: fetchResults[i].addDate, cancelDate: fetchResults[i].cancelDate, PublishFlag: fetchResults[i].publishFlag)
                    
                    toReturn.append(tempSection)
                    
                    
                    println("appended")
                  
        
                }
                
            }
            
            else { println("nope")}
                
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
    
    class func getDeptBySchool (schoolcode: String) -> [department] {
        
        
        var toReturn : [department] = []
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest (entityName: "Department")
        let mypredicate = NSPredicate(format: "schoolCode == %@", schoolcode)
        
        fetchRequest.predicate = mypredicate
        
        if let fetchResults = context!.executeFetchRequest(fetchRequest, error: nil)  as [Department]? {
            
            if (fetchResults.count != 0) {
                
                for i in 0 ... (fetchResults.count - 1){
                    
                    toReturn.append(department(departmentCode: fetchResults[i].departmentCode, departmentDescription: fetchResults[i].departmentDescription, schoolCode: fetchResults[i].schoolCode))
                
                }
            
            }
            
        }
        
        return toReturn
    }
    
    class func getCourseByDept (deptCode: String) -> [course] {
       
        var toReturn : [course] = []
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Course")
        
        let myPredicate = NSPredicate (format: "departmentCode == %@", deptCode)
        
        if let fetchResults = context!.executeFetchRequest(fetchRequest, error: nil) as [Course]?{
         
            if (fetchResults.count != 0) {
                
                for i in 0 ... (fetchResults.count - 1){
                    
                    toReturn.append(course(courseID: fetchResults[i].courseID, sisCourseID: fetchResults[i].sisCourseID, title: fetchResults[i].title, minUnits: fetchResults[i].minUnits, maxUnits: fetchResults[i].maxUnits, totalMax: fetchResults[i].totalMax, description: fetchResults[i].description, divFlag: fetchResults[i].divFlag, effecTerm: fetchResults[i].effecTerm))
                }
                
            }
            
        }
        
        return toReturn
        
    }
    
     class func getSectionsByCourse (coursename: String) -> [section] {
        
        var toReturn : [section] = []
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Section")
        
        let myPredicate = NSPredicate (format: "sisCourseID == @#", coursename)
        
        if let fetchResults = context!.executeFetchRequest(fetchRequest, error: nil) as [Section]?{
            
            if (fetchResults.count != 0) {
                
                for i in 0 ... (fetchResults.count - 1){
                    
                    toReturn.append(section(courseID: fetchResults[i].courseID, sisCourseID: fetchResults[i].sisCourseID, name: fetchResults[i].name, section: fetchResults[i].section, session: fetchResults[i].session, units: fetchResults[i].units, type: fetchResults[i].type, beginTime: fetchResults[i].beginTime, endTime: fetchResults[i].endTime, day: fetchResults[i].day, numRegistered: fetchResults[i].numRegistered, numSeats: fetchResults[i].numSeats, instructor: fetchResults[i].instructor, location: fetchResults[i].location, addDate: fetchResults[i].addDate, cancelDate: fetchResults[i].cancelDate, PublishFlag: fetchResults[i].publishFlag))
                    
                }
                
            }
            
        }
        
        return toReturn
     
        
    }
    
    class func addSectiontoCourseBin (toAdd: String){ //pass the section name
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Section")
        
        let myPredicate = NSPredicate (format: "section == @#", toAdd)
        fetchRequest.predicate = myPredicate
        
        if let fetchResults  = context?.executeFetchRequest(fetchRequest, error: nil) as [Section]? {
            
            var tempSection = fetchResults[0]
            tempSection.setValue(1, forKey: "inCourseBin")
            context?.save(nil)
            
        }
        
        
    }
    
    class func removeSectionFromCourseBin (toRemove: String) { //pass the course ID
    
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context = appDelegate.managedObjectContext
        
        let myPredicate = NSPredicate (format: "section == @#", toRemove)
        
        let fetchRequest = NSFetchRequest(entityName: "Section")
        fetchRequest.predicate = myPredicate
        
        if let fetchResults  = context?.executeFetchRequest(fetchRequest, error: nil) as [Section]? {
            
            var tempSection = fetchResults[0]
            tempSection.setValue(0, forKey: "inCourseBin")
            context?.save(nil)
            
        }
        
        
    }
}