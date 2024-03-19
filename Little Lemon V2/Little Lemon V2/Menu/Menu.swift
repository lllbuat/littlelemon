//
//  Menu.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 1/3/2024.
//

import SwiftUI

struct Menu: View {
    @ObservedObject var dishesModel = DishesModel()
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var searchText = ""
    @State var selectedCategory = ""
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                VStack {
                    Text("Little Lemon")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(Font(Fonts.DisplayTitle))
                        .foregroundStyle(Colors.Yellow)
//                        .background(Color.gray)
                    
                    Text("Chicago")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(Font(Fonts.Subtitle))
                        .foregroundStyle(.white)
//                        .background(Color.colorLightGray)
                        .offset(y: -20)
                }
                
                HStack {
                    Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .font(Font(Fonts.HighlightText))
                        .foregroundStyle(.white)
                    
                    Image("hero-image")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 150, alignment: .center)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        
                }
//                .background(Color.green)
                .offset(y: -20)
                
                SearchBar(fontToUse: Fonts.CardTitle, searchText: $searchText)
                    .padding([.top], 10)
                    .offset(y: -20)
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
                        Button("All") { selectedCategory = "" }
                        Button("Starters") { selectedCategory = "starters" }
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
                
                Divider()

            }
            .padding(.init(top: 10, leading: 10, bottom: 0, trailing: 10))
                              
            VStack {
                NavigationView {
                    FetchedObjects(predicate:buildPredicate(),
                                   sortDescriptors: buildSortDescriptors()) {
                        (dishes: [Dish]) in
//                        let _ = print("FetchObjects \(dishes.count)")
                        List {
                            // Code for the list enumeration here
                            ForEach(dishes, id: \.self) { dish in
                                MenuItemView(dish)
                            }
                        }
                        .listStyle(.plain)
//                        .searchable(text: $searchText)
                    }
                }
            }
            .padding(.init(top: 0, leading: 15, bottom: 0, trailing: 15))
        }
        .task {
            await dishesModel.reload(viewContext)
        }
    }
    
    func buildPredicate() -> NSPredicate {
        if (searchText == "") && (selectedCategory == "") {
            return NSPredicate(value: true)
        } else if (searchText == "")  {
            return NSPredicate(format: "category == %@", selectedCategory)
        } else if (selectedCategory == "") {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        } else {
            return NSPredicate(format: "(title CONTAINS[cd] %@) && (category == %@)", searchText, selectedCategory)
        }
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title",
                                 ascending: true,
                                 selector: #selector(NSString .localizedStandardCompare))]
    }
    
    
}

//#Preview {
//    Menu()
//}
