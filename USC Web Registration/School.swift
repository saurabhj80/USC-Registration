//
//  School.swift
//  USC Web Registration
//
//  Created by Darvish Kamalia on 2/21/15.
//  Copyright (c) 2015 Darvish Kamalia. All rights reserved.
//

import Foundation
import CoreData
@objc(School)

class School: NSManagedObject {

    @NSManaged var schoolCode: String
    @NSManaged var schoolDescription: String

}
