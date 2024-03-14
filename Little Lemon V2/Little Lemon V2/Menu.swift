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
            VStack(spacing: 0) {
                VStack {
                    Text("Little Lemon")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(Font(Fonts.DisplayTitle))
                        .foregroundStyle(Colors.Yellow)
                    
                    Text("Chicago")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(Font(Fonts.Subtitle))
                        .foregroundStyle(.white)
                        .offset(y: -20)
                }
                
                HStack {
                    Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(Font(Fonts.HighlightText))
                        .foregroundStyle(.white)
                    
                    Image("hero-image")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120, alignment: .center)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        
                }
                .offset(y: -35)
            }
            .padding(.init(top: 10, leading: 10, bottom: 0, trailing: 10))
            .background(Colors.DarkGreen)
            
            VStack {
                Text("Order for Delivery!")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .textCase(.uppercase)
                    .font(Font(Fonts.SectionTitle))
                       
                HStack {
                    Group {
                        Button("Starters") {}
                        Button("Main") {}
                        Button("Desserts") {}
                        Button("Drinks") {}
                    }
                    .padding([.top, .bottom], 10)
                    .padding([.leading, .trailing], 15)
                    .font(Font(Fonts.SectionCategory))
                    .foregroundColor(Colors.DarkGreen)
                    .background(Colors.VeryLightGray)
                    .cornerRadius(15)
                }

            }
            .padding(.init(top: 10, leading: 10, bottom: 0, trailing: 10))
            
            
            
//            TextField("Search Menu", text: $searchText)
//                    .padding([.leading, .trailing], 20)

            
//            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
//                List{
//                    
//                    ForEach(dishes, id: \.self) { dish in
//                        HStack {
//                            let text = (dish.title ?? "") + " $" + (dish.price ?? "")
//                            Text(text)
//                                .padding([.top, .bottom], 7)
//                            
//                            Spacer()
//                            
//                            AsyncImage(url: URL(string: dish.image!)) { image in
//                                image.resizable()
//                            } placeholder: {
//                                ProgressView()
//                            }
//                            .frame(width: 80, height: 80)
//                        }
//                    }
//                }
//            }

        }
        .onAppear {
//            getMenuData()
        }
    }
    
    func getMenuData() {
        print("getMenuData 1 ", Dish.countRecords(context))
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
