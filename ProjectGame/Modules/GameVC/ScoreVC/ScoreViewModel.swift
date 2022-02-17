//
//  ScoreViewModel.swift
//  ProjectGame
//
//  Created by Dmitry Kononov on 13.02.22.
//

import Foundation
import CoreData

protocol ScoreViewModelProtocol {
    var fetchResultController: NSFetchedResultsController<Player>! { get set }
    var players: [Player] { get }
    var didContentChange: (() -> Void)? { get set }
    func loadPlayers()
}



final class ScoreViewModel: NSObject, ScoreViewModelProtocol, NSFetchedResultsControllerDelegate {
    
    var fetchResultController: NSFetchedResultsController<Player>!

    var players: [Player] = [] {
        didSet { didContentChange?() }
    }
    
    var didContentChange: (() -> Void)?
    
    func loadPlayers() {
        setupFetchResultController()
        try? fetchResultController.performFetch()
        if let result = fetchResultController.fetchedObjects {
            players = result
        }
    }
    
    
    
    private func setupFetchResultController() {
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
}
