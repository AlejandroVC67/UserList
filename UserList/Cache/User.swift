//
//  User.swift
//  UserList
//
//  Created by Diego Alejandro Villa Cardenas on 9/01/21.
//

import CoreData

class User: NSManagedObject {

    @NSManaged var id: Int
    @NSManaged var name: String
    @NSManaged var username: String
    @NSManaged var phone: String
    @NSManaged var email: String

    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
}
