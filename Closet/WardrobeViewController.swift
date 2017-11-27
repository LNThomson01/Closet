//
//  WardrobeViewController.swift
//  Closet
//
//  Created by Lindsey Thomson on 11/10/17.
//  Copyright © 2017 Lindsey Thomson. All rights reserved.
//

import UIKit
import CoreData

class WardrobeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "Cell")
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
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToWardrobe(segue: UIStoryboardSegue) {
        self.tableView.reloadData()
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "unwindToMain", sender: self)
    }
    

}

extension WardrobeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return DataContainerSingleton.sharedDataContainer.pieceOfClothingObject.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            
            let clothes = DataContainerSingleton.sharedDataContainer.pieceOfClothingObject[indexPath.row]
            let cell =
                tableView.dequeueReusableCell(withIdentifier: "Cell",
                                              for: indexPath)
            cell.textLabel?.text =
                clothes.value(forKeyPath: "descriptionOfClothing") as? String
            return cell
    }
}

