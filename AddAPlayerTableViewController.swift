//
//  AddAPlayerTableViewController.swift
//  Footballers
//
//  Created by Amber Spadafora on 4/23/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit

class AddAPlayerTableViewController: UITableViewController, UITextFieldDelegate {

    var savePlayerDelegate: savePlayer?
    var creatingANewPlayer: Bool?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var countryPickerView: UIPickerView!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    let countries = ["France", "Germany", "Italy", "UK", "Belgium"]
    
    var selectedRow: Int?
    var selectedCountry: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selectedCountry = "France"
        self.countryPickerView.dataSource = self
        self.countryPickerView.delegate = self
        
        let _ = [nameTextField, ageTextField, weightTextField, heightTextField].map{$0?.delegate = self}
    }
    
    @IBAction func savePlayer(_ sender: UIBarButtonItem) {
        
        self.countryPickerView.resignFirstResponder()
        
        guard let validName = nameTextField.text,
        let validAge = ageTextField.text,
        let validWeight = weightTextField.text,
        let validHeight = heightTextField.text
        else {
            let _ = self.navigationController?.popViewController(animated: true)
            return
        }
        let countryIndex = self.countryPickerView.selectedRow(inComponent: 0)
        
        let dict: [String: Any] = ["name": validName, "age": validAge, "height": validHeight, "country": self.countries[countryIndex], "weight": validWeight, "countryIndex": countryIndex]
        
        guard creatingANewPlayer != nil
            else {
                creatingANewPlayer = false
                self.savePlayerDelegate?.updatePlayer(playerInfo: dict, newPlayer: creatingANewPlayer!, currentRow: selectedRow)
                let _ = self.navigationController?.popViewController(animated: true)
                return
        }
        
        self.savePlayerDelegate?.updatePlayer(playerInfo: dict, newPlayer: creatingANewPlayer!, currentRow: selectedRow)
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editCurrentPlayer(_ sender: UIBarButtonItem) {
        let _ = [nameTextField, ageTextField, weightTextField, heightTextField].map{$0?.isEnabled = true}
        self.creatingANewPlayer = false
        self.countryPickerView.isUserInteractionEnabled = true
    }
    
   
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

}

    // MARK: - UIPickerView Delegate and Data Source
extension AddAPlayerTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
   
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.countries.count
    }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.countries[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedCountry = self.countries[row]
        pickerView.resignFirstResponder()
    }
    
}
