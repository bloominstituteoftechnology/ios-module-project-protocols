import UIKit

//1
enum Rank: Int {
    case ace = 1
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
    case jack
    case queen
    case king
    
    static var allRanks: [Rank] {
        return [.ace, .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten, .jack, .queen, .king]
    }
}

//2
extension Rank: CustomStringConvertible {
    var description: String {
        switch self {
        case .ace:
            return "One"
        case .two:
            return "Two"
        case .three:
            return "Three"
        case .four:
            return "Four"
        case .five:
            return "Five"
        case .six:
            return "Six"
        case .seven:
            return "Seven"
        case .eight:
            return "Eight"
        case .nine:
            return "Nine"
        case .ten:
            return "Ten"
        case .jack:
            return "Jack"
        case .queen:
            return "Queen"
        case .king:
            return "King"
        }
    }
}

//3
enum Suits: String {
    case hearts
    case diamonds
    case spades
    case clubs
    
    static var allSuits: [Suits] {
        return [.hearts, .diamonds, .spades, .clubs]
    }
}

//4
struct Card {
    var rank: Rank
    var suit: Suits
}
//5
extension Card: CustomStringConvertible {
    var description: String {
        "\(self.rank.description) of \(self.suit.rawValue)"
    }
}
//6-11
struct Deck {
    var deckArray: [Card]
    
    init () {
        var cardDeck: [Card] = []
        
        let suits = Suits.allSuits
        let ranks = Rank.allRanks
        
        for suit in suits {
            for rank in ranks {
                cardDeck.append(Card(rank: rank, suit: suit))
            }
        }
        deckArray = cardDeck
    }
    
    
    func drawCards() -> Card {
        let randomCard = Int.random(in: 0...51)
        return deckArray[randomCard]
    }
}

//12-16
protocol CardGame {
    var deck: Deck { get }
    
    func playGame()
}

extension Rank: Comparable {
    static func < (lhs: Rank, rhs: Rank) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    static func == (lhs: Rank, rhs: Rank) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}


class HighLow: CardGame{
    var deck = Deck ()
    //18
   // var delegate: CardGame?
    
    func playGame() {
        let player1 = deck.drawCards()
        let player2 = deck.drawCards()
        
        if player1 > player2 {
                   print("Player 1 wins with the \(player1.description)")
               } else if player1 < player2 {
                   print("Player 2 wins with the \(player2.description)")
               } else if player1 == player2 {
                   print("Round ends in a tie with \(player1.description) and \(player2.description)")
        }
    }
    
}

//17

extension Card: Comparable {
    static func < (lhs: Card, rhs: Card) -> Bool {
        return lhs.rank < rhs.rank
    }
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.suit == rhs.suit && lhs.rank == rhs.rank
    } // I want to compare the suit and rank when they are equal to each other and retrun the value. This is why we use the and (&&). For example 10 beats 9 but if clubs is equal to clubs then to define the rank we need to know what its value is and if its equal to the clubs and clubs.
}

//19

let cardGame = HighLow()

cardGame.playGame()
