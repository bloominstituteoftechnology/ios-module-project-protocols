import Foundation

//: ## Step 1
//: Create an enumeration for the value of a playing card. The values are: `ace`, `two`, `three`, `four`, `five`, `six`, `seven`, `eight`, `nine`, `ten`, `jack`, `queen`, and `king`. Set the raw type of the enum to `Int` and assign the ace a value of `1`.

enum Rank: Int, CustomStringConvertible {
        
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
        return [ace, two, three, four, five, six, seven, eight, nine, ten, jack, queen, king]
    }
}

enum Suit: String {
    case hearts = "hearts"
    case spades = "spades"
    case clubs = "clubs"
    case diamonds = "diamonds"
    
    static var allSuits: [Suit] {
        return [hearts, spades, clubs, diamonds]
    }
}

struct Card: CustomStringConvertible {
    let suit: Suit
    let rank: Rank
    
    var description: String {
        return "\(rank.description) of \(suit.rawValue)"
    }
}

struct Deck {
    let cards: [Card]
    
    init() {
        cards = []
    }
}

//: for direction in Compass.allDirections {
//:
//:}
//:```


//: Started a new game of High Low
//: Player 1 drew a 2 of diamonds, player 2 drew a ace of diamonds.
//: Player 1 wins with 2 of diamonds.
//: ```


