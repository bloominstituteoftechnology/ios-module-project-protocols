//
//  ViewController.swift
//  HighLow
//
//  Created by Shawn Gee on 2/18/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    //MARK: - IB Outlets
    
    @IBOutlet weak var cardImageView: UIImageView!
    
    @IBOutlet weak var readyButton: UIButton!
    @IBOutlet weak var playerOneLowButton: UIButton!
    @IBOutlet weak var playerOneHighButton: UIButton!
    @IBOutlet weak var playerOneScoreLabel: UILabel!
    
    @IBOutlet weak var playerTwoLowButton: UIButton!
    @IBOutlet weak var playerTwoHighButton: UIButton!
    @IBOutlet weak var playerTwoScoreLabel: UILabel!
    
    lazy var betButtons: [UIButton] = [playerOneLowButton, playerOneHighButton, playerTwoLowButton, playerTwoHighButton]
    
    let game = HighLowBlitz()
    
    
    //MARK: - IB Actions
    
    @IBAction func readyButtonTapped(_ sender: UIButton) {
        game.playersAreReady()
        sender.isHidden = true
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        switch sender {
        case playerOneLowButton:
            game.playerOne(placedBet: .low)
            disableButtons([playerOneHighButton])
        case playerOneHighButton:
            game.playerOne(placedBet: .high)
            disableButtons([playerOneLowButton])
        case playerTwoLowButton:
            game.playerTwo(placedBet: .low)
            disableButtons([playerTwoHighButton])
        case playerTwoHighButton:
            game.playerTwo(placedBet: .high)
            disableButtons([playerTwoLowButton])
        default:
            break
        }
    }
    
    //MARK: - Helper Functions
    
    func imageFor(playingCard card: PlayingCard) -> UIImage? {
        let imageName = "\(card.rank)_\(card.suit)"
        return UIImage(named: imageName)
    }
    
    func disableButtons(_ buttons: [UIButton]) {
        buttons.forEach {
            $0.isEnabled = false
            $0.layer.opacity = 0.5
        }
    }
    
    func enableButtons(_ buttons: [UIButton]) {
        buttons.forEach {
            $0.isEnabled = true
            $0.layer.opacity = 1
        }
    }
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "green_felt")!)
        disableButtons(betButtons)
        game.delegate = self
    }
}


//MARK: - HighLowBlitzDelegate

extension GameViewController: HighLowBlitzDelegate {
    
    func gameDidFlipFirstCard(_ card: PlayingCard) {
        cardImageView.image = imageFor(playingCard: card)
        enableButtons(betButtons)
    }
    
    func gameDidFlipSecondCard(_ card: PlayingCard) {
        cardImageView.image = imageFor(playingCard: card)
        
        // Wait some time then reset
        Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false) { _ in
            self.cardImageView.image = nil
            self.disableButtons(self.betButtons)
            self.readyButton.isHidden = false
        }
    }
    
    func gameDidUpdateScore(playerOneScore: Int, playerTwoScore: Int) {
        playerOneScoreLabel.text = String(playerOneScore)
        playerTwoScoreLabel.text = String(playerTwoScore)
    }
    
}

