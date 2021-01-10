//
//  CacheManager.swift
//  UserList
//
//  Created by Diego Alejandro Villa Cardenas on 9/01/21.
//

import Foundation
import UIKit
import CoreData

final class CacheManager {
    
    private enum Constants {
        static let entityName = "User"
    }
    
    static func save(users: [UserModel], context: NSManagedObjectContext?) {
        guard let context = context,
              let entity = NSEntityDescription.entity(forEntityName: Constants.entityName, in: context) else {
            return
            
        }
        deleteAllData(context: context)
        
        users.forEach {
            let user = User(entity: entity, insertInto: context)
            user.id = $0.id
            user.name = $0.name
            user.username = $0.username
            user.email = $0.email
            user.phone = $0.phone
        }
        
        do {
            try context.save()
        } catch {
            print("Error saving users", error.localizedDescription)
        }
    }
    
    static func retrieve(from context: NSManagedObjectContext?) -> [User] {
        var cachedUsers: [User] = []
        
        guard let context = context else { return cachedUsers }
    
        let request = NSFetchRequest<NSManagedObject>(entityName: Constants.entityName)
        
        do {
            cachedUsers = try context.fetch(request) as? [User] ?? []
        } catch {
            print("Error saving users", error.localizedDescription)
        }
        
        return cachedUsers
    }
    
    static func retrieveBasedOn(predicate: NSPredicate) -> [UserModel] {
        var filteredUsers: [UserModel] = []
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let context = appDelegate?.persistentContainer.viewContext else { return filteredUsers }
        
        let request = NSFetchRequest<NSManagedObject>(entityName: Constants.entityName)
        request.predicate = predicate
        
        do {
            let cachedUsers = try context.fetch(request) as? [User] ?? []
            filteredUsers = cachedUsers.transform()
        } catch {
            print("Error saving users", error.localizedDescription)
        }
        
        return filteredUsers
    }
    
    static func deleteAllData(context: NSManagedObjectContext) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.entityName)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                context.delete(objectData)
            }
        } catch let error {
            print("Detele all data in \(Constants.entityName) error :", error)
        }
    }
}
