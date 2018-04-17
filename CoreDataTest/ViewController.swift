//
//  ViewController.swift
//  CoreDataTest
//
//  Created by Krzysztof Kempiński on 22.11.2017.
//  Copyright © 2017 test. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        
        user.setValue("John1", forKeyPath: "name")
        user.setValue("john@test.com", forKey: "email")
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let date = formatter.date(from: "1990/10/08")
        user.setValue(date, forKey: "date_of_birth")
        user.setValue(0, forKey: "number_of_children")
        
        let carEntity = NSEntityDescription.entity(forEntityName: "Car", in: managedContext)!

        let car1 = NSManagedObject(entity: carEntity, insertInto: managedContext)
        car1.setValue("Audi TT", forKey: "model")
        car1.setValue(2010, forKey: "year")
        car1.setValue(user, forKey: "user")
        
        let car2 = NSManagedObject(entity: carEntity, insertInto: managedContext)
        car2.setValue("BMW X6", forKey: "model")
        car2.setValue(2014, forKey: "year")
        car2.setValue(user, forKey: "user")
        
        let cars = user.mutableSetValue(forKey: "cars")
        cars.add(car1)
        cars.add(car2)
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        let carFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Car")
        let carsResults = try! managedContext.fetch(carFetch)
        print((carsResults.last as! Car).user)
        
        do {
            let count = try managedContext.count(for: carFetch)
            print(count)
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
        
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        userFetch.fetchLimit = 1
        userFetch.predicate = NSPredicate(format: "name = %@", "John1")
        userFetch.sortDescriptors = [NSSortDescriptor.init(key: "email", ascending: false)]
        
        let users = try! managedContext.fetch(userFetch)
        
        let john: User = users.first as! User
        
        print("Email: \(john.email!)")
        let johnCars = john.cars?.allObjects as! [Car]
        print("has \(johnCars.count)")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

