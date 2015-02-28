//
//  Course.swift
//  USC Web Registration
//
//  Created by Darvish Kamalia on 2/23/15.
//  Copyright (c) 2015 Darvish Kamalia. All rights reserved.
//

import Foundation
import CoreData

@objc(Course)

class Course: NSManagedObject {

    @NSManaged var courseDescription: String
    @NSManaged var courseID: Double
    @NSManaged var divFlag: String
    @NSManaged var effecTerm: String
    @NSManaged var maxUnits: Double
    @NSManaged var minUnits: Double
    @NSManaged var sisCourseID: String
    @NSManaged var title: String
    @NSManaged var totalMax: Double
    @NSManaged var deparmentCode: String

}
