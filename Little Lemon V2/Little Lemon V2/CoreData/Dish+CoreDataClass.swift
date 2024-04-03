//
//  Dish+CoreDataClass.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 16/3/2024.
//
//

import Foundation
import CoreData

@objc(Dish)
public class Dish: NSManagedObject {
    
    func getPrice() -> String {
        let newPrice = price ?? "0"
        return "$" + newPrice
    }
    
}
