//
//  Car+CoreDataProperties.swift
//  CoreDataTest
//
//  Created by Krzysztof Kempiński on 17.04.2018.
//  Copyright © 2018 test. All rights reserved.
//
//

import Foundation
import CoreData


extension Car {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Car> {
        return NSFetchRequest<Car>(entityName: "Car")
    }

    @NSManaged public var model: String?
    @NSManaged public var year: Int16
    @NSManaged public var user: User?

}
