//
//  MenuItem.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 4/3/2024.
//

import Foundation

struct MenuItem: Decodable {
    let title: String
    let image: String
    let price: String
    
    let description: String
    let category: String
    let id: Int
}
