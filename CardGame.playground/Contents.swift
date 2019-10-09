import UIKit

enum Rank: Int {
    case ace = 1, one, two, three, four, five, six, seven, eight, nine, ten, jack, queen, king
}

enum Suit: String {
    case hearts
    case diamonds
    case spades
    case clubs
}

struct Card {
    var rank: Rank
    var suit: Suit
}

var counter = 0
var populate: Card
var populate2: Card
var deckArray = [Card]()

populate = Card(rank: .ace, suit: .spades)

while counter <= 50 {
    if counter >= 0 && counter <= 12 {
        
        switch counter {
        case 0, 13, 26, 39: populate.rank = .ace
        case 1, 14, 27, 40: populate.rank = .two
        case 2, 15, 28, 41: populate.rank = .three
        case 3, 16, 29, 42: populate.rank = .four
        case 4, 17, 30, 43: populate.rank = .five
        case 5, 18, 31, 44: populate.rank = .six
        case 6, 19, 32, 45: populate.rank = .seven
        case 7, 20, 33, 46: populate.rank = .eight
        case 8, 21, 34, 47: populate.rank = .nine
        case 9, 22, 35, 48: populate.rank = .ten
        case 10, 23, 36, 49: populate.rank = .jack
        case 11, 24, 37, 50: populate.rank = .queen
        case 12, 25, 38, 51: populate.rank = .king
        default: populate.rank = .ace
        }
        
        populate.suit = .clubs
   
        deckArray.append(populate) }
        
    else if counter >= 13 && counter <= 25 {
        
            populate.suit = .diamonds
            switch counter {
            case 0, 13, 26, 39: populate.rank = .ace
            case 1, 14, 27, 40: populate.rank = .two
            case 2, 15, 28, 41: populate.rank = .three
            case 3, 16, 29, 42: populate.rank = .four
            case 4, 17, 30, 43: populate.rank = .five
            case 5, 18, 31, 44: populate.rank = .six
            case 6, 19, 32, 45: populate.rank = .seven
            case 7, 20, 33, 46: populate.rank = .eight
            case 8, 21, 34, 47: populate.rank = .nine
            case 9, 22, 35, 48: populate.rank = .ten
            case 10, 23, 36, 49: populate.rank = .jack
            case 11, 24, 37, 50: populate.rank = .queen
            case 12, 25, 38, 51: populate.rank = .king
            default: populate.rank = .ace
            }
            deckArray.append(populate) }
        
    else if counter >= 26 && counter <= 38 {
            populate.suit = .hearts
            switch counter {
            case 0, 13, 26, 39: populate.rank = .ace
            case 1, 14, 27, 40: populate.rank = .two
            case 2, 15, 28, 41: populate.rank = .three
            case 3, 16, 29, 42: populate.rank = .four
            case 4, 17, 30, 43: populate.rank = .five
            case 5, 18, 31, 44: populate.rank = .six
            case 6, 19, 32, 45: populate.rank = .seven
            case 7, 20, 33, 46: populate.rank = .eight
            case 8, 21, 34, 47: populate.rank = .nine
            case 9, 22, 35, 48: populate.rank = .ten
            case 10, 23, 36, 49: populate.rank = .jack
            case 11, 24, 37, 50: populate.rank = .queen
            case 12, 25, 38, 51: populate.rank = .king
            default: populate.rank = .ace
            }
            deckArray.append(populate) }
        
    else if counter >= 39 && counter <= 51 {
            populate.suit = .spades
            switch counter {
            case 0, 13, 26, 39: populate.rank = .ace
            case 1, 14, 27, 40: populate.rank = .two
            case 2, 15, 28, 41: populate.rank = .three
            case 3, 16, 29, 42: populate.rank = .four
            case 4, 17, 30, 43: populate.rank = .five
            case 5, 18, 31, 44: populate.rank = .six
            case 6, 19, 32, 45: populate.rank = .seven
            case 7, 20, 33, 46: populate.rank = .eight
            case 8, 21, 34, 47: populate.rank = .nine
            case 9, 22, 35, 48: populate.rank = .ten
            case 10, 23, 36, 49: populate.rank = .jack
            case 11, 24, 37, 50: populate.rank = .queen
            case 12, 25, 38, 51: populate.rank = .king
            default: populate.rank = .ace
            }
            deckArray.append(populate) }

    counter += 1
}

var playerOneRand = Int.random(in: 0...51)
var playerTwoRand = Int.random(in: 0...51)

//NOT THE SAME CARD
while playerOneRand == playerTwoRand {
    playerOneRand = Int.random(in: 0...51)
    playerTwoRand = Int.random(in: 0...51)
}

var playerOneCard = deckArray[playerOneRand]
print("Player One draws a \(playerOneCard.rank) of \(playerOneCard.suit.rawValue)")

var playerTwoCard = deckArray[playerTwoRand]
print("Player Two draws a \(playerTwoCard.rank) of \(playerTwoCard.suit.rawValue)")
print("++++++++++++++++")

if playerOneCard.rank.rawValue > playerTwoCard.rank.rawValue {
    print("Player One Wins")
} else if playerOneCard.rank.rawValue < playerTwoCard.rank.rawValue {
    print("Player Two Wins")
} else if playerOneCard.rank.rawValue == playerTwoCard.rank.rawValue {
    print("Tie.")
}


