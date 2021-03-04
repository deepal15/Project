//
//  HomeViewController.swift
//  Knockout
//
//

import UIKit
import CoreData

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
    
    private var tournamentTeams: [FixtureManager.TupleElements] = [] {
        didSet {
            viewModel.set(tournamentTeams: tournamentTeams)
        }
    }
    
    var context: NSManagedObjectContext {
        return ((UIApplication.shared.delegate) as! AppDelegate).persistentContainer.viewContext
    }
    
    lazy var viewModel = HomeViewModel(context: context)
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        viewModel.delegate = self
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
        if !self.tournamentTeams.isEmpty {
            viewModel.set(tournamentTeams: self.tournamentTeams)
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func primaryCTATapped(_ sender: Any) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "HomeViewController") as? HomeViewController {
            viewController.isTournamentGoingOn = viewModel.getNumberOfRows() == 2 ? false : true
            
            if isTournamentGoingOn {
                let teams = viewModel.eliminateTeams()
                viewController.isTournamentFinished = (teams.count == 1 && tournamentTeams.count == 1) ? true : false
                viewController.isTournamentGoingOn = (teams.count == 1 && tournamentTeams.count == 1) ? false : true
                viewController.isFinal = (teams.count == 1 && tournamentTeams.count == 1 && viewController.isTournamentFinished) ? true : false
                viewController.tournamentTeams = teams
            } else {
                viewModel.setFixtureData()
                viewController.tournamentTeams = viewModel.getTeamPairs()
                viewController.isTournamentGoingOn = true
            }
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    @IBAction func goHomeTapped(_ sender: Any) {
        viewModel.clearTournamentData()
        navigationController?.popToRootViewController(animated: true)
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tournamentTeams.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.titleCell, for: indexPath)
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.text = viewModel.getTeam(at: indexPath.row)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tournamentCell, for: indexPath) as? TournamentCell else { return UITableViewCell() }
            if isFinal {
                cell.setupUIForWinner(teamPair: viewModel.getTournamentTeam(at: indexPath.row))
            } else {
                cell.setupUIForTournament(teamPair: viewModel.getTournamentTeam(at: indexPath.row))// tournamentTeams[indexPath.row])
            }
            return cell
        }
    }
}
extension HomeViewController: HomeViewModelDelegate {
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
