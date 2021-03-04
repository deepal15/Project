//
//  AddTeamsViewModel.swift
//  Knockout
//
//

import Foundation
import CoreData

final class AddTeamsViewModel {
    
    // MARK: - Properties
    
    private var teams: [Team] = []
    
    private var databaseManager: DatabaseManager?
    
    // MARK: - Init
    
    init(context: NSManagedObjectContext) {
        databaseManager = DatabaseManager(managedObjectContext: context)
    }
    
    // MARK: - Functions
    
    func addTeamToDB(name: String) {
        databaseManager?.addTeam(name: name)
        teams = getAllTeamsFromDB() ?? []
    }
    
    @discardableResult
    func getAllTeamsFromDB() -> [Team]? {
        self.teams = databaseManager?.getAllTeams() ??  []
        return self.teams
    }
    
    func getNumberOfRows() -> Int {
        return teams.count
    }
    
    func getTeam(at index: Int) -> Team {
        return teams[index]
    }
}
