import Foundation

enum CardsRanks: Int, CustomStringConvertible, Comparable {
    
    
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
    
    var description: String {
        switch self {
        case .two:
            return "2"
        case .three:
            return "3"
        case .four:
            return "4"
        case .five:
            return "5"
        case .six:
            return "6"
        case .seven:
            return "7"
        case .eight:
            return "8"
        case .nine:
            return "9"
        case .ten:
            return "10"
        case .jack:
            return "Jack"
        case .queen:
            return "Queen"
        case .king:
            return "King"
        default:
            return ""
        }
    }
    
    static var allRanks: [CardsRanks] {
        return [.ace,.two,.three,.four,.five,.six,.seven,.eight,.nine,.ten,.jack,.queen,.king]
    }
    static func < (lhs: CardsRanks, rhs: CardsRanks) -> Bool {
            return lhs.rawValue < rhs.rawValue
    }
    static func == (lhs: CardsRanks, rhs: CardsRanks) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}

enum CardsSuit: String {
    case hearts
    case diamonds
    case spades
    case clubs
    
    static var allSuits: [CardsSuit] {
        return [.hearts,.diamonds,.spades,.clubs]
    }

}

struct Card: Comparable, CustomStringConvertible {
    
    
    
    
    let suit: CardsSuit
    let rank: CardsRanks
    
    static func < (lhs: Card, rhs: Card) -> Bool {
        return lhs.rank < rhs.rank
    }
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.rank == rhs.rank && lhs.rank == rhs.rank
    }
    var description: String {
        return "\(rank) of \(suit.rawValue)"
    }
}


struct Deck {
    let cards: [Card]
    
    init() {
        var cards: [Card] = []
        for rank in CardsRanks.allRanks {
            for suit in CardsSuit.allSuits {
                let card: Card = Card(suit: suit, rank: rank)
                cards.append(card)
            }
        }
        self.cards = cards
    }
    
    func drawCard() -> Card {
        let random = Int.random(in: 0...self.cards.count)
        return cards[random]
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
    var deck: Deck
    var delegate: CardGameDelegate?
    
    func play() {
        let card1 = deck.drawCard()
        let card2 = deck.drawCard()
        
        if card1 == card2 {
            print("Round ends in a tie with \(card1)")
        } else if card1 > card2 {
            print("Player 1 wins with \(card1) against \(card2)")
        } else {
            print("Player 2 wins with \(card2) against \(card1)")
        }
        
        
    }
    
    init (deck: Deck) {
        self.deck = deck
    }
}

class CardGameTracker: CardGameDelegate {
    func gameDidStart(_ game: CardGame) {
        <#code#>
    }
    
    func game(player1DidDraw card1: Card, player2DidDraw card2: Card) {
        <#code#>
    }
    
    
}

let newDeck = Deck()
//print(newDeck.cards)
let highLow: HighLow = HighLow(deck: newDeck)

highLow.play()


//: ## Step 15
//: As part of the protocol conformance, implement a method called `play()`. The method should draw 2 cards from the deck, one for player 1 and one for player 2. These cards will then be compared to see which one is higher. The winning player will be printed along with a description of the winning card. Work will need to be done to the `Suit` and `Rank` types above, so see the next couple steps before continuing with this step.




//: ## Step 16
//: Take a look at the Swift docs for the [Comparable](https://developer.apple.com/documentation/swift/comparable) protocol. In particular, look at the two functions called `<` and `==`.




//: ## Step 17
//: Make the `Rank` type conform to the `Comparable` protocol. Implement the `<` and `==` functions such that they compare the `rawValue` of the `lhs` and `rhs` arguments passed in. This will allow us to compare two rank values with each other and determine whether they are equal, or if not, which one is larger.





//: Step 18
//: Make the `Card` type conform to the `Comparable` protocol. Implement the `<` and `==` methods such that they compare the ranks of the `lhs` and `rhs` arguments passed in. For the `==` method, compare **both** the rank and the suit.





//: ## Step 19
//: Back to the `play()` method. With the above types now conforming to `Comparable`, you can write logic to compare the drawn cards and print out 1 of 3 possible message types:
//: * Ends in a tie, something like, "Round ends in a tie with 3 of clubs."
//: * Player 1 wins with a higher card, e.g. "Player 1 wins with 8 of hearts."
//: * Player 2 wins with a higher card, e.g. "Player 2 wins with king of diamonds."



//: ## Step 20
//: Create a class called `CardGameTracker` that conforms to the `CardGameDelegate` protocol. Implement the two required functions: `gameDidStart` and `game(player1DidDraw:player2DidDraw)`. Model `gameDidStart` after the same method in the guided project from today. As for the other method, have it print a message like the following:
//: * "Player 1 drew a 6 of hearts, player 2 drew a jack of spades."



//: Step 21
//: Time to test all the types you've created. Create an instance of the `HighLow` class. Set the `delegate` property of that object to an instance of `CardGameTracker`. Lastly, call the `play()` method on the game object. It should print out to the console something that looks similar to the following:
//:
//: ```
//: Started a new game of High Low
//: Player 1 drew a 2 of diamonds, player 2 drew a ace of diamonds.
//: Player 1 wins with 2 of diamonds.
//: ```


