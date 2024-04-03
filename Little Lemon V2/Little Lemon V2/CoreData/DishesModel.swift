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
    private var menuItems = [MenuItem]()
    
    @Published var debugMsg: String = "Debug-"
    
    public func fetchData(_ coreDataContext:NSManagedObjectContext) async {
        let itemCount = Dish.countRecords(coreDataContext)
        debugMsg = debugMsg + String(itemCount)
        
        guard itemCount > 0 else {
            let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!
            let urlSession = URLSession.shared
            
            do {
                let (data, _) = try await urlSession.data(from: url)
                let fullMenu = try JSONDecoder().decode(MenuList.self, from: data)
                self.menuItems = fullMenu.menu
                
                // populate Core Data
                //            Dish.deleteAll(coreDataContext)
                Dish.createDishesFrom(menuItems:menuItems, coreDataContext)
            } catch (let error){
//                print(error.localizedDescription)
            }
            
            return
        }
    }
}
