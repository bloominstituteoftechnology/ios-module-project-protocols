import Foundation

enum  Rank: Int, CustomStringConvertible, CaseIterable, Comparable{
    static func < (lhs: Rank, rhs: Rank) -> Bool {
        if lhs > rhs {
            return true
    } else if lhs <= rhs {
    return false
    }
        return false
    }
    
//    var description: String {
//      var newString = ""
//      switch self {
//      case .ace, .jack, .queen, .king:
//        newString = "\(self.description)"
//        return newString
//      case .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten :
//        newString = "\(self.rawValue)"
//        return newString
//      }
//    }
    
    var description: String {
      switch self {
      case .ace:
        return "ace"
      case .jack:
        return "jack"
      case .queen:
        return "queen"
      case .king:
        return "king"
      default:
        return "\(self.rawValue)"
      }
    }
    case ace = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6
    case seven = 7
    case eight = 8
    case nine = 9
    case ten = 10
    case jack = 11
    case queen = 12
    case king = 13
}


enum Suits: String, CaseIterable{
    
    
    case diamonds
    case hearts
    case spades
    case clubs
}

struct Card: CustomStringConvertible, Comparable{
    static func < (lhs: Card, rhs: Card) -> Bool {
        if lhs.value.rawValue > rhs.value.rawValue {
                  return true
        } else if lhs.value.rawValue <= rhs.value.rawValue {
          return false
          }
        return false
    }
    
    var description: String{
        return value.description + " of " + suit.rawValue
    }
    
    let suit: Suits
    let value: Rank
}


struct Deck{
    let deck: [Card]
    
    init (){
        var cards: [Card] = []
        for suit in Suits.allCases{
            for rank in Rank.allCases{
                let card = Card(suit: suit, value: rank)
                cards.append(card)
            }
        }
        deck = cards
    }
    
    func drawCard() -> Card{
        let deck = self.deck
        return deck.randomElement()!
    }
}

protocol CardGame{
    var deck: Deck {get}
    func play()
}
 

protocol CardGameDelegate{
    func gameDidStart(cardgame: CardGame)
    func game(player1DidDraw card1: Card, player2DidDraw card2: Card)

}

class HighLow: CardGame{
    var deck = Deck()
    
    var delegate: CardGameDelegate?
    func play() {
        delegate?.gameDidStart(cardgame: self)
        let card1 = deck.drawCard()
        let card2 = deck.drawCard()
        delegate?.game(player1DidDraw: card1, player2DidDraw: card2)
        if card1.value.rawValue > card2.value.rawValue{
            print("Player 1 won with the \(card1.description) of \(card1.suit.rawValue)")
        } else if card1.value.rawValue < card2.value.rawValue{
            print("Player 2 won with the \(card2.description) of \(card2.suit.rawValue)")
        } else if card1.value.rawValue == card2.value.rawValue{
        print("This round ends in a tie with the \(card2.description) of \(card2.suit.rawValue)")
        }
    }
}


class CardGameTracker: CardGameDelegate{
    func gameDidStart(cardgame: CardGame){
        if cardgame is HighLow{
            print("A new game of High Low has started")
        }
    }

    func game(player1DidDraw card1: Card, player2DidDraw card2: Card) {
        print("Player 1 drew the \(card1.description) of \(card1.suit), and player 2 drew the \(card2.description) of \(card2.suit)")
    }
}

let newGame = HighLow()
newGame.delegate = CardGameTracker()
newGame.play()
