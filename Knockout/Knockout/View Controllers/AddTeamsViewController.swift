//
//  AddTeamsViewController.swift
//  Knockout
//
//

import UIKit
import CoreData

class AddTeamsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var context: NSManagedObjectContext {
        return ((UIApplication.shared.delegate) as! AppDelegate).persistentContainer.viewContext
    }
    
    lazy var viewModel = AddTeamsViewModel(context: context)
    
    // MARK - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.viewModel.getAllTeamsFromDB()
        reloadData()
    }
    
    private func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func addTeamCTATapped(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Name", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Okay", style: .default) { [weak self] (_) in
            let textField = alertController.textFields?.first
            let name = textField?.text
            if let name = name, !name.isEmpty {
                self?.viewModel.addTeamToDB(name: name)
                self?.reloadData()
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Team Name"
        }
        alertController.addAction(action)
        alertController.addAction(cancel)
        present(alertController, animated: true, completion: nil)
    }
}

extension AddTeamsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = viewModel.getTeam(at: indexPath.row).name
        return cell
    }
}
