//
//  MainViewController.swift
//  Closet
//
//  Created by Lindsey Thomson on 11/10/17.
//  Copyright © 2017 Lindsey Thomson. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController {
    
 var clothingObjectArray: [NSManagedObject]?

    override func viewDidLoad() {
        super.viewDidLoad()
        getWeather()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    @IBAction func GetOutfitButton(_ sender: UIButton) {
    }
    
    @IBAction func unwindToMain(segue: UIStoryboardSegue) {}
    
    
    func getWeather()
    {
        let session = URLSession.shared
        //let weatherURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?id=4920423&units=imperial&appid=fb83cf7feb086f5c85003392f4d5a318")!
        //let weatherURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?id=5308655&units=imperial&appid=fb83cf7feb086f5c85003392f4d5a318")!
        let weatherURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?id=5861897&units=imperial&appid=fb83cf7feb086f5c85003392f4d5a318")!
        let dataTask = session.dataTask(with: weatherURL) {
            (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                print("Error:\n\(error)")
            } else {
                if let data = data {
                    let dataString = String(data: data, encoding: String.Encoding.utf8)
                    print("All the weather data:\n\(dataString!)")
                    if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
                        if let mainDictionary = jsonObj!.value(forKey: "main") as? NSDictionary {
                            if let temperature = mainDictionary.value(forKey: "temp") as? NSNumber{
                                DispatchQueue.main.async {
                                    DataContainerSingleton.sharedDataContainer.currentTemp = temperature.doubleValue
                                }
                            }
                        } else {
                            print("Error: unable to find temperature in dictionary")
                        }
                        if let cityName = jsonObj!.value(forKey: "name") as? String{
                            DispatchQueue.main.async {
                                DataContainerSingleton.sharedDataContainer.city = cityName
                            }
                        }
                    } else {
                        print("Error: unable to convert json data")
                    }
                } else {
                    print("Error: did not receive data")
                }
            }
        }
        dataTask.resume()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "MainViewController")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
