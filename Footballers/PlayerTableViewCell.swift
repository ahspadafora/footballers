//
//  PlayerTableViewCell.swift
//  Footballers
//
//  Created by Amber Spadafora on 4/23/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func setFlagImage(country: String) -> UIImage {
        switch country {
        case "Germany":
            return #imageLiteral(resourceName: "germany")
        case "UK":
            return #imageLiteral(resourceName: "uk")
        case "France":
            return #imageLiteral(resourceName: "french-flag-graphic")
        case "Italy":
            return #imageLiteral(resourceName: "italian-flag-graphic")
        case "Belgium":
            return #imageLiteral(resourceName: "belgian-flag-large")
        default:
            return UIImage()
        }
    }

}
