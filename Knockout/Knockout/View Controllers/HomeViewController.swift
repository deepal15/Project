//
//  HomeViewController.swift
//  Knockout
//
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Constants
    
    private struct Constants {
        static let titleCell = "TitleCell"
        static let tournamentCell = "TournamentCell"
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var primaryCTA: UIButton!
    
    var isTournamentGoingOn = false
    var isTournamentFinished = false
    var isFinal = false
    
    // MARK: - Properties
    
    private var data: [String] = ["Mumbai Indians",
                                  "Royal Challenger Banglore",
                                  "Delhi Capitals",
                                  "Sunrised Hydrabad",
                                  "Rajesthan Royals",
                                  "Chennai Super Kings",
                                  "Kings XII Punjab",
                                  "Kolkata Knight Riders"
                                  
    ]
    
    private var tournamentTeams: [FixtureManager.TupleElements] = []
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        tableView.dataSource = self
        navigationItem.hidesBackButton = true
        
        if isTournamentGoingOn {
            if isFinal {
                primaryCTA.setTitle("Simulate & End", for: .normal)
            } else {
                primaryCTA.setTitle("Simulate", for: .normal)
            }
        } else if isTournamentFinished {
            primaryCTA.setTitle("Restart", for: .normal)
        } else {
            primaryCTA.setTitle("Start IPL", for: .normal)
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func primaryCTATapped(_ sender: Any) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "HomeViewController") as? HomeViewController {
            viewController.isTournamentGoingOn = data.count == 2 ? false : true
            
            if isTournamentGoingOn {
                let teams = FixtureManager.shared.eliminateTeams()
                viewController.isTournamentFinished = (teams.count == 1 && tournamentTeams.count == 1) ? true : false
                viewController.isTournamentGoingOn = (teams.count == 1 && tournamentTeams.count == 1) ? false : true
                viewController.isFinal = (teams.count == 1 && tournamentTeams.count == 1 && viewController.isTournamentFinished) ? true : false
                viewController.tournamentTeams = teams
            } else {
                FixtureManager.shared.setData(data)
                viewController.tournamentTeams = FixtureManager.shared.getTeamPairs()
                viewController.isTournamentGoingOn = true
            }
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tournamentTeams.isEmpty ? data.count : tournamentTeams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tournamentTeams.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.titleCell, for: indexPath)
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.text = data[indexPath.row]
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tournamentCell, for: indexPath) as? TournamentCell else { return UITableViewCell() }
            if isFinal {
                cell.setupUIForWinner(teamPair: tournamentTeams[indexPath.row])
            } else {
                cell.setupUIForTournament(teamPair: tournamentTeams[indexPath.row])
            }
            return cell
        }
    }
}
