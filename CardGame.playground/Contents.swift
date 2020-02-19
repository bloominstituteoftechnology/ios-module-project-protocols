import Foundation

enum Rank: Int, CustomStringConvertible, CaseIterable, Comparable {
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
      return  "Queen"
    case .king:
      return "King"
    }
  }

  static func <(lhs: Rank, rhs: Rank) -> Bool {
    return lhs.rawValue < rhs.rawValue
  }

  static func ==(lhs: Rank, rhs: Rank) -> Bool {
    return lhs.rawValue == rhs.rawValue
  }
}

enum Suit: String, CaseIterable {
  case hearts
  case diamonds
  case spades
  case clubs
}

struct Card: CustomStringConvertible, Comparable {
  let rank: Rank
  let suit: Suit

  var description: String {
    return "\(rank.description) of \(suit)"
  }

  static func <(lhs: Card, rhs: Card) -> Bool {
    return lhs.rank < rhs.rank
  }

  static func ==(lhs: Card, rhs: Card) -> Bool {
    return lhs.rank == rhs.rank && lhs.suit == rhs.suit
  }
}

struct Deck {
  let cards: [Card]

  init(cards: [Card]? = nil) {
    self.cards = cards ?? Deck.standardCards()
  }

  private static func standardCards() -> [Card] {
    var cards = Array<Card>()
    for rank in Rank.allCases {
      for suit in Suit.allCases {
        cards.append(Card(rank: rank, suit: suit))
      }
    }
    return cards
  }

  func drawCard() -> Card {
    let index = Int.random(in: 0..<cards.count)
    return cards[index]
  }
}

protocol CardGame {

  var deck: Deck { get }

  func play()
}

class HighLow: CardGame {
  let deck = Deck()

  func play() {
    let player1Card = deck.drawCard()
    let player2Card = deck.drawCard()
  }
}

//: ## Step 14
//: Create a class called `HighLow` that conforms to the `CardGame` protocol. It should have an initialized `Deck` as a property, as well as an optional delegate property of type `CardGameDelegate`.




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


