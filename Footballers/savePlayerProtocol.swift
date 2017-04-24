//
//  savePlayerProtocol.swift
//  Footballers
//
//  Created by Amber Spadafora on 4/23/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import Foundation

protocol savePlayer {
    func updatePlayer(playerInfo: [String: Any], newPlayer: Bool, currentRow: Int?)
}
