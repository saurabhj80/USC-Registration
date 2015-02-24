//
//  Course.swift
//  USC Web Registration
//
//  Created by Darvish Kamalia on 2/21/15.
//  Copyright (c) 2015 Darvish Kamalia. All rights reserved.
//

import Foundation
import CoreData
@objc(Course)

class Course: NSManagedObject {

    @NSManaged var courseID: NSNumber
    @NSManaged var sisCourseID: String
    @NSManaged var title: String
    @NSManaged var minUnits: NSNumber
    @NSManaged var maxUnits: NSNumber
    @NSManaged var totalMax: NSNumber
    @NSManaged var courseDescription: String
    @NSManaged var divFlag: String
    @NSManaged var effecTerm: String

}
