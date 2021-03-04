//
//  Team+CoreDataProperties.swift
//  Knockout
//
//  Created by Patel, Deepal Atulkumar on 3/4/21.
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
