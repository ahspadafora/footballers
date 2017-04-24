//
//  PlayerListTableViewController.swift
//  Footballers
//
//  Created by Amber Spadafora on 4/23/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit

class PlayerListTableViewController: UITableViewController, savePlayer {
    
    var players: [Player] = []
    let playerCellReuseID = "PlayerCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: playerCellReuseID, for: indexPath) as! PlayerTableViewCell
        
        let currentPlayer = self.players[indexPath.row]
        cell.nameLabel.text = currentPlayer.name
        cell.ageLabel.text = "\(currentPlayer.age) years old"
        cell.flagImageView.image = cell.setFlagImage(country: currentPlayer.country)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailsVC: AddAPlayerTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "addPlayer") as! AddAPlayerTableViewController
        let selectedPlayer = players[indexPath.row]
        
        detailsVC.savePlayerDelegate = self
        detailsVC.tableView.headerView(forSection: 0)?.textLabel?.text = "Player Details"
        detailsVC.editButton.isEnabled = true
        detailsVC.countryPickerView.isUserInteractionEnabled = false
        detailsVC.selectedRow = indexPath.row
        
        let _ = [detailsVC.ageTextField, detailsVC.nameTextField, detailsVC.heightTextField, detailsVC.weightTextField].map{$0?.isEnabled = false}
        
        detailsVC.ageTextField.text = selectedPlayer.age
        detailsVC.nameTextField.text = selectedPlayer.name
        detailsVC.heightTextField.text = selectedPlayer.height
        detailsVC.weightTextField.text = selectedPlayer.weight
        
        detailsVC.countryPickerView.selectRow(selectedPlayer.countryIndex, inComponent: 0, animated: true)
        
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.players.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    
    
    @IBAction func addANewPlayer(_ sender: UIBarButtonItem) {
        let addPlayerVC: AddAPlayerTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "addPlayer") as! AddAPlayerTableViewController
        
        addPlayerVC.savePlayerDelegate = self
        addPlayerVC.editButton.isEnabled = false
        addPlayerVC.editButton.title = ""
        addPlayerVC.creatingANewPlayer = true
        self.navigationController?.pushViewController(addPlayerVC, animated: true)
    }

    
    // conformance to savePlayer Protocol
    func updatePlayer(playerInfo: [String : Any], newPlayer: Bool, currentRow: Int? ) {
        
        if newPlayer {
            let newPlayer = Player(dict: playerInfo)
            self.players.append(newPlayer)
        } else {
            guard let validRow = currentRow else { return }
            self.players[validRow] = Player(dict: playerInfo)
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
            print(self.players.count)
        }
    }
 

}
