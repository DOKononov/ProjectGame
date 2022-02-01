//
//  ScoreVC.swift
//  ProjectGame
//
//  Created by Dmitry Kononov on 1.02.22.
//

import UIKit

class ScoreVC: UIViewController{


    @IBOutlet weak var tableView: UITableView!
    
    let scoreArray = ["100", "97", "93", "44", "15", "33", "23", "33", "33", "44", "34", "34", "23", "97", "93", "44", "15", "33", "23", "33", "33", "44", "34", "34", "23"]
    let namesArray = ["Dima", "Kolia", "Petia", "Vasia", "Serega", "Kolia", "Petia", "Vasia", "Serega", "Kolia", "Petia", "Vasia", "Serega", "Kolia", "Petia", "Vasia", "Serega", "Kolia", "Petia", "Vasia", "Serega", "Kolia", "Petia", "Vasia", "Serega"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.layer.cornerRadius = 10
        tableView.clipsToBounds = true
    }
    
    
}


extension ScoreVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(ScoreTableViewCell.self)", for: indexPath) as? ScoreTableViewCell else {return UITableViewCell()}
        
        
        cell.rankLabel.text = "\(indexPath.row + 1)"
        
        cell.scoreLabel.text = scoreArray[indexPath.row]
        cell.playerNameLabel.text = namesArray[indexPath.row]
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
