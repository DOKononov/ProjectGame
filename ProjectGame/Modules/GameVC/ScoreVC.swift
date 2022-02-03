//
//  ScoreVC.swift
//  ProjectGame
//
//  Created by Dmitry Kononov on 1.02.22.
//

import UIKit
import CoreData

final class ScoreVC: UIViewController, NSFetchedResultsControllerDelegate {


    @IBOutlet weak var tableView: UITableView!
    
    private var fetchResultController: NSFetchedResultsController<Player>!
    
    var players: [Player] = [] {
        didSet { tableView.reloadData() }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFetchResultController()
        loadPlayers()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 10
        tableView.clipsToBounds = true
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func setupFetchResultController() {
        let request = Player.fetchRequest()
        let scoreDescriptor = NSSortDescriptor(key: "score", ascending: false)
        request.sortDescriptors = [scoreDescriptor]
        
        fetchResultController = NSFetchedResultsController(fetchRequest: request,
                                                           managedObjectContext: CoreDataService.managadObjectContext,
                                                           sectionNameKeyPath: nil,
                                                           cacheName: nil)
        
        fetchResultController.delegate = self
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        loadPlayers()
    }
    
    func loadPlayers() {
        try? fetchResultController.performFetch()
        if let result = fetchResultController.fetchedObjects {
            players = result
        }
    }
}


extension ScoreVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(ScoreTableViewCell.self)", for: indexPath) as? ScoreTableViewCell else {return UITableViewCell()}
        
        
        cell.rankLabel.text = "\(indexPath.row + 1)"
        
        cell.scoreLabel.text = String(players[indexPath.row].score)
        cell.playerNameLabel.text = players[indexPath.row].name
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
