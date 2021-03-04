//
//  DatabaseManager.swift
//  Knockout
//
//

import Foundation
import CoreData

//final class DatabaseManager {
//    
//    // MARK: - Properties
//    
//    private let managedObjectContext: NSManagedObjectContext
//    
//    // MARK: - Initializer
//    
//    init(managedObjectContext: NSManagedObjectContext) {
//        self.managedObjectContext = managedObjectContext
//    }
//    
//    // MARK: - Functions
//    
//    func getAllTeams() -> [Team]? {
//        let teamFetchRequest: NSFetchRequest<Student> = Team.fetchRequest()
//        do {
//            let result = try managedObjectContext.fetch(teamFetchRequest)
//            return result
//        } catch {
//            print(error.localizedDescription)
//        }
//        return nil
//    }
//    
//    func addTeam(name: String, completion: Completion) {
//        let Team = Team(context: managedObjectContext)
//        team.name = name
//
//            save()
//            completion(true, students)
//
//    }
//    
//    private func save() {
//        do {
//            try  managedObjectContext.save()
//        } catch {
//            print("DB error \(error.localizedDescription)")
//        }
//    }
//}
