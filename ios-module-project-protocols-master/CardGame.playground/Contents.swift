import Foundation

enum PlayingCard: Int, CustomStringConvertible {
    
    var description: String {
        switch self.rawValue {
        case 1...10:
            return String(self.rawValue)
        case 11:
            return "jack"
        case 12:
            return "queen"
        case 13:
            return "king"
            
        default:
            return ""
        }
    }
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
    static var allCards: [PlayingCard] {
        return [ace, two, three, four, five, six, seven, eight, nine, ten, jack, queen, king]
    }
}
extension PlayingCard: Comparable {
    static func < (lhs: PlayingCard, rhs: PlayingCard) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    static func == (lhs: PlayingCard, rhs: PlayingCard) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }

}
enum CardSuits: String {
    case hearts
    case diamonds
    case spades
    case clubs
    static var allRanks: [CardSuits] {
        return [hearts, diamonds, spades, clubs]
        }
    }
struct Card: CustomStringConvertible {

        var description: String {
            return "\(cardRank) of \(cardSuit)"
    }
    
    let cardSuit: CardSuits
    let cardRank: PlayingCard
}
extension Card: Comparable {
    static func < (lhs: Card, rhs: Card) -> Bool {
        return lhs.cardRank < rhs.cardRank
    }
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.cardRank == rhs.cardRank && lhs.cardSuit == rhs.cardSuit
    }
}
struct Deck {
    let cardArray: [Card]
    
    
    init() {
        var deck: [Card] = []
        for card in PlayingCard.allCards {
            for suit in CardSuits.allRanks {
                deck.append(Card(cardSuit: suit, cardRank: card ))
            }
        }
         
        self.cardArray = deck
        }
    func drawCard() -> Card {
        return cardArray.randomElement()!
    }
}


protocol CardGame {
    var deck: Deck { get }
    func play()
}
protocol CardGameDelegate {
    func gameDidStart(_ game: CardGame)
    func game(player1DidDraw card1: Card, player2DidDraw card2: Card)
}

class HighLow: CardGame {
    var numberOfTurns: Int
    var deck: Deck = Deck()
    var delegate: CardGameDelegate?
    
    init(numberOfTurns: Int) {
        self.numberOfTurns = numberOfTurns
    }
    
    func play() {
        
        
        delegate?.gameDidStart(self)
        
        if numberOfTurns < 1 {
            print("Wrong entry for number of turns. Must be number greater than zero")
            
            return
        }
        var player1Score = 0
        var player2Score = 0
        
        for x in 1...numberOfTurns {
            var player1Card = deck.drawCard()
            let player2Card = deck.drawCard()
            
            print("Turn #\(x): ")
            
            delegate?.game(player1DidDraw: player1Card, player2DidDraw: player2Card)
            
            if player1Card == player2Card {
                print("The players have tied with a \(player1Card.description)\n\n")
            } else if player1Card < player2Card {
                player2Score += 1
                print("Player 2 has won with a \(player2Card.description)\n\n")
                
            } else {
                player2Score += 1
                print("Player 1 has won with a \(player1Card.description)\n\n")
                
            }
        }
        if player1Score == player2Score {
            print("The players tied by \(player1Score) to \(player2Score).")
        } else {
            print("Player 2 has won the match with a score of \(player2Score) to \(player1Score).")
        }
    
    
    }
}
class CardGameTracker: CardGameDelegate {

    var numberOfTurns: Int = 0
    
    func gameDidStart(_ game: CardGame) {
        numberOfTurns = 0
        if game is HighLow {
            print("Started a game of High Low")
        }
    }
    
    func game(player1DidDraw card1: Card, player2DidDraw card2: Card) {
        numberOfTurns += 1
        print("Player 2 drew \(card1), player 2 drew \(card2)")
    }
}

let tracker = CardGameTracker()
let game = HighLow(numberOfTurns: 5)
game.delegate = tracker
game.play()



