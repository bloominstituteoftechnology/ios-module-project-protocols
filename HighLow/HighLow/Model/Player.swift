//
//  Player.swift
//  HighLow
//
//  Created by Shawn Gee on 2/19/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import Foundation

class Player {
    let name: String
    var score = 0
    var bet: Bet?
    
    init(name: String) {
        self.name = name
    }
}
