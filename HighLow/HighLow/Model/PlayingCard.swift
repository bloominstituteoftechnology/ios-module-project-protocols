//
//  PlayingCard.swift
//  HighLow
//
//  Created by Shawn Gee on 2/19/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import Foundation

struct PlayingCard: Comparable {
    
    enum Rank: Int, Comparable, CustomStringConvertible {
        case ace = 1, two, three, four, five, six, seven, eight, nine, ten, jack, queen, king
        
        static var allRanks: [Rank] {
            [ace, two, three, four, five, six, seven, eight, nine, ten, jack, queen, king]
        }
        
        var description: String {
            switch self {
            case .jack:
                return "jack"
            case .queen:
                return "queen"
            case .king:
                return "king"
            case .ace:
                return "ace"
            default:
                return String(describing: rawValue)
            }
        }
        
        static func < (lhs: Rank, rhs: Rank) -> Bool {
            lhs.rawValue < rhs.rawValue
        }
        
        static func == (lhs: Rank, rhs: Rank) -> Bool {
            lhs.rawValue == rhs.rawValue
        }
    }

    enum Suit: String {
        case hearts, diamonds, spades, clubs
        static var allSuits: [Suit] {
            [hearts, diamonds, spades, clubs]
        }
    }
    
    let rank: Rank
    let suit: Suit
    
    var description: String {
           return "\(rank) of \(suit)"
       }
    
    static func < (lhs: PlayingCard, rhs: PlayingCard) -> Bool {
        lhs.rank.rawValue < rhs.rank.rawValue
    }
    
    static func == (lhs: PlayingCard, rhs: PlayingCard) -> Bool {
        lhs.rank.rawValue == rhs.rank.rawValue && lhs.suit == rhs.suit
    }
}
