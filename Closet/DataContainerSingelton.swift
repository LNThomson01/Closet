//
//  DataContainerSingleton.swift
//  Closet
//
//  Created by Lindsey Thomson on 11/25/17.
//  Copyright © 2017 Lindsey Thomson. All rights reserved.
//

import Foundation
import CoreData



class DataContainerSingleton {
    
    static let sharedDataContainer = DataContainerSingleton()

    //objects shared across the app
//    var topsObject: [NSManagedObject] = []
//    var bottomsObject: [NSManagedObject] = []
//    var shoesObject: [NSManagedObject] = []
//    var dressesObject: [NSManagedObject] = []
    
    var pieceOfClothingObject: [NSManagedObject] = []
    var currentTemp: Double = 0
    
}
