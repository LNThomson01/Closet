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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    @IBAction func temperatureSlider(_ sender: UISlider) {
        let currentValue = Int(temperatureSliderOutlet.value)
        degreesLabel.text = "\(currentValue) Degrees F"
    }
    
}

