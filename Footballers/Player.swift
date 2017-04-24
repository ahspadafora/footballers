//
//  Player.swift
//  Footballers
//
//  Created by Amber Spadafora on 4/23/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import Foundation

class Player {
    
    var name: String
    var country: String
    var height: String
    var weight: String
    var age: String
    var countryIndex: Int
    
    init(name: String, country: String, height: String, weight: String, age: String, countryIndex: Int) {
        self.name = name
        self.country = country
        self.height = height
        self.weight = weight
        self.age = age
        self.countryIndex = countryIndex
    }
    
    convenience init(dict: [String: Any]) {
        
        guard let name = dict["name"] as? String,
            let country = dict["country"] as? String,
            let height = dict["height"] as? String,
            let weight = dict["weight"] as? String,
            let age = dict["age"] as? String,
            let countryIndex = dict["countryIndex"] as? Int
            else {
                self.init(name: "", country: "", height: "", weight: "", age: "", countryIndex: 0)
                print("convenience init failed")
                return
            }
        self.init(name: name, country: country, height: height, weight: weight, age: age, countryIndex: countryIndex)
    }
}
