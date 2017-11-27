//
//  ViewController.swift
//  Closet
//
//  Created by Lindsey Thomson on 10/16/17.
//  Copyright © 2017 Lindsey Thomson. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var degreesLabel: UILabel!
    @IBOutlet weak var clothingTableView: UITableView!
    
    var clothingSuitable: [NSManagedObject] =  []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.degreesLabel.text = "\(DataContainerSingleton.sharedDataContainer.currentTemp) Degrees F"

        clothingTableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "Cell")

        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "PieceOfClothing")
        
        //3
        do {
            DataContainerSingleton.sharedDataContainer.pieceOfClothingObject = try managedContext.fetch(fetchRequest)
            getSuitableClothing(allClothing: DataContainerSingleton.sharedDataContainer.pieceOfClothingObject)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getSuitableClothing (allClothing: [NSManagedObject])
    {
        let temp = DataContainerSingleton.sharedDataContainer.currentTemp
        var count: Int = 0
        while(count < allClothing.count)
        {
            let min = allClothing[count].value(forKeyPath: "minTemp") as! NSNumber
            let max = allClothing[count].value(forKeyPath: "maxTemp") as! NSNumber
            print(allClothing[count])
            print("Min \(min) Max \(max)")
            print(temp)
            if(min.doubleValue < temp && max.doubleValue > temp )
            {
                print(allClothing[count])
                clothingSuitable.append(allClothing[count])
            }
            count = count + 1
        }
        print(clothingSuitable)
    }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return clothingSuitable.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            
            let clothes = clothingSuitable[indexPath.row]
            let cell =
                tableView.dequeueReusableCell(withIdentifier: "Cell",
                                              for: indexPath)
                cell.textLabel?.text = clothes.value(forKeyPath: "descriptionOfClothing") as? String
            return cell
    }
}

