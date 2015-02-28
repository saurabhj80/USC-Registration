//
//  Section.swift
//  USC Web Registration
//
//  Created by Darvish Kamalia on 2/27/15.
//  Copyright (c) 2015 Darvish Kamalia. All rights reserved.
//

import Foundation
import CoreData

@objc(Section)

class Section: NSManagedObject {

    @NSManaged var addDate: String
    @NSManaged var beginTime: String
    @NSManaged var cancelDate: String
    @NSManaged var courseID: Double
    @NSManaged var day: String
    @NSManaged var endTime: String
    @NSManaged var inCourseBin: Double
    @NSManaged var instructor: String
    @NSManaged var location: String
    @NSManaged var name: String
    @NSManaged var numRegistered: Double
    @NSManaged var numSeats: Double
    @NSManaged var publishFlag: String
    @NSManaged var section: String
    @NSManaged var session: String
    @NSManaged var sisCourseID: String
    @NSManaged var termCode: String
    @NSManaged var type: String
    @NSManaged var units: Double
    @NSManaged var sectonID: Double

}
