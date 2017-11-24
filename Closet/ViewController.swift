//
//  ViewController.swift
//  Closet
//
//  Created by Lindsey Thomson on 10/16/17.
//  Copyright © 2017 Lindsey Thomson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var degreesLabel: UILabel!
    @IBOutlet weak var temperatureSliderOutlet: UISlider!
    @IBOutlet weak var cloudySwitch: UISwitch!
    @IBOutlet weak var rainySwitch: UISwitch!
    @IBOutlet weak var windySwitch: UISwitch!
    @IBOutlet weak var snowySwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeather()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getWeather()
    {
        let session = URLSession.shared
        let weatherURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?id=4259418&units=imperial&appid=fb83cf7feb086f5c85003392f4d5a318")!
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
                            if let temperature = mainDictionary.value(forKey: "temp") {
                                DispatchQueue.main.async {
                                    self.degreesLabel.text = "\(temperature)°F"
                                }
                            }
                        } else {
                            print("Error: unable to find temperature in dictionary")
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
    
    //MARK: Actions
    @IBAction func temperatureSlider(_ sender: UISlider) {
        let currentValue = Int(temperatureSliderOutlet.value)
        degreesLabel.text = "\(currentValue) Degrees F"
    }
    
}

