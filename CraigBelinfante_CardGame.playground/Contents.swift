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
        "\(self.suit.rawValue) \(self.rank.description)"
    }
}
//6-11
struct Deck {
    var deckArray: [Card]
    
    init? () {
        var cardDeck: [Card] = []
        
        let suits = Suits.allSuits
        let ranks = Rank.allRanks
        
        for suit in suits {
            for rank in ranks {
                cardDeck.append(Card(rank: rank, suit: suit))
            }
        }
        
        func drawCards() -> Card {
            let randomCard = Int.random(in: 0...51)
            return cardDeck[randomCard]
        }
        return nil
    }
}

//12
protocol CardGame {
    var deck: Deck { get }

    func playGame()
}
