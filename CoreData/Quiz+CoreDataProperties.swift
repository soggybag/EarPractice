//
//  Quiz+CoreDataProperties.swift
//  EarPractice
//
//  Created by mitchell hudson on 9/9/16.
//  Copyright © 2016 Mitchell Hudson. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Quiz {

    @NSManaged var date: NSDate?
    @NSManaged var interval: NSNumber?
    @NSManaged var correct: NSNumber?
    @NSManaged var incorrect: NSNumber?

}
