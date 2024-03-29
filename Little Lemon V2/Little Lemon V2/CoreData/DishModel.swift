//
//  DishModel.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 16/3/2024.
//

import Foundation
import CoreData

@MainActor
class DishesModel: ObservableObject {
    
    @Published var menuItems = [MenuItem]()
    static var isRunning = false
    
    func reload(_ coreDataContext:NSManagedObjectContext) async {
//        print("reload \(DishesModel.isRunning)")
        
        // prevent task running twice
        if DishesModel.isRunning {
            return
        }
        
        Dish.deleteAll(coreDataContext)
        
        DishesModel.isRunning = true
        
        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!
        let urlSession = URLSession.shared
        
        do {
            let (data, _) = try await urlSession.data(from: url)
            let fullMenu = try JSONDecoder().decode(MenuList.self, from: data)
            menuItems = fullMenu.menu
                        
            // populate Core Data
//            Dish.deleteAll(coreDataContext)
            Dish.createDishesFrom(menuItems:menuItems, coreDataContext)
        } catch (let error){
            print(error.localizedDescription)
        }
        
        DishesModel.isRunning = false
//        print("reload ended \(DishesModel.isRunning)")
    }
}
