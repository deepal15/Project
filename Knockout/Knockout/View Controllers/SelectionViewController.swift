//
//  SelectionViewController.swift
//  Knockout
//
//  Created by Patel, Deepal Atulkumar on 3/4/21.
//

import UIKit

class SelectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func showAddTeam() {
        performSegue(withIdentifier: "AddTeam", sender: nil)
    }
    
    @IBAction func showStaticContent() {
        UserDefaults.standard.setValue(false, forKey: "DB")
        performSegue(withIdentifier: "ShowDBContent", sender: nil)
    }
    
    @IBAction func showDBContent() {
        let context = ((UIApplication.shared.delegate) as! AppDelegate).persistentContainer.viewContext
        let databaseManager = DatabaseManager(managedObjectContext: context)
        if let teams = databaseManager.getAllTeams() {
            if teams.isEmpty {
                showMessage("No Teams found please add one")
            } else if teams.count % 2 == 0 {
                UserDefaults.standard.set(true, forKey: "DB")
                performSegue(withIdentifier: "ShowDBContent", sender: nil)
                
            } else {
                showMessage("Content is not even please add a Team")
            }
        }
    }
    
    private func showMessage(_ message: String) {
        
        let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Okay", style: .default) { [weak self] (_) in
            self?.performSegue(withIdentifier: "AddTeam", sender: nil)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            
        }
        
        alertController.addAction(action)
        alertController.addAction(cancel)
        present(alertController, animated: true, completion: nil)
        
        UserDefaults.standard.setValue(false, forKey: "DB")
    }
}
