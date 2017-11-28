//
//  AddClothingViewController.swift
//  Closet
//
//  Created by Lindsey Thomson on 11/24/17.
//  Copyright © 2017 Lindsey Thomson. All rights reserved.
//

import UIKit
import CoreData

class AddClothingViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
  
    
    //MARK: Properties
    @IBOutlet weak var minDegreesLabel: UILabel!
    @IBOutlet weak var minSliderOutlet: UISlider!
    @IBOutlet weak var maxDegreesLabel: UILabel!
    @IBOutlet weak var maxSliderOutlet: UISlider!
    @IBOutlet weak var clothingTypePicker: UIPickerView!
    @IBOutlet weak var descriptionText: UITextField!
    
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clothingTypePicker.delegate = self
        self.clothingTypePicker.dataSource = self
        
        pickerData = ["Top", "Bottom", "Shoes"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    //MARK: Actions
    @IBAction func minDegreesSlider(_ sender: UISlider) {
        let currentValue = Int(minSliderOutlet.value)
        minDegreesLabel.text = "Min degrees: \(currentValue)"
    }
    
    @IBAction func maxDegreesSlider(_ sender: UISlider) {
        let currentValue = Int(maxSliderOutlet.value)
        maxDegreesLabel.text = "Max degrees: \(currentValue)"
    }
    
    @IBAction func doneButton(_ sender: UIButton) {
        self.save(test: "This is a test")
        self.performSegue(withIdentifier: "unwindToWardrobe", sender: self)
    }
    
    func save(test: String) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "PieceOfClothing",
                                       in: managedContext)!
        
        let tester = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        // 3
        tester.setValue(pickerData[clothingTypePicker.selectedRow(inComponent: 0)], forKeyPath: "type")
        tester.setValue(descriptionText.text, forKeyPath: "descriptionOfClothing")
        tester.setValue(Int(minSliderOutlet.value), forKeyPath: "minTemp")
        tester.setValue(Int(maxSliderOutlet.value), forKeyPath: "maxTemp")
        
        // 4
        do {
            try managedContext.save()
            DataContainerSingleton.sharedDataContainer.pieceOfClothingObject.append(tester)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}
