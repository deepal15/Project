//
//  DatabaseManager.swift
//  Knockout
//
//

import Foundation
import CoreData
import UIKit


final class DatabaseManager {
    
    // MARK: - Properties
    
    private let managedObjectContext: NSManagedObjectContext
    
    // MARK: - Initializer
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    // MARK: - Functions
    
    func getAllTeams() -> [Team]? {
        let teamFetchRequest: NSFetchRequest<Team> = Team.fetchRequest()
        do {
            let result = try managedObjectContext.fetch(teamFetchRequest)
            return result
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func addTeam(name: String) {
        let team = Team(context: managedObjectContext)
        team.name = name
        save()
    }
    
    private func save() {
        do {
            try  managedObjectContext.save()
        } catch {
            print("DB error \(error.localizedDescription)")
        }
    }
}
