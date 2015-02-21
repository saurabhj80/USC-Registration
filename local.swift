//
//  local.swift
//
//
//  Created by Darvish Kamalia on 2/20/15.
//
//

import Foundation

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
    var sectionList: [section] //array of all sections belonging to this class
}

struct department {
    
    var departmentCode: String
    var departmentDescription: String
    var schoolCode: String
    
}

struct school {
    
    var schoolCode: String
    var schoolDescription: String
    var departments: [department]
    
    
}

class localStorage {
    
    
    class func getAPIdata () {}
    
    class func getCurrentSections() -> [section]{ //returns array of sections currently enrolled in 
        
        var cs104lec = section(termCode: "term code", courseID: 1234, sisCourseID: "CS 104", name: "Data Structures and stuff", section: "2777R", session: "Srping 2015", units: 10, type: "Lecture", beginTime: "10 AM", endTime: "11 AM" , day: "MWF", numRegistered: 12, numSeats: 50, instructor: "Mark Redekopp", location: "ZHS 252" , addDate: "na", cancelDate: "na", PublishFlag: "y")
        
    
        var cs104dis = section(termCode: "term code", courseID: 1234, sisCourseID: "CS 104", name: "Data Structures and stuff", section: "2772R", session: "Srping 2015", units: 10, type: "Lab", beginTime: "10 AM", endTime: "11 AM" , day: "TTh", numRegistered: 12, numSeats: 50, instructor: "na", location: "SAL 126" , addDate: "na", cancelDate: "na", PublishFlag: "y")
        
     
        
        return [cs104lec, cs104dis]
        
    
    }
    
    class func getSchoolList () -> [school] {
        
        var Viterbi = school(schoolCode: "ENGR", schoolDescription: "Viterbi School of Engineering", departments: [])
        var Marshall = school(schoolCode: "BUAD", schoolDescription: "Marshall School of Business", departments: [])
        
        return [Marshall, Viterbi]
        
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
        
        if (deptname == "CSCI"){
            var cs103 = course (courseID: 12345, sisCourseID: "CS 103", title: "Introduction to Programming", minUnits: 0, maxUnits: 10, totalMax: 10, description: "Learn About Programming", divFlag: "Y", effecTerm: "spring 2015", sectionList: [])
         
            
           var cs104 = course (courseID: 1234, sisCourseID: "CS 104", title: "Introduction to Data Structures", minUnits: 0, maxUnits: 10, totalMax: 10, description: "Learn About Data Structures", divFlag: "Y", effecTerm: "spring 2015", sectionList: [])
            
            return [cs103, cs104]
        }
        
        else {return []}
        
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