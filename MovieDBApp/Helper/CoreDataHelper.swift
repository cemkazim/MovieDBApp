//
//  CoreDataHelper.swift
//  MovieDBApp
//
//  Created by Cem Kazım on 4.07.2021.
//

import UIKit
import CoreData

public class CoreDataHelper {
    
    static let appDelegate: AppDelegate = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return AppDelegate() }
        return appDelegate
    }()
    
    static let context: NSManagedObjectContext = {
        let context = appDelegate.persistentContainer.viewContext
        return context
    }()
    
    func addData(entityName: String) -> NSEntityDescription {
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: CoreDataHelper.context) else { return NSEntityDescription() }
        return entity
    }
    
    func deleteData(entityName: String) -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.returnsObjectsAsFaults = false
        return fetchRequest
    }
}
