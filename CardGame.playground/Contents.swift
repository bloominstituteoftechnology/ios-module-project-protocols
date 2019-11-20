import Foundation

//: ## Step 1
//: Create an enumeration for the value of a playing card. The values are: `ace`, `two`, `three`, `four`, `five`, `six`, `seven`, `eight`, `nine`, `ten`, `jack`, `queen`, and `king`. Set the raw type of the enum to `Int` and assign the ace a value of `1`.
enum Rank: Int {
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
    case jack
    case queen
    case king
    
    static var allRanks: [Int] = [ace.rawValue, two.rawValue, three.rawValue, four.rawValue, five.rawValue, six.rawValue, seven.rawValue, eight.rawValue, nine.rawValue, ten.rawValue, jack.rawValue, queen.rawValue, king.rawValue]
    
}


//: ## Step 2
//: Once you've defined the enum as described above, take a look at this built-in protocol, [CustomStringConvertible](https://developer.apple.com/documentation/swift/customstringconvertible) and make the enum conform to that protocol. Make the face cards return a string of their name, and for the numbered cards, simply have it return that number as a string.
extension Rank: CustomStringConvertible {
    var description: String {
        return "\(Rank.ace), \(Rank.two.rawValue), \(Rank.three.rawValue), \(Rank.three.rawValue), \(Rank.four.rawValue), \(Rank.five.rawValue), \(Rank.six.rawValue), \(Rank.seven.rawValue), \(Rank.eight.rawValue), \(Rank.nine.rawValue), \(Rank.ten.rawValue), \(Rank.jack.self), \(Rank.queen.self) \(Rank.king.self)"
    }
    
    
}


//: ## Step 3
//: Create an enum for the suit of a playing card. The values are `hearts`, `diamonds`, `spades`, and `clubs`. Use a raw type of `String` for this enum (this will allow us to get a string version of the enum cases for free, no use of `CustomStringConvertible` required).
enum Suit: String {
    case hearts = "Hearts"
    case diamonds = "Diamonds"
    case spades = "Spades"
    case clubs = "Clubs"
    
    static var allSuits: [String] = [hearts.rawValue, diamonds.rawValue, spades.rawValue, clubs.rawValue]
}



//: ## Step 4
//: Using the two enums above, create a `struct` called `Card` to model a single playing card. It should have constant properties for each constituent piece (one for suit and one for rank).
struct Card {
    let suit: Suit
    let rank: Rank
    
   
}





//extension Card: CustomStringConvertible {
//    var description: String {
//        return "\(rank) of \(suit) "
//
//
//    }
//}

//: ## Step 6
//: Create a `struct` to model a deck of cards. It should be called `Deck` and have an array of `Card` objects as a constant property. A custom `init` function should be created that initializes the array with a card of each rank and suit. You'll want to iterate over all ranks, and then over all suits (this is an example of _nested `for` loops_). See the next 2 steps before you continue with the nested loops.
    struct Deck {
        let deck: [Card] = []

        init(cardDescription: Card) {
            for rank in Rank.allRanks {
                for suit in Suit.allSuits {
                    deck.append(cardDescription)
                    
                    self.deck = [cardDescription]
                }
        }
}
}



//: ## Step 7
//: In the rank enum, add a static computed property that returns all the ranks in an array. Name this property `allRanks`. This is needed because you can't iterate over all cases from an enum automatically.




//: ## Step 8
//: In the suit enum, add a static computed property that returns all the suits in an array. Name this property `allSuits`.




//: ## Step 9
//: Back to the `Deck` and the nested loops. Now that you have a way to get arrays of all rank values and all suit values, create 2 `for` loops in the `init` method, one nested inside the other, where you iterate over each value of rank, and then iterate over each value of suit. See an example below to get an idea of how this will work. Imagine an enum that contains the 4 cardinal directions, and imagine that enum has a property `allDirections` that returns an array of them.
//: ```
//: for direction in Compass.allDirections {
//:
//:}
//:```



//: ## Step 10
//: These loops will allow you to match up every rank with every suit. Make a `Card` object from all these pairings and append each card to the `cards` property of the deck. At the end of the `init` method, the `cards` array should contain a full deck of standard playing card objects.
let ace = (Card(suit: .clubs, rank: .ace), Card(suit: .diamonds, rank: .ace), Card(suit: .hearts, rank: .ace), Card(suit: .spades, rank: .ace))


let two = (Card(suit: .clubs, rank: .two), Card(suit: .diamonds, rank: .two), Card(suit: .hearts, rank: .two), Card(suit: .spades, rank: .two))
let three = (Card(suit: .clubs, rank: .three), Card(suit: .diamonds, rank: .three), Card(suit: .hearts, rank: .three), Card(suit: .hearts, rank: .three))
let four = (Card(suit: .clubs, rank: .four), Card(suit: .diamonds, rank: .four), Card(suit: .hearts, rank: .four), Card(suit: .spades, rank: .three))
let five = (Card(suit: .clubs, rank: .five), Card(suit: .diamonds, rank: .four), Card(suit: .hearts, rank: .five), Card(suit: .spades, rank: .five))
let six = (Card(suit: .clubs, rank: .six), Card(suit: .diamonds, rank: .six), Card(suit: .hearts, rank: .six), Card(suit: .spades, rank: .six))
let seven = (Card(suit: .clubs, rank: .seven), Card(suit: .diamonds, rank: .seven), Card(suit: .hearts, rank: .seven), Card(suit: .spades, rank: .seven))
let eight = (Card(suit: .clubs, rank: .eight), Card(suit: .diamonds, rank: .eight), Card(suit: .hearts, rank: .eight), Card(suit: .hearts, rank: .eight))
let nine = (Card(suit: .clubs, rank: .nine), Card(suit: .diamonds, rank: .nine), Card(suit: .hearts, rank: .nine), Card(suit: .spades, rank: .nine))
let ten = (Card(suit: .clubs, rank: .ten), Card(suit: .diamonds, rank: .ten), Card(suit: .hearts, rank: .ten), Card(suit: .spades, rank: .ten))
let jack = (Card(suit: .clubs, rank: .jack), Card(suit: .diamonds, rank: .queen), Card(suit: .hearts, rank: .queen), Card(suit: .spades, rank: .jack))
let queen = (Card(suit: .clubs, rank: .queen), Card(suit: .diamonds, rank: .queen), Card(suit: .hearts, rank: .queen), Card(suit: .spades, rank: .queen))




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
    var deck: Deck
    var delegate: CardGameDelegate?
    
    func play() {
        delegate?.gameDidStart(self)
    }
    init(deck: Deck, delegate: CardGameDelegate?) {
        self.deck = deck
        self.delegate = delegate
}
}



//: ## Step 15
//: As part of the protocol conformance, implement a method called `play()`. The method should draw 2 cards from the deck, one for player 1 and one for player 2. These cards will then be compared to see which one is higher. The winning player will be printed along with a description of the winning card. Work will need to be done to the `Suit` and `Rank` types above, so see the next couple steps before continuing with this step.




//: ## Step 16
//: Take a look at the Swift docs for the [Comparable](https://developer.apple.com/documentation/swift/comparable) protocol. In particular, look at the two functions called `<` and `==`.




//: ## Step 17
//: Make the `Rank` type conform to the `Comparable` protocol. Implement the `<` and `==` functions such that they compare the `rawValue` of the `lhs` and `rhs` arguments passed in. This will allow us to compare two rank values with each other and determine whether they are equal, or if not, which one is larger.
extension Rank: Comparable {
    static func < (lhs: Rank, rhs: Rank) -> Bool {
        if lhs.rawValue != rhs.rawValue {
            
        }
        return lhs.rawValue < lhs.rawValue
    }
    
}




//: Step 18
//: Make the `Card` type conform to the `Comparable` protocol. Implement the `<` and `==` methods such that they compare the ranks of the `lhs` and `rhs` arguments passed in. For the `==` method, compare **both** the rank and the suit.
extension Card: Comparable {
    static func < (lhs: Card, rhs: Card) -> Bool {
        if
    }
    
}




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


