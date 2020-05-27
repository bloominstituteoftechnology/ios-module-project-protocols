import Foundation

//: ## Step 1
//: Create an enumeration for the value of a playing card. The values are: `ace`, `two`, `three`, `four`, `five`, `six`, `seven`, `eight`, `nine`, `ten`, `jack`, `queen`, and `king`. Set the raw type of the enum to `Int` and assign the ace a value of `1`.
enum CardRank: Int, Comparable {
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
    
    static let allRanks: [CardRank] = [.ace, .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten, .jack, .queen, .king]
    
    static func < (lhs: CardRank, rhs: CardRank) -> Bool {
        if lhs.rawValue < rhs.rawValue { return true }
        else { return false }
    }
    static func == (lhs: CardRank, rhs: CardRank) -> Bool {
           if lhs.rawValue == rhs.rawValue { return true }
           else { return false }
       }
}
//: ## Step 2
//: Once you've defined the enum as described above, take a look at this built-in protocol, [CustomStringConvertible](https://developer.apple.com/documentation/swift/customstringconvertible) and make the enum conform to that protocol. Make the face cards return a string of their name, and for the numbered cards, simply have it return that number as a string.
extension CardRank: CustomStringConvertible {
    var description: String {
        switch self {
        case .ace:
            return "Ace"
        case .jack:
            return "Jack"
        case .queen:
            return "Queen"
        case .king:
            return "King"
        default:
            return String(self.rawValue)
        }
    }
}
//: ## Step 3
//: Create an enum for the suit of a playing card. The values are `hearts`, `diamonds`, `spades`, and `clubs`. Use a raw type of `String` for this enum (this will allow us to get a string version of the enum cases for free, no use of `CustomStringConvertible` required).
enum CardSuit: String {
    case hearts = "Hearts"
    case diamonds = "Diamonds"
    case spades = "Spades"
    case clubs = "Clubs"
    
    static let allSuits: [CardSuit] = [.hearts, .diamonds, .spades, .clubs]
}
//: ## Step 4
//: Using the two enums above, create a `struct` called `Card` to model a single playing card. It should have constant properties for each constituent piece (one for suit and one for rank).
struct Card: Comparable {
    let suit: CardSuit
    let rank: CardRank
    
    static func < (lhs: Card, rhs: Card) -> Bool {
        if lhs.rank.rawValue < rhs.rank.rawValue { return true }
        else { return false }
    }
    static func == (lhs: Card, rhs: Card) -> Bool {
        if lhs.rank.rawValue == rhs.rank.rawValue && lhs.suit == rhs.suit { return true }
        else { return false }
    }
    static func * (lhs: Card, rhs: Card) -> Bool {
        if lhs.rank.rawValue == rhs.rank.rawValue && lhs.suit != rhs.suit { return true }
        else { return false }
    }
}
//: ## Step 5
//: Make the card also conform to `CustomStringConvertible`. When turned into a string, a card's value should look something like this, "ace of spades", or "3 of diamonds".
extension Card: CustomStringConvertible {
    var description: String {
        return "\(self.rank) of \(self.suit.rawValue)"
    }
}
//: ## Step 6
//: Create a `struct` to model a deck of cards. It should be called `Deck` and have an array of `Card` objects as a constant property. A custom `init` function should be created that initializes the array with a card of each rank and suit. You'll want to iterate over all ranks, and then over all suits (this is an example of _nested `for` loops_). See the next 2 steps before you continue with the nested loops.
struct Deck {
    var cards: [Card]
    
    init() {
        self.cards = []
        for rank in CardRank.allRanks {
            for suit in CardSuit.allSuits {
                self.cards.append(Card(suit: suit, rank: rank))
            }
        }
    }
    
    func drawCard() -> Card {
        return self.cards[Int.random(in: 0...51)]
    }
}
//: ## Step 7
//: In the rank enum, add a static computed property that returns all the ranks in an array. Name this property `allRanks`. This is needed because you can't iterate over all cases from an enum automatically.
// See above
//: ## Step 8
//: In the suit enum, add a static computed property that returns all the suits in an array. Name this property `allSuits`.
// See above
//: ## Step 9
//: Back to the `Deck` and the nested loops. Now that you have a way to get arrays of all rank values and all suit values, create 2 `for` loops in the `init` method, one nested inside the other, where you iterate over each value of rank, and then iterate over each value of suit. See an example below to get an idea of how this will work. Imagine an enum that contains the 4 cardinal directions, and imagine that enum has a property `allDirections` that returns an array of them.
//: ```
//: for direction in Compass.allDirections {
//:
//:}
//:```
// See above
//: ## Step 10
//: These loops will allow you to match up every rank with every suit. Make a `Card` object from all these pairings and append each card to the `cards` property of the deck. At the end of the `init` method, the `cards` array should contain a full deck of standard playing card objects.
// See above
//: ## Step 11
//: Add a method to the deck called `drawCard()`. It takes no arguments and it returns a `Card` object. Have it draw a random card from the deck of cards and return it.
//: - Callout(Hint): There should be `52` cards in the deck. So what if you created a random number within those bounds and then retrieved that card from the deck? Remember that arrays are indexed from `0` and take that into account with your random number picking.
// See above
//: ## Step 12
//: Create a protocol for a `CardGame`. It should have two requirements:
//: * a gettable `deck` property
//: * a `play()` method
protocol CardGame {
    var deck: Deck { get }
    func play()
}
//: ## Step 13
//: Create a protocol for tracking a card game as a delegate called `CardGameDelegate`. It should have two functional requirements:
//: * a function called `gameDidStart` that takes a `CardGame` as an argument
//: * a function with the following signature: `game(player1DidDraw card1: Card, player2DidDraw card2: Card)`
protocol CardGameDelegate {
    func gameDidStart(_ game: CardGame)
    func game(player1DidDraw card1: Card, player2DidDraw card2: Card)
}
//: ## Step 14
//: Create a class called `HighLow` that conforms to the `CardGame` protocol. It should have an initialized `Deck` as a property, as well as an optional delegate property of type `CardGameDelegate`.
class HighLow: CardGame {
    let deck = Deck()
    var delegate: CardGameDelegate?
    
    func play() {
        delegate?.gameDidStart(self)
        
        let player1Card = deck.drawCard()
        let player2Card = deck.drawCard()
        
        delegate?.game(player1DidDraw: player1Card, player2DidDraw: player2Card)
        
        if player1Card == player2Card {
            print("Both players drew the \(player1Card). It's a tie!")
        } else if player1Card * player2Card {
            print("Both players drew the \(player1Card.rank). It's a tie!")
        } else if player1Card < player2Card {
            print("Player 2 has won the game with the \(player2Card).")
        } else {
            print("Player 1 has won the game with the \(player1Card).")
        }
    }
}
//: ## Step 15
//: As part of the protocol conformance, implement a method called `play()`. The method should draw 2 cards from the deck, one for player 1 and one for player 2. These cards will then be compared to see which one is higher. The winning player will be printed along with a description of the winning card. Work will need to be done to the `Suit` and `Rank` types above, so see the next couple steps before continuing with this step.
// See above
//: ## Step 16
//: Take a look at the Swift docs for the [Comparable](https://developer.apple.com/documentation/swift/comparable) protocol. In particular, look at the two functions called `<` and `==`.
// Noted
//: ## Step 17
//: Make the `Rank` type conform to the `Comparable` protocol. Implement the `<` and `==` functions such that they compare the `rawValue` of the `lhs` and `rhs` arguments passed in. This will allow us to compare two rank values with each other and determine whether they are equal, or if not, which one is larger.
// See above
//: Step 18
//: Make the `Card` type conform to the `Comparable` protocol. Implement the `<` and `==` methods such that they compare the ranks of the `lhs` and `rhs` arguments passed in. For the `==` method, compare **both** the rank and the suit.
// See above
//: ## Step 19
//: Back to the `play()` method. With the above types now conforming to `Comparable`, you can write logic to compare the drawn cards and print out 1 of 3 possible message types:
//: * Ends in a tie, something like, "Round ends in a tie with 3 of clubs."
//: * Player 1 wins with a higher card, e.g. "Player 1 wins with 8 of hearts."
//: * Player 2 wins with a higher card, e.g. "Player 2 wins with king of diamonds."
// See above
//: ## Step 20
//: Create a class called `CardGameTracker` that conforms to the `CardGameDelegate` protocol. Implement the two required functions: `gameDidStart` and `game(player1DidDraw:player2DidDraw)`. Model `gameDidStart` after the same method in the guided project from today. As for the other method, have it print a message like the following:
//: * "Player 1 drew a 6 of hearts, player 2 drew a jack of spades."
class CardGameTracker: CardGameDelegate {
    func gameDidStart(_ game: CardGame) {
        if game is HighLow {
            print("Started a new game of High Low.")
        }
    }
    
    func game(player1DidDraw card1: Card, player2DidDraw card2: Card) {
        print("Player 1 drew the \(card1) and Player 2 drew the \(card2).")
    }
}
//: Step 21
//: Time to test all the types you've created. Create an instance of the `HighLow` class. Set the `delegate` property of that object to an instance of `CardGameTracker`. Lastly, call the `play()` method on the game object. It should print out to the console something that looks similar to the following:
//:
//: ```
//: Started a new game of High Low
//: Player 1 drew a 2 of diamonds, player 2 drew a ace of diamonds.
//: Player 1 wins with 2 of diamonds.
//: ```
let tracker = CardGameTracker()
let game = HighLow()
game.delegate = tracker

game.play()


print("")
print("")



// Just for fun - Here's a different version

// High Low - The Extended Version
// As the cards are drawn, they are removed from the deck.
// Scores are kept - 1 point awarded to winner of each round. (No points awarded if it's a tie.)
// Game is over when all the cards have been drawn (26 rounds). Winner is announced based on final score.

extension Deck {
    mutating func drawCard2() -> Card {
        let cardIndex = Int.random(in: 0..<self.cards.count)
        let card = self.cards[cardIndex]
        self.cards.remove(at: cardIndex)
        return card
    }
}

extension CardGameDelegate {
    func gameDidEnd(player1Score: Int, player2Score: Int) {
        if player1Score == player2Score {
            print("The players have tied with a final score of \(player1Score)!")
        } else if player1Score > player2Score {
            print("Player 1 has won the game with a final score of \(player1Score).")
        } else {
            print("Player 2 has won the game with a final score of \(player2Score).")
        }
    }
}

class CardGameTracker2: CardGameDelegate {
    func gameDidStart(_ game: CardGame) {
        if game is HighLow2 {
            print("Started a new game of High Low - Extended Version.")
        }
    }
    
    func game(player1DidDraw card1: Card, player2DidDraw card2: Card) {
        print("Player 1 drew the \(card1) and Player 2 drew the \(card2).")
    }
    
    func gameDidEnd(player1Score: Int, player2Score: Int) {
        if player1Score == player2Score {
            print("The players have tied with a final score of \(player1Score).")
        } else if player1Score > player2Score {
            print("Player 1 has won the game with a final score of \(player1Score).")
        } else {
            print("Player 2 has won the game with a final score of \(player2Score).")
        }
    }
}

class HighLow2: CardGame {
    var deck = Deck()
    var delegate: CardGameDelegate?
    
    func play() {
        delegate?.gameDidStart(self)
        
        var player1Score = 0
        var player2Score = 0
        
        var player1Card: Card
        var player2Card: Card
        
        for _ in 1...26 {
            player1Card = deck.drawCard2()
            player2Card = deck.drawCard2()
        
            delegate?.game(player1DidDraw: player1Card, player2DidDraw: player2Card)
        
            if player1Card * player2Card {
                print("Both players drew the \(player1Card.rank). It's a tie! The score is still \(player1Score) to \(player2Score).")
                print("")
            } else if player1Card < player2Card {
                player2Score += 1
                print("Player 2 has won the round with the \(player2Card). The score is now \(player1Score) to \(player2Score).")
                print("")
            } else {
                player1Score += 1
                print("Player 1 has won the round with the \(player1Card). The score is now \(player1Score) to \(player2Score).")
                print("")
            }
        }
        if self.deck.cards.count == 0 {
            print("There are no cards left in the deck.")
        }
        delegate?.gameDidEnd(player1Score: player1Score, player2Score: player2Score)
    }
}


let tracker2 = CardGameTracker2()
let game2 = HighLow2()
game2.delegate = tracker2

game2.play()
