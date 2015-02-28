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
    
    var sectionID: Double
    
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
    
    var departmentCode: String
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

class localStorage : SchoolTableViewControllerDelegate, DeptTableViewControllerDelegate, CourseTableViewControllerDelegate, DisLecLabTableViewControllerDelegate, CourseBinTableViewControllerDelegate {
    
    func reloadDisLecLabTable(controller: DisLecLabTableViewController) {
        
        let courseString = String (format: "%.0f", controller.courseSections!.courseID)
        let urlString = "http://petri.esd.usc.edu/socAPI/Courses/20151/" + courseString
        
        let url =  NSURL(string: urlString)
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        let task = session.dataTaskWithURL(url!, completionHandler: {(data, response, error) -> Void in
            
            
            var json = JSON(data: data)
            var tempArray = [section]()
            
            if (json["V_SOC_SECTION"].arrayValue.count != 0) {
            for j in 0 ... (json["V_SOC_SECTION"].arrayValue.count - 1){
                
            println("SECTION ID")
                println(json["V_SOC_SECTION"][j]["SECTION_ID"].doubleValue)
                
                let tempSection = section (sectionID: json["V_SOC_SECTION"][j]["SECTION_ID"].doubleValue, courseID: json["COURSE_ID"].doubleValue, sisCourseID: json["SIS_COURSE_ID"].stringValue, name: json ["V_SOC_SECTION"][j]["NAME"].stringValue, section: json["V_SOC_SECTION"][j]["SECTION"].stringValue, session: json["V_SOC_SECTION"][j]["SESSION"].stringValue, units: json["V_SOC_SECTION"][j]["UNIT_CODE"].doubleValue, type: json["V_SOC_SECTION"][j]["TYPE"].stringValue, beginTime: json["V_SOC_SECTION"][j]["BEGIN_TIME"].stringValue, endTime: json["V_SOC_SECTION"][j]["END_TIME"].stringValue, day: json["V_SOC_SECTION"][j]["DAY"].stringValue, numRegistered: json["V_SOC_SECTION"][j]["REGISTERED"].doubleValue, numSeats: json["V_SOC_SECTION"][j]["SEATS"].doubleValue, instructor: json["V_SOC_SECTION"][j]["INSTRUCTOR"].stringValue, location: json["V_SOC_SECTION"][j]["LOCATION"].stringValue, addDate: json["V_SOC_SECTION"][j]["ADD_DATE"].stringValue, cancelDate: json["V_SOC_SECTION"][j]["CANCEL_DATE"].stringValue, PublishFlag: json["V_SOC_SECTION"][j]["PUBLISH_FLAG"].stringValue)
        
            
            tempArray.append(tempSection)
                
            }
                
            }
            
            controller.allSections = tempArray
            println("done")
            
            
            for sections in controller.allSections
            {
                println("type")
                println(sections.type)
                
                if sections.type == "Lecture"{
                    controller.lectures.append(sections)
                    
                }
                else if sections.type == "Lab"{
                    controller.labs.append(sections)
                }
                else if sections.type == "Discussion"{
                    controller.discussion.append(sections)
                }
                else{
                    controller.quiz.append(sections)
                }
            }
            
           
            dispatch_async(dispatch_get_main_queue()) {
                controller.tableView.reloadData()
            }
        
            
            })
        
        task.resume()
        
    }
    
    func reloadCourseTable(controller: CourseTableViewController) {
        let url =  NSURL(string : "http://petri.esd.usc.edu/socAPI/Courses/20151/" + controller.departmentCode!)
            
        println(url)
            
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
            
            let task = session.dataTaskWithURL(url!, completionHandler: {(data, response, error) -> Void in
                
                
                var json = JSON(data: data)
                var tempArray: [course] = []
                
                
                if (json.arrayValue.count != 0) {
                for i in 0 ... (json.arrayValue.count - 1){
                    
                    println(json[i]["SIS_COURSE_ID"].stringValue)
                    var tempCourse = course (departmentCode: controller.departmentCode!, courseID: json[i]["COURSE_ID"].doubleValue, sisCourseID: json[i]["SIS_COURSE_ID"].stringValue, title: json[i]["TITLE"].stringValue, minUnits: json[i]["MIN_UNITS"].doubleValue, maxUnits: json[i]["MAX_UNITS"].doubleValue, totalMax: json[i]["TOTAL_MAX_UNITS"].doubleValue, description: json[i]["DESCRIPTION"].stringValue, divFlag: json[i]["DIVERSITY_FLAG"].stringValue, effecTerm: json[i]["EFFECTIVE_TERM_CODE"].stringValue)
                    
                    tempArray.append(tempCourse)
                    println("appended")
                    println(tempArray[i].description)
                    
                }
                }
                controller.courseList = tempArray
                dispatch_async(dispatch_get_main_queue()) {
                    controller.stopActivity()
                    controller.tableView.reloadData()
                }

            })
            
            
        task.resume()
            
    }
    
    
    func reloadDeptTable(controller: DeptTableViewController, dataArray: [department]) {
    

            let url =  NSURL(string : "http://petri.esd.usc.edu/socAPI/Schools/" + controller.schoolcode!)
            println(url)
        
            let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        
            let session = NSURLSession(configuration: config)

            let task = session.dataTaskWithURL(url!,
                
                completionHandler: { (data, response, error) -> Void in
                    
                    var err: NSError?
                    var json = JSON(data: data)
                    
                    var tempArray :[department] = []
                    
                    if (json[0]["SOC_DEPARTMENT_CODE"].arrayValue.count != 0) {
                    for i in 0 ... (json[0]["SOC_DEPARTMENT_CODE"].arrayValue.count - 1) {
                        
                        println(json[0]["SOC_DEPARTMENT_CODE"][i]["SOC_DEPARTMENT_CODE"].stringValue)
                        
                        let temp = department (departmentCode: json[0]["SOC_DEPARTMENT_CODE"][i]["SOC_DEPARTMENT_CODE"].stringValue, departmentDescription: json[0]["SOC_DEPARTMENT_CODE"][i]["SOC_DEPARTMENT_DESCRIPTION"].stringValue, schoolCode: json[0]["SOC_DEPARTMENT_CODE"][i]["SOC_SCHOOL_CODE"].stringValue)
                        
                        tempArray.append(temp)
                        
                    }
                        
                    }
                    
                    controller.deptArray = tempArray
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        controller.tableView.reloadData()
                    }
                    
            })
        
        task.resume()
        
    }
    

    
    func reloadSchoolTable(controller: SchoolTableViewController, dataArray: [school]) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context = appDelegate.managedObjectContext
        
        let url =  NSURL(string : "http://petri.esd.usc.edu/socAPI/Schools/ALL")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!,
            
            completionHandler: { (data, response, error) -> Void in
                
                var err: NSError?
                var json = JSON(data: data)
                let x = json.arrayValue.count
            
                var tempArray :[school] = []
                
                if (json.arrayValue.count != 0){
                for i in 0 ... (json.arrayValue.count - 1) {
                    
                    let temp = school (schoolCode: json[i]["SOC_SCHOOL_CODE"].stringValue, schoolDescription: json[i]["SOC_SCHOOL_DESCRIPTION"].stringValue)
                    
                    tempArray.append(temp)
                    
                }
                    
                }
                
                controller.schoolArray = tempArray
                
                dispatch_async(dispatch_get_main_queue()) {
                    controller.tableView.reloadData()
                }
                
        })
        
        task.resume()
        
    }
    
    class func getAPIdata () {
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context = appDelegate.managedObjectContext
        
        println(context)
        
        
        
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
                    
    
                    
                }
                
                
            }
            println("fetched all courses and sections")
            
            
        })
        
        task2.resume()
        
        
        
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
                    
                    var tempSection = section(sectionID: fetchResults[i].sectonID, courseID: fetchResults[i].courseID, sisCourseID: fetchResults[i].sisCourseID, name: fetchResults[i].name, section: fetchResults[i].section, session: fetchResults[i].session, units: fetchResults[i].units, type: fetchResults[i].type, beginTime: fetchResults[i].beginTime, endTime: fetchResults[i].endTime, day: fetchResults[i].day, numRegistered: fetchResults[i].numRegistered, numSeats: fetchResults[i].numSeats, instructor: fetchResults[i].instructor, location: fetchResults[i].location, addDate: fetchResults[i].addDate, cancelDate: fetchResults[i].cancelDate, PublishFlag: fetchResults[i].publishFlag)
                    
                    toReturn.append(tempSection)
                    
                    println("appended")
                    
                    
                }
                
            }
                
            else { println("nope")}
            
        }
        
        
        return toReturn
        
    }
    
    func reloadCourses(controller: CourseBinTableViewController) {
        
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
                    
                    var tempSection = section(sectionID: fetchResults[i].sectonID, courseID: fetchResults[i].courseID, sisCourseID: fetchResults[i].sisCourseID, name: fetchResults[i].name, section: fetchResults[i].section, session: fetchResults[i].session, units: fetchResults[i].units, type: fetchResults[i].type, beginTime: fetchResults[i].beginTime, endTime: fetchResults[i].endTime, day: fetchResults[i].day, numRegistered: fetchResults[i].numRegistered, numSeats: fetchResults[i].numSeats, instructor: fetchResults[i].instructor, location: fetchResults[i].location, addDate: fetchResults[i].addDate, cancelDate: fetchResults[i].cancelDate, PublishFlag: fetchResults[i].publishFlag)
                    
                    toReturn.append(tempSection)
                    
                    println("appended")
                    
                    
                }
                
            }
                
            else { println("nope")}
            
            
        }

        println("reloading")
        controller.arr = toReturn
        println(controller.arr.count)
        dispatch_async(dispatch_get_main_queue()) {
            controller.tableView.reloadData()
        }
    }
    
    
    
    class func getSchoolList () -> [school] {
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest (entityName: "School")
        
        var toReturn : [school] = []
        
        if let fetchResult = context!.executeFetchRequest(fetchRequest, error: nil) as [School]? {
            println("HERE", fetchResult.count)
            if (fetchResult.count != 0) {
                println(fetchResult.count)
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
        
        let myPredicate = NSPredicate (format: "deparmentCode == %@", deptCode)
        
        if let fetchResults = context!.executeFetchRequest(fetchRequest, error: nil) as [Course]?{
            
            if (fetchResults.count != 0) {
                
                for i in 0 ... (fetchResults.count - 1){
                    
                    toReturn.append(course(departmentCode: "", courseID: fetchResults[i].courseID, sisCourseID: fetchResults[i].sisCourseID, title: fetchResults[i].title, minUnits: fetchResults[i].minUnits, maxUnits: fetchResults[i].maxUnits, totalMax: fetchResults[i].totalMax, description: fetchResults[i].description, divFlag: fetchResults[i].divFlag, effecTerm: fetchResults[i].effecTerm))
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
        
        let myPredicate = NSPredicate (format: "sisCourseID == %@", coursename)
        
        if let fetchResults = context!.executeFetchRequest(fetchRequest, error: nil) as [Section]?{
            
            if (fetchResults.count != 0) {
                
                for i in 0 ... (fetchResults.count - 1){
                    
                    toReturn.append(section(sectionID: fetchResults[i].sectonID,  courseID: fetchResults[i].courseID, sisCourseID: fetchResults[i].sisCourseID, name: fetchResults[i].name, section: fetchResults[i].section, session: fetchResults[i].session, units: fetchResults[i].units, type: fetchResults[i].type, beginTime: fetchResults[i].beginTime, endTime: fetchResults[i].endTime, day: fetchResults[i].day, numRegistered: fetchResults[i].numRegistered, numSeats: fetchResults[i].numSeats, instructor: fetchResults[i].instructor, location: fetchResults[i].location, addDate: fetchResults[i].addDate, cancelDate: fetchResults[i].cancelDate, PublishFlag: fetchResults[i].publishFlag))
                    
                }
                
            }
            
        }
        
        return toReturn
        
        
    }
    
    class func addSectiontoCourseBin (toAdd: Double){ //pass the section ID
        
        println("added")
        println(toAdd)
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context = appDelegate.managedObjectContext
        
        let tempSection = NSEntityDescription.insertNewObjectForEntityForName("Section", inManagedObjectContext: context!) as Section
        
        let url = NSURL(string: "http://petri.esd.usc.edu/socAPI/Sections/" + String(format: "%0.f", toAdd))
        println(url)
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        let task = session.dataTaskWithURL(url!, completionHandler: {(data, response, error) ->
            Void in
            
            var err: NSError?
            var json = JSON(data: data)
            tempSection.termCode = json[0]["TERM_CODE"].stringValue
            tempSection.courseID = json[0]["COURSE_ID"].doubleValue
            tempSection.sisCourseID = json[0]["SIS_COURSE_ID"].stringValue
            tempSection.name = json[0]["NAME"].stringValue
            tempSection.section = json[0]["SECTION"].stringValue
            tempSection.session = json[0]["SESSION"].stringValue
            tempSection.units = json[0]["UNIT_CODE"].doubleValue
            tempSection.type = json[0]["TYPE"].stringValue
            tempSection.beginTime = json[0]["BEGIN_TIME"].stringValue
            tempSection.endTime = json[0]["END_TIME"].stringValue
            tempSection.day = json[0]["DAY"].stringValue
            tempSection.numRegistered = json[0]["REGISTERED"].doubleValue
            tempSection.numSeats = json[0]["SEATS"].doubleValue
            tempSection.instructor = json[0]["INSTRUCTOR"].stringValue
            tempSection.location = json[0]["LOCATION"].stringValue
            tempSection.addDate = json[0]["ADD_DATE"].stringValue
            tempSection.cancelDate = json[0]["CANCEL_DATE"].stringValue
            tempSection.publishFlag = json[0]["PUBLISH_FLAG"].stringValue
            tempSection.inCourseBin = 1
            
            context?.save(nil)
            
            println("added to context")
            println(tempSection.courseID)
            
            })
        
        task.resume()

        
    }
    


     func removeSectionFromCourseBin (toRemove: String) { //pass the course ID
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context = appDelegate.managedObjectContext
        
        let myPredicate = NSPredicate (format: "section == %@", toRemove)
        
        let fetchRequest = NSFetchRequest(entityName: "Section")
        fetchRequest.predicate = myPredicate
        
        if let fetchResults  = context?.executeFetchRequest(fetchRequest, error: nil) as [Section]? {
            
            var tempSection = fetchResults[0]
            tempSection.setValue(0, forKey: "inCourseBin")
            context?.save(nil)
            
        }
        
        
    }
    
    class func getCourseNamebyID (courseID: Double) -> String {
        
        return "NAME"
        
    }
    
    class func getUnitsbyCourseID (courseID: Double) -> Double {
    
        return 4
    }
}