//
//  ViewController.swift
//  HighLow
//
//  Created by Shawn Gee on 2/18/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var player1LowButton: UIButton!
    @IBOutlet weak var player1HighButton: UIButton!
    @IBOutlet weak var player2LowButton: UIButton!
    @IBOutlet weak var player2HighButton: UIButton!
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        switch sender {
        case player1LowButton:
            print("Player 1 bets low")
        case player1HighButton:
            print("Player 1 bets high")
        case player2LowButton:
            print("Player 2 bets low")
        case player2HighButton:
            print("Player 2 bets high")
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "green_felt")!)
    }


}

