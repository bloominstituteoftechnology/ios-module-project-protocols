import Foundation

//: ## Step 1
//: Create an enumeration for the value of a playing card. The values are: `ace`, `two`, `three`, `four`, `five`, `six`, `seven`, `eight`, `nine`, `ten`, `jack`, `queen`, and `king`. Set the raw type of the enum to `Int` and assign the ace a value of `1`.
enum CardRank: Int, CaseIterable, Comparable {
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
    
    
    static let allRanks: [CardRank] = [.ace, .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten, .jack, .queen, .king]

    static func == (lhs: CardRank, rhs: CardRank) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
    static func < (lhs: CardRank, rhs: CardRank) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}



//: ## Step 2
//: Once you've defined the enum as described above, take a look at this built-in protocol, [CustomStringConvertible](https://developer.apple.com/documentation/swift/customstringconvertible) and make the enum conform to that protocol. Make the face cards return a string of their name, and for the numbered cards, simply have it return that number as a string.
extension CardRank: CustomStringConvertible {
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
            return String(self.rawValue)
        }
    }
}

//: ## Step 3
//: Create an enum for the suit of a playing card. The values are `hearts`, `diamonds`, `spades`, and `clubs`. Use a raw type of `String` for this enum (this will allow us to get a string version of the enum cases for free, no use of `CustomStringConvertible` required).
enum CardSuit: String {
    case hearts
    case diamonds
    case spades
    case clubs
    
    static var allSuits: [CardSuit] = [.hearts, .diamonds, .spades, .clubs]
    
    
}

//: ## Step 4
//: Using the two enums above, create a `struct` called `Card` to model a single playing card. It should have constant properties for each constituent piece (one for suit and one for rank).
struct Card: Comparable {
    let suit: CardSuit
    let rank: CardRank
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.suit == rhs.suit && lhs.rank == rhs.rank
    }
    static func < (lhs: Card, rhs: Card) -> Bool {
        return lhs.rank < rhs.rank
    }
}



//: ## Step 5
//: Make the card also conform to `CustomStringConvertible`. When turned into a string, a card's value should look something like this, "ace of spades", or "3 of diamonds".
extension Card: CustomStringConvertible {
    var description: String {
        return "\(rank) of \(suit)"
    }
}

//: ## Step 6
//: Create a `struct` to model a deck of cards. It should be called `Deck` and have an array of `Card` objects as a constant property. A custom `init` function should be created that initializes the array with a card of each rank and suit. You'll want to iterate over all ranks, and then over all suits (this is an example of _nested `for` loops_). See the next 2 steps before you continue with the nested loops.
struct Deck {
    let cards: [Card]

    init() {
        var deck: [Card] = []
        
        for rank in CardRank.allRanks {
            for suit in CardSuit.allSuits {
                let card = Card(suit: suit, rank: rank)
                deck.append(card)
            }
        }
        cards = deck
    }
    func draw() -> Card {
        return cards[Int.random(in: 0...51)]
    }

}




protocol CardGame {
    var myDeck: Deck { get }
    func play()
}


class HighLow: CardGame {
    var myDeck: Deck
    
    init() {
        myDeck = Deck()
    }
    
    func play() {
        
        let player1card = myDeck.draw()
        let player2card = myDeck.draw()

        if player1card.rank < player2card.rank {
            print("Player 2 wins with \(player2card.description)")
        } else if player1card.rank > player2card.rank {
            print("Player 1 wins with \(player1card.description)")
        } else {
            print("Round ends with a tie with \(player1card.description)")
            
        }
    }
    
}


let newGame = HighLow()
newGame.play()
newGame.play()


