//
//  Team+CoreDataProperties.swift
//  Knockout
//
//
//

import Foundation
import CoreData


extension Team {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Team> {
        return NSFetchRequest<Team>(entityName: "Team")
    }

    @NSManaged public var name: String?

}

extension Team : Identifiable {

}
