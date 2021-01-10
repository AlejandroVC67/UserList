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

extension Array where Element : User {
    func transform() -> [UserModel] {
        return self.map { (person) -> UserModel in
            return UserModel(id: person.id,
                             name: person.name,
                             username: person.username,
                             email: person.email,
                             phone: person.phone)
        }
    }
}
