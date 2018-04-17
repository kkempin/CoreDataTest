//
//  User+CoreDataProperties.swift
//  CoreDataTest
//
//  Created by Krzysztof Kempiński on 17.04.2018.
//  Copyright © 2018 test. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var date_of_birth: NSDate?
    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var number_of_children: Int16
    @NSManaged public var cars: NSSet?

}

// MARK: Generated accessors for cars
extension User {

    @objc(addCarsObject:)
    @NSManaged public func addToCars(_ value: Car)

    @objc(removeCarsObject:)
    @NSManaged public func removeFromCars(_ value: Car)

    @objc(addCars:)
    @NSManaged public func addToCars(_ values: NSSet)

    @objc(removeCars:)
    @NSManaged public func removeFromCars(_ values: NSSet)

}
