//
//  GameVC.swift
//  ProjectGame
//
//  Created by Dmitry Kononov on 12.01.22.
//

import UIKit
import CoreData

final class GameVC: UIViewController {
    
    @IBOutlet private weak var fuseOutlet: UIProgressView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    
    private let padding: CGFloat = 10
    private let cardsInRow: CGFloat = 3
    private let heightAspectRatio: CGFloat = 1.3813
    
    private var setTimer = 15
    private var decksize = 18
    
    var playerName = ""
    private var cardsArray = [Card]() {
        didSet {
            cardsLeftInDeck = cardsArray.count
            collectionView.reloadData()
        }
    }
    
    private var cardsLeftInDeck = 0 {
        didSet {
            if cardsLeftInDeck == 0 {
                newGame()
            }
        }
    }
    
    private var gameHaveBeenStarted = false
    
    private var firstIndex: IndexPath?
    private var secondIndex: IndexPath?
    private var firstCard: Card?
    private var secondCard: Card?
    
    private var game = Game()
    
    private var timerLabel: UILabel?
    private var scoreLabel: UILabel?
    
    private var timer: Timer?
    private var timerCounter = 0 {
        didSet {
            timerLabel?.text = "Time left: \(timerCounter) sec"
            setupFuse()
        }
    }
    private var scoreCounter = 0 {
        didSet { scoreLabel?.text = "Score: \(scoreCounter)"}
    }
    
    private lazy var cardsDataDownloader = CardsDataDownloader()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        errorLabel.isHidden = true
        
        addLableToNaviBar()
        activityIndicator.scaleIndicator(factor: 2)
        scoreCounter = 0
        timerCounter = setTimer
        setupFuse()
        
        game = Game(deckSize: decksize)
        newGame()
    }
    
    
    //MARK: -settingsDidTapped
    @IBAction private func settingsDidTapped(_ sender: UIBarButtonItem) {
        //pause timer
        timer?.invalidate()
        let alertSheat = UIAlertController(title: "Game paused", message: nil, preferredStyle: .actionSheet)
        let restartGame = UIAlertAction(title: "Restart game", style: .default) { action in
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
    
    //MARK: -didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        let card = cardsArray[indexPath.row]
        guard !card.isMatched else { return }
        
        if !gameHaveBeenStarted {
            gameHaveBeenStarted = true
            startTimer()
        }
        
        //MARK: OPEN FIRST CARD
        if firstIndex == nil {
            openFirstCard(indexpath: indexPath, card: card, cell: cell)
            
            //MARK: OPEN SECOND CARD
        } else if secondIndex == nil, firstIndex != indexPath  {
            
            secondCard = card
            secondIndex = indexPath
            card.isFacedUp = true
            cell?.flipCard(card: card)
            
            //MARK: CHECK FOR MATCH
            if firstCard?.id == secondCard?.id {
                firstCard?.isMatched = true
                secondCard?.isMatched = true
                
                cardsLeftInDeck -= 2
                timerCounter += 3
                scoreCounter += 1
            }
            
            //MARK: FLIP BOTH CARDS BACK
        } else {
            guard let firstIndex = firstIndex, let secondIndex = secondIndex else { return }
            
            let cellOne = collectionView.cellForItem(at: firstIndex) as? CardCollectionViewCell
            let cellTwo = collectionView.cellForItem(at: secondIndex) as? CardCollectionViewCell
            
            self.firstIndex = nil
            self.secondIndex = nil
            
            firstCard?.isFacedUp = false
            secondCard?.isFacedUp = false
            
            guard let firstCard = firstCard, let secondCard = secondCard else { return }
            cellOne?.flipCard(card: firstCard)
            cellTwo?.flipCard(card: secondCard)
            
            //MARK: OPEN NEW FIRST CARD
            openFirstCard(indexpath: indexPath, card: card, cell: cell)
        }
    }
    
    //MARK: openFirstCard()
    func openFirstCard(indexpath: IndexPath, card: Card, cell: CardCollectionViewCell?) {
        firstCard = card
        firstIndex = indexpath
        card.isFacedUp = true
        cell?.flipCard(card: card)
    }
    
    //MARK: gameOver()
    private func gameOver() {
        let alert = UIAlertController(title: "GAME OVER!", message: nil, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default) { _ in
            guard let nextVC = ScoreVC.getVC(from: .main) else {return}
            self.timerLabel?.removeFromSuperview()
            self.scoreLabel?.removeFromSuperview()
            
            if self.scoreCounter > 0 {
                let player = Player(context: CoreDataService.shared.managadObjectContext)
                player.score = Int64(self.scoreCounter)
                player.name = self.playerName
                CoreDataService.shared.saveContext()
            }
            
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: alertForNameChanging()
    private func alertForNameChanging() {
        let alert = UIAlertController(title: "Are you sure want to quit current game?",
                                      message: "All unsaved progress will be lost.",
                                      preferredStyle: .alert)
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
    
    
    //MARK: alertForRestartGame()
    private func alertForRestartGame() {
        let alert = UIAlertController(title: "Are you sure want to quit current game?",
                                      message: "All unsaved progress will be lost.",
                                      preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .destructive) { _ in
            self.timerCounter = self.setTimer
            self.scoreCounter = 0
            self.gameHaveBeenStarted = false
            self.timer?.invalidate()
            
            self.newGame()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            if self.gameHaveBeenStarted {
                self.resumeTimer()
            }
        }
        alert.addAction(okButton)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: addLableToNaviBar()
    private func addLableToNaviBar() {
        guard let navigationBar = navigationController?.navigationBar else {return}
        let timerLabelFrame = CGRect(x: navigationBar.frame.width * 0.25,
                                     y: 0,
                                     width: navigationBar.frame.width * 0.45,
                                     height: navigationBar.frame.height)
        timerLabel = UILabel(frame: timerLabelFrame)
        timerLabel?.font = UIFont(name: "BelweBT-Bold", size: 20)
        
        let scoreLabelFrame = CGRect(x: navigationBar.frame.width * 0.7,
                                     y: 0,
                                     width: navigationBar.frame.width / 4,
                                     height: navigationBar.frame.height)
        scoreLabel = UILabel(frame: scoreLabelFrame)
        scoreLabel?.font = UIFont(name: "BelweBT-Bold", size: 20)
        
        if let timerLabel = timerLabel, let scoreLabel = scoreLabel {
            navigationBar.addSubview(timerLabel)
            navigationBar.addSubview(scoreLabel)
        }
    }
    
    
    //MARK: startTimer()
    private func startTimer() {
        timerCounter = setTimer
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(timerAction),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    
    private func resumeTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 1,
                                          target: self,
                                          selector: #selector(self.timerAction),
                                          userInfo: nil,
                                          repeats: true)
    }
    
    
    private func setupFuse() {
        fuseOutlet.progress = Float(timerCounter) / Float(setTimer)
    }
    
    private func newGame() {
        cardsArray.forEach {$0.isFacedUp = false}
        cardsArray.forEach {$0.isMatched = false}
        firstIndex = nil
        secondIndex = nil
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        NetworkService().getCards { [weak self] fullDeckFromAPI, errorString in
            
            if let errorString = errorString {
                self?.showError(error: errorString)
                
            } else  if let fullDeckFromAPI = fullDeckFromAPI {
                self?.game.generateDeck(deckFromAPI: fullDeckFromAPI,
                                              complition: { [weak self] deckWOImages in
                    
                    self?.cardsDataDownloader.download(deckWOImages,
                                                       completion: { [weak self]  completeDeck in
                        
                        self?.cardsArray = completeDeck
                    })
                })
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.isHidden = true
            }
        }
    }
    
    
    @objc private func timerAction() {
        if timerCounter <= 0 {
            gameOver()
            timer?.invalidate()
        } else {
            timerCounter -= 1
        }
    }
    
    private func showError(error: String) {
        DispatchQueue.main.async {
            self.errorLabel.isHidden = false
            self.errorLabel.text = error
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
    
    
}











//MARK: -extension GameVC+CollectionView
extension GameVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as? CardCollectionViewCell
        
        let card = cardsArray[indexPath.row]
        cell?.setupCell(card: card)
        return cell ?? UICollectionViewCell()
    }
    
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
