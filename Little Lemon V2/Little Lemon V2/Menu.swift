//
//  Menu.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 1/3/2024.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var context
    
    @State var searchText = ""
    
    var body: some View {
        VStack{
            Text("Little Lemon")
            Text("Chicago")
            Text("Just a description")
  
            
            TextField("Search Menu", text: $searchText)
                .padding([.leading, .trailing], 20)
            
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List{
                    
                    ForEach(dishes, id: \.self) { dish in
                        HStack {
                            let text = (dish.title ?? "") + " $" + (dish.price ?? "")
                            Text(text)
                                .padding([.top, .bottom], 7)
                            
                            Spacer()
                            
                            AsyncImage(url: URL(string: dish.image!)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 80, height: 80)
                        }
                    }
                }
            }

        }
        .onAppear {
            getMenuData()
        }
    }
    
    func getMenuData() {
//        PersistenceController.shared.clear()
        print("getMenuData 1 ", Dish.countRecords(context))
//        Dish.deleteAll(context)
//        PersistenceController.shared.clear()
        print("getMenuData 2 ", Dish.countRecords(context))
        
        let urlStr = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: urlStr)!
        let urlRequest = URLRequest(url: url)
        let urlSession = URLSession.shared
        
        do {
            let dataSessionTask = urlSession.dataTask(with: urlRequest) {data,response,error in
                if let data = data {
                    if let fullMenu = try? JSONDecoder().decode(MenuList.self, from: data) {
                        
                        // populate Core Data
                        Dish.createDishesFrom(menuItems:fullMenu.menu, context)
                        print("getMenuData 3 ", Dish.countRecords(context))
//
//                        for item in fullMenu.menu {
//                            let dish = Dish(context: viewContext)
//                            dish.title = item.title
//                            dish.price = item.price
//                            dish.image = item.image
//                            dish.dishDescription = item.description
//                            dish.category = item.category
//                            dish.id = Int64(item.id)
//                        }
//                        guard viewContext.hasChanges else { return }
//                        try? viewContext.save()
                    }
                }
            }
            dataSessionTask.resume()
        }   catch {}
    }
    
    func buildPredicate() -> NSPredicate {
        return searchText == "" ? NSPredicate(value: true) :  NSPredicate(format: "title CONTAINS[cd] %@", searchText)
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title",
                                 ascending: true,
                                 selector: #selector(NSString .localizedStandardCompare))]
    }
    
    
}

#Preview {
    Menu()
}
