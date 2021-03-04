//
//  TournamentCell.swift
//  Knockout
//
//

import UIKit

class TournamentCell: UITableViewCell {

    @IBOutlet weak var teamLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        teamLabel.textAlignment = .center
    }
    
    func setupUIForTournament(teamPair: FixtureManager.TupleElements) {
        teamLabel.text = "\(teamPair.firstElement)\n VS \n\(teamPair.secondElement)"
    }
    
    func setupUIForWinner(teamPair: FixtureManager.TupleElements) {
        teamLabel.text = "1st Position \n \(teamPair.firstElement)\n\n2nd Position \n\(teamPair.secondElement)"
    }
}
