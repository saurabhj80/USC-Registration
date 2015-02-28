//
//  Department.swift
//  USC Web Registration
//
//  Created by Darvish Kamalia on 2/21/15.
//  Copyright (c) 2015 Darvish Kamalia. All rights reserved.
//

import Foundation
import CoreData
@objc (Department)

class Department: NSManagedObject {

    @NSManaged var departmentCode: String
    @NSManaged var departmentDescription: String
    @NSManaged var schoolCode: String
    @NSManaged var school: School

}
