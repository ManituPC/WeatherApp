//
//  NewCityViewController.swift
//  WeatherApp
//
//  Created by denis.chicherin on 12.11.2019.
//  Copyright © 2019 ChiAppCompany. All rights reserved.
//

import UIKit


protocol AddNewCityVCDelegate: class {
    func addNewCityVCDidCancel(_ controller: NewCityViewController)
    
    func addNewCityVC(_ controller: NewCityViewController, didFinishAdding city: City)
}

class NewCityViewController: UITableViewController, UITextFieldDelegate {
    
    weak var delegate: AddNewCityVCDelegate?
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }
    
    
    // MARK:- Actions
    
    @IBAction func cancel() {
        delegate?.addNewCityVCDidCancel(self)
    }
    
    @IBAction func done() {
        let city = City()
        city.name = textField.text!
        
        delegate?.addNewCityVC(self, didFinishAdding: city)
    }
    
    // MARK:- Table View Delegates
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    // MARK:- Text Field Delegates
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        doneBarButton.isEnabled = !newText.isEmpty
        
        return true
    }
}
