import Foundation

protocol CardGame {
    var deck: Deck { get }
    func play()
}

protocol CardGameDelegate {
    func gameDidStart(game: CardGame)
    func game(player1DidDraw card1: Card, player2DidDraw card2: Card)
}

struct Card {
    enum Suits: String {
        case heart = "Heart"
        case diamond = "Diamond"
        case spade = "Spade"
        case club = "Club"
        
        static var allSuits: [Suits] {
            return [.heart,
                    .diamond,
                    .spade,
                    .club
            ]
        }
    }
    
    enum Ranks: Int {
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
        
        static var allRanks: [Ranks] {
            return [.ace,
                    .two,
                    .three,
                    .four,
                    .five,
                    .six,
                    .seven,
                    .eight,
                    .nine,
                    .ten,
                    .jack,
                    .queen,
                    .king
            ]
        }
    }
    
    let suit: Suits
    let rank: Ranks
}

struct Deck {
    let cards: [Card]
    init() {
        var cardArray = [Card]() //cant append to cards
        for suit in Card.Suits.allSuits {
            for card in Card.Ranks.allRanks {
                cardArray.append(Card(suit: suit, rank: card))
            }
        }
        self.cards = cardArray
    }
    
    func drawCard() -> Card {
        let randomCard = Int.random(in: 0...52)
        return self.cards[randomCard]
    }
}

extension Card: CustomStringConvertible, Comparable {
    var description: String {
        return "\(self.rank) of \(self.suit)"
    }
    
    static func < (lhs: Card, rhs: Card) -> Bool {
        return lhs.rank.rawValue < rhs.rank.rawValue
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.rank.rawValue == rhs.rank.rawValue
    }
}

extension Card.Ranks: CustomStringConvertible, Comparable {
    var description: String {
        switch self {
        case .ace:
            return "Ace"
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
        }
    }
    
    static func < (lhs: Card.Ranks, rhs: Card.Ranks) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    static func == (lhs: Card.Ranks, rhs: Card.Ranks) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
    
}

class HighLow: CardGame {
    var deck = Deck()
    var delegate: CardGameDelegate?
    
    func play() {
        delegate?.gameDidStart(game: self)
        let player1Card = deck.drawCard()
        let player2Card = deck.drawCard()
        
        delegate?.game(player1DidDraw: player1Card, player2DidDraw: player2Card)
        
        if player1Card == player2Card {
            print("Round ends in a tie with \(player1Card.description)")
        } else if player1Card > player2Card {
            print("Player 1 wins with a \(player1Card.description)")
        } else {
            print("Player 2 wins with a \(player2Card.description)")
        }
    }
    
}

class CardGameTracker: CardGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(game: CardGame) {
        numberOfTurns = 0
        print("Started a new game!")
    }
    
    func game(player1DidDraw card1: Card, player2DidDraw card2: Card) {
        numberOfTurns += 1
        print("Player 1 drew a \(card1), Player 2 drew a \(card2)")
    }
    
}

let myHighlow = HighLow()
let tracker = CardGameTracker()

myHighlow.delegate = tracker
myHighlow.play()
//: ## Step 1
//: Create an enumeration for the value of a playing card. The values are: `ace`, `two`, `three`, `four`, `five`, `six`, `seven`, `eight`, `nine`, `ten`, `jack`, `queen`, and `king`. Set the raw type of the enum to `Int` and assign the ace a value of `1`.
/// DID THIS ABOVE
//: ## Step 2
//: Once you've defined the enum as described above, take a look at this built-in protocol, [CustomStringConvertible](https://developer.apple.com/documentation/swift/customstringconvertible) and make the enum conform to that protocol. Make the face cards return a string of their name, and for the numbered cards, simply have it return that number as a string.
/// DID THIS ABOVE
//: ## Step 3
//: Create an enum for the suit of a playing card. The values are `hearts`, `diamonds`, `spades`, and `clubs`. Use a raw type of `String` for this enum (this will allow us to get a string version of the enum cases for free, no use of `CustomStringConvertible` required).
/// DID THIS ABOVE
//: ## Step 4
//: Using the two enums above, create a `struct` called `Card` to model a single playing card. It should have constant properties for each constituent piece (one for suit and one for rank).
/// DID THIS ABOVE
//: ## Step 5
//: Make the card also conform to `CustomStringConvertible`. When turned into a string, a card's value should look something like this, "ace of spades", or "3 of diamonds".
/// DID THIS ABOVE
//: ## Step 6
//: Create a `struct` to model a deck of cards. It should be called `Deck` and have an array of `Card` objects as a constant property. A custom `init` function should be created that initializes the array with a card of each rank and suit. You'll want to iterate over all ranks, and then over all suits (this is an example of _nested `for` loops_). See the next 2 steps before you continue with the nested loops.
/// DID THIS ABOVE
//: ## Step 7
//: In the rank enum, add a static computed property that returns all the ranks in an array. Name this property `allRanks`. This is needed because you can't iterate over all cases from an enum automatically.
/// DID THIS ABOVE
//: ## Step 8
//: In the suit enum, add a static computed property that returns all the suits in an array. Name this property `allSuits`.
/// DID THIS ABOVE
//: ## Step 9
//: Back to the `Deck` and the nested loops. Now that you have a way to get arrays of all rank values and all suit values, create 2 `for` loops in the `init` method, one nested inside the other, where you iterate over each value of rank, and then iterate over each value of suit. See an example below to get an idea of how this will work. Imagine an enum that contains the 4 cardinal directions, and imagine that enum has a property `allDirections` that returns an array of them.
//: ```
//: for direction in Compass.allDirections {
//:
//:}
//:```
/// DONE THIS ABOVE
//: ## Step 10
//: These loops will allow you to match up every rank with every suit. Make a `Card` object from all these pairings and append each card to the `cards` property of the deck. At the end of the `init` method, the `cards` array should contain a full deck of standard playing card objects.
// DONE THIS ABOVE
//: ## Step 11
//: Add a method to the deck called `drawCard()`. It takes no arguments and it returns a `Card` object. Have it draw a random card from the deck of cards and return it.
//: - Callout(Hint): There should be `52` cards in the deck. So what if you created a random number within those bounds and then retrieved that card from the deck? Remember that arrays are indexed from `0` and take that into account with your random number picking.
/// DONE THIS ABOVE
//: ## Step 12
//: Create a protocol for a `CardGame`. It should have two requirements:
//: * a gettable `deck` property
//: * a `play()` method
/// DONE THIS ABOVE
//: ## Step 13
//: Create a protocol for tracking a card game as a delegate called `CardGameDelegate`. It should have two functional requirements:
//: * a function called `gameDidStart` that takes a `CardGame` as an argument
//: * a function with the following signature: `game(player1DidDraw card1: Card, player2DidDraw card2: Card)`
/// DONE THIS ABOVE
//: ## Step 14
//: Create a class called `HighLow` that conforms to the `CardGame` protocol. It should have an initialized `Deck` as a property, as well as an optional delegate property of type `CardGameDelegate`.
/// DONE THIS ABOVE
//: ## Step 15
//: As part of the protocol conformance, implement a method called `play()`. The method should draw 2 cards from the deck, one for player 1 and one for player 2. These cards will then be compared to see which one is higher. The winning player will be printed along with a description of the winning card. Work will need to be done to the `Suit` and `Rank` types above, so see the next couple steps before continuing with this step.
/// DONE THIS ABOVE
//: ## Step 16
//: Take a look at the Swift docs for the [Comparable](https://developer.apple.com/documentation/swift/comparable) protocol. In particular, look at the two functions called `<` and `==`.
/// DONE! I LOOKED AT IT.
//: ## Step 17
//: Make the `Rank` type conform to the `Comparable` protocol. Implement the `<` and `==` functions such that they compare the `rawValue` of the `lhs` and `rhs` arguments passed in. This will allow us to compare two rank values with each other and determine whether they are equal, or if not, which one is larger.
/// DONE THIS ABOVE
//: Step 18
//: Make the `Card` type conform to the `Comparable` protocol. Implement the `<` and `==` methods such that they compare the ranks of the `lhs` and `rhs` arguments passed in. For the `==` method, compare **both** the rank and the suit.
/// DONE THIS ABOVE
//: ## Step 19
//: Back to the `play()` method. With the above types now conforming to `Comparable`, you can write logic to compare the drawn cards and print out 1 of 3 possible message types:
//: * Ends in a tie, something like, "Round ends in a tie with 3 of clubs."
//: * Player 1 wins with a higher card, e.g. "Player 1 wins with 8 of hearts."
//: * Player 2 wins with a higher card, e.g. "Player 2 wins with king of diamonds."
/// DONE THIS ABOVE
//: ## Step 20
//: Create a class called `CardGameTracker` that conforms to the `CardGameDelegate` protocol. Implement the two required functions: `gameDidStart` and `game(player1DidDraw:player2DidDraw)`. Model `gameDidStart` after the same method in the guided project from today. As for the other method, have it print a message like the following:
//: * "Player 1 drew a 6 of hearts, player 2 drew a jack of spades."
/// DONE THIS ABOVE
//: Step 21
//: Time to test all the types you've created. Create an instance of the `HighLow` class. Set the `delegate` property of that object to an instance of `CardGameTracker`. Lastly, call the `play()` method on the game object. It should print out to the console something that looks similar to the following:
//:
//: ```
//: Started a new game of High Low
//: Player 1 drew a 2 of diamonds, player 2 drew a ace of diamonds.
//: Player 1 wins with 2 of diamonds.
//: ```
/// DONE THIS ABOVE
