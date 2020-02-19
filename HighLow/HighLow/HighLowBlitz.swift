//
//  HighLowBlitz.swift
//  HighLow
//
//  Created by Shawn Gee on 2/19/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import Foundation

protocol HighLowBlitzDelegate: AnyObject {
    func gameDidFlipFirstCard(_ card: PlayingCard)
    func gameDidFlipSecondCard(_ card: PlayingCard)
    func gameDidUpdateScore(playerOneScore: Int, playerTwoScore: Int)
}

class HighLowBlitz {
    
    enum Bet {
        case high, low
    }
    
    func newGame() {
        
    }
    
    func playerOne(placedBet bet: Bet) {
        playerOne.bet = bet
        if blitzBonusPlayer == nil {
            blitzBonusPlayer = playerOne
        }
        if playerOne.bet != nil && playerTwo.bet != nil {
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
                self.flipSecondCard()
            }
        }
    }
    
    func playerTwo(placedBet bet: Bet) {
        playerTwo.bet = bet
        if blitzBonusPlayer == nil {
            blitzBonusPlayer = playerTwo
        }
        if playerOne.bet != nil && playerTwo.bet != nil {
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
                self.flipSecondCard()
            }
        }
    }
    
    func playersAreReady() {
        // After random time, flip card
        let randomTime = Double.random(in: 1...2.5)
        Timer.scheduledTimer(withTimeInterval: randomTime, repeats: false) { _ in
            self.flipFirstCard()
        }
    }
    
    weak var delegate: HighLowBlitzDelegate?
    
    private var deck = Deck()
    
    private var playerOne = Player(name: "One")
    private var playerTwo = Player(name: "Two")
    private var blitzBonusPlayer: Player?
    
    private var firstCard: PlayingCard?
    private var secondCard: PlayingCard?

    private func flipFirstCard() {
        firstCard = deck.drawCard()
        delegate?.gameDidFlipFirstCard(firstCard!)
    }
    
    private func flipSecondCard() {
        secondCard = deck.drawCard()
        delegate?.gameDidFlipSecondCard(secondCard!)
    
        let winningBet = secondCard! > firstCard! ? Bet.high : Bet.low
        calculateScore(forPlayer: playerOne, withOtherPlayer: playerTwo, usingWinningBet: winningBet)
        calculateScore(forPlayer: playerTwo, withOtherPlayer: playerOne, usingWinningBet: winningBet)
        delegate?.gameDidUpdateScore(playerOneScore: playerOne.score, playerTwoScore: playerTwo.score)
        
        playerOne.bet = nil
        playerTwo.bet = nil
        blitzBonusPlayer = nil
    }
    
    private func calculateScore(forPlayer player: Player, withOtherPlayer otherPlayer: Player, usingWinningBet winningBet: Bet) {
        if player.bet == winningBet {
            player.score += 1
            if blitzBonusPlayer === player {
                player.score += 2
            }
            if otherPlayer.bet != winningBet {
                player.score += 2
            }
        }
    }
}
