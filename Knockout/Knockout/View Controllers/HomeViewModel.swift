//
//  HomeViewModel.swift
//  Knockout
//
//

import Foundation
import CoreData

protocol HomeViewModelDelegate: AnyObject {
    func reloadData()
}

final class HomeViewModel {
    
    private var teams: [String] = []
    private var databaseManager: DatabaseManager?
    private var tournamentTeams: [FixtureManager.TupleElements] = []
    weak var delegate: HomeViewModelDelegate?
    
    init(context: NSManagedObjectContext) {
        databaseManager = DatabaseManager(managedObjectContext: context)
        getData()
        delegate?.reloadData()
    }
    
    func set(tournamentTeams: [FixtureManager.TupleElements]) {
        self.tournamentTeams = tournamentTeams
        
    }
    
    func getNumberOfRows() -> Int {
        return tournamentTeams.isEmpty ? teams.count : tournamentTeams.count
    }
    
    func getTeam(at index: Int) -> String {
        return teams[index]
    }
    
    func getTournamentTeam(at Index: Int) -> FixtureManager.TupleElements {
        return tournamentTeams[Index]
    }
    
    @discardableResult
    func getData() -> [String] {
        if UserDefaults.standard.bool(forKey: "DB") {
            teams = getDBData()
        } else {
            teams = getStaticData()
        }
        return teams
    }
    
    private func getStaticData() -> [String] {
        return ["Mumbai Indians",
                "Royal Challenger Banglore",
                "Delhi Capitals",
                "Sunrised Hydrabad",
                "Rajesthan Royals",
                "Chennai Super Kings",
                "Kings XII Punjab",
                "Kolkata Knight Riders"]
    }
    
    private func getDBData() -> [String] {
        if let teams = databaseManager?.getAllTeams() {
            return teams.compactMap { $0.name }
        }
        return []
    }
    
    func setFixtureData() {
        FixtureManager.shared.setData(getData())
    }
    
    func getTeamPairs() -> [FixtureManager.TupleElements] {
        return FixtureManager.shared.getTeamPairs()
    }
    
    func eliminateTeams() -> [FixtureManager.TupleElements] {
        return FixtureManager.shared.eliminateTeams()
    }
    
    
    func clearTournamentData() {
        FixtureManager.shared.clearData()
    }
}
