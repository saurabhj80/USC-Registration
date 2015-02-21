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
    
    var beginTime: string
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
    var courseID: double
    var sisCourseID: string //the name of the course. Ex. "CS 103" 
    var title: string //Ex. Introduction to Programming
    var minUnits: double
    var maxUnits: double //this will probably be the more useful one
    var totalMax: double
    var description: string //course description
    var divFlag: string //"Y" indicates that diversity requirement is fulfilled 
    var effecTerm: string //Semester that the course belongs to 
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
    
 
    
}