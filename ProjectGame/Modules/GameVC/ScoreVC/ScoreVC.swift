//
//  ScoreVC.swift
//  ProjectGame
//
//  Created by Dmitry Kononov on 1.02.22.
//

import UIKit
import CoreData

final class ScoreVC: UIViewController {

    @IBOutlet private  weak var tableView: UITableView!
    private var scoreViewModel: ScoreViewModelProtocol = ScoreViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.layer.cornerRadius = 10
        tableView.clipsToBounds = true
        
        scoreViewModel.didContentChange = {
            self.tableView.reloadData()
        }
        
        scoreViewModel.loadPlayers()
    }
    
    @IBAction private func doneButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }
    
}


extension ScoreVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoreViewModel.players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(ScoreTableViewCell.self)", for: indexPath) as? ScoreTableViewCell else {return UITableViewCell()}
    
        cell.rankLabel.text = "\(indexPath.row + 1)"
        cell.scoreLabel.text = String(scoreViewModel.players[indexPath.row].score)
        cell.playerNameLabel.text = scoreViewModel.players[indexPath.row].name
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
