//
//  DeckOfCards.swift
//  HighLow
//
//  Created by Shawn Gee on 2/19/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import Foundation

struct Deck {
    let cards: [PlayingCard]
    
    init() {
        var cards = [PlayingCard]()
        for rank in PlayingCard.Rank.allRanks {
            for suit in PlayingCard.Suit.allSuits {
                cards.append(PlayingCard(rank: rank, suit: suit))
            }
        }
        self.cards = cards
    }
    
    func drawCard() -> PlayingCard {
           let range = 0..<cards.count
           return cards[Int.random(in: range)]
       }
}
