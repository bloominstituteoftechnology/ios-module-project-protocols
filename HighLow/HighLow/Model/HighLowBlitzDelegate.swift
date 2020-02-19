//
//  HighLowBlitzDelegate.swift
//  HighLow
//
//  Created by Shawn Gee on 2/19/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import Foundation

protocol HighLowBlitzDelegate: AnyObject {
    func gameDidFlipFirstCard(_ card: PlayingCard)
    func gameDidFlipSecondCard(_ card: PlayingCard)
    func gameDidUpdateScore(playerOneScore: Int, playerTwoScore: Int)
}
