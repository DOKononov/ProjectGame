//
//  GameVC.swift
//  ProjectGame
//
//  Created by Dmitry Kononov on 12.01.22.
//

import UIKit

class GameVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var fuseOutlet: UISlider!
    
    let padding: CGFloat = 20
    let cardsInRow: CGFloat = 3
    let heightAspectRatio: CGFloat = 1.3813
    var setTimer = 30
    
    var cardsArray = [Card]()
    var game = Game()
    var gameHaveBeenStarted = false
    
    var firstIndex: IndexPath?
    var secondIndex: IndexPath?
    var firstCard: Card?
    var secondCard: Card?
    
    var timerLabel: UILabel?
    var scoreLabel: UILabel?
    
    var timer: Timer?
    var timerCounter = 0 {
        didSet {
            timerLabel?.text = "Time left: \(timerCounter) sec"
            fuseOutlet.setValue(Float(timerCounter), animated: true)
        }
    }
    var scoreCounter = 0 {
        didSet { scoreLabel?.text = "Score: \(scoreCounter)"}
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        addLableToNaviBar()
        scoreCounter = 0
        timerCounter = setTimer
        
        setupFuse()
        
        cardsArray = game.generateDeck()        
    }
    
    @IBAction func settingsDidTapped(_ sender: UIBarButtonItem) {
        //pause timer
                timer?.invalidate()
        let alertSheat = UIAlertController(title: "Game paused", message: nil, preferredStyle: .actionSheet)
        let restartGame = UIAlertAction(title: "Restart game", style: .default) { action in
            //TODO: -New game
            self.alertForRestartGame()
        }

        let changeNickname = UIAlertAction(title: "Change nickname", style: .default) { action in
            self.alertForNameChanging()
        }
        
        let resume = UIAlertAction(title: "Resume game", style: .cancel) { _ in
            self.resumeTimer()
        }
        
        alertSheat.addAction(resume)
        alertSheat.addAction(restartGame)
        alertSheat.addAction(changeNickname)
        present(alertSheat, animated: true, completion: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        let card = cardsArray[indexPath.row]
        guard !card.isMatched else { return }
        
        cell?.card = card
        
        if !gameHaveBeenStarted {
            gameHaveBeenStarted = true
            startTimer()
        }
                
        //OPEN FIRST CARD
        if firstIndex == nil {
            openFirstCard(indexpath: indexPath, card: card, cell: cell)
            
            //OPEN SECOND CARD
        } else if secondIndex == nil, firstIndex != indexPath  {
                    
            secondCard = card
            secondIndex = indexPath
            card.isFaceUp = true
            cell?.flipCard()
            
            //CHECK FOR MATCH
            if firstCard?.name == secondCard?.name {
                firstCard?.isMatched = true
                secondCard?.isMatched = true
                scoreCounter += 1
            }
            
            //FLIP BOTH CARDS BACK
        } else {
            guard let firstIndex = firstIndex else { return }
            guard let secondIndex = secondIndex else { return }
            
            let cellOne = collectionView.cellForItem(at: firstIndex) as? CardCollectionViewCell
            let cellTwo = collectionView.cellForItem(at: secondIndex) as? CardCollectionViewCell
            
            self.firstIndex = nil
            self.secondIndex = nil
            
            cardsArray[firstIndex.row].isFaceUp = false
            cardsArray[secondIndex.row].isFaceUp = false
            
            cellOne?.flipCard()
            cellTwo?.flipCard()
            
            //OPEN NEW FIRST CARD
            openFirstCard(indexpath: indexPath, card: card, cell: cell)
        }
    }
    
    
    func openFirstCard(indexpath: IndexPath, card: Card, cell: CardCollectionViewCell?) {
        firstCard = card
        firstIndex = indexpath
        card.isFaceUp = true
        cell?.flipCard()
    }
    
    func newGame() {
        cardsArray = game.generateDeck()
        collectionView.reloadData()
        firstIndex = nil
        secondIndex = nil
        scoreCounter = 0
    }
    
    
    
    func alertForNameChanging() {
        let alert = UIAlertController(title: "Are you sure you want to quit the current game?", message: "All unsaved progress will be lost.", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .destructive) { _ in
            self.timerLabel?.removeFromSuperview()
            self.scoreLabel?.removeFromSuperview()
            self.timer?.invalidate()

            self.navigationController?.popViewController(animated: true)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.resumeTimer()
        }
        alert.addAction(okButton)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    func alertForRestartGame() {
        let alert = UIAlertController(title: "Are you sure you want to quit the current game?", message: "All unsaved progress will be lost.", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .destructive) { _ in
            self.timerCounter = self.setTimer
            self.scoreCounter = 0
            self.gameHaveBeenStarted = false
            self.timer?.invalidate()

            self.newGame()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.resumeTimer()
        }
        alert.addAction(okButton)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    func addLableToNaviBar() {
        guard let navigationBar = navigationController?.navigationBar else {return}
        let timerLabelFrame = CGRect(x: navigationBar.frame.width * 0.25,
                                     y: 0,
                                     width: navigationBar.frame.width * 0.45,
                                     height: navigationBar.frame.height)
        timerLabel = UILabel(frame: timerLabelFrame)
        
        let scoreLabelFrame = CGRect(x: navigationBar.frame.width * 0.7,
                                     y: 0,
                                     width: navigationBar.frame.width / 4,
                                     height: navigationBar.frame.height)
        scoreLabel = UILabel(frame: scoreLabelFrame)

        if let timerLabel = timerLabel, let scoreLabel = scoreLabel {
            navigationBar.addSubview(timerLabel)
            navigationBar.addSubview(scoreLabel)
        }
        
    }
    
    
    
    func startTimer() {
        timerCounter = setTimer
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(timerAction),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    func resumeTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: true)
    }
    
    func setupFuse() {
        fuseOutlet.minimumValue = 0
        fuseOutlet.maximumValue = Float(setTimer)
        fuseOutlet.setValue(Float(timerCounter), animated: false)

    }
    
    
    @objc func timerAction() {
        guard timerCounter > 0 else { return }
        timerCounter -= 1
    }
    

    
}











//MARK: -extension GameVC
extension GameVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as? CardCollectionViewCell else {return UICollectionViewCell()}

        let card = cardsArray[indexPath.row]
        cell.card = card
        cell.setupCell()
        return cell
    }
    
    
    //aspectRatio 1 : 1.3813
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frameWidth = min(view.frame.width, view.frame.height)
        let paddingSpace = (cardsInRow + 1) * padding
        let cardWidth = (frameWidth - paddingSpace) / cardsInRow
        
        return CGSize(width: cardWidth, height: cardWidth * heightAspectRatio)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    }
    
}
