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
                       
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Button("Starters") {
                            toggleSelectedCategory("starters")
                        }
                        .buttonStyle(MenuCategoryButtonStyle(isActive: (self.selectedCategory == "starters")))
                        
                        Button("Mains") {
                            toggleSelectedCategory("mains")
                        }
                        .buttonStyle(MenuCategoryButtonStyle(isActive: (self.selectedCategory == "mains")))
                        
                        Button("Desserts") {
                            toggleSelectedCategory("desserts")
                        }
                        .buttonStyle(MenuCategoryButtonStyle(isActive: (self.selectedCategory == "desserts")))
                        
                        Button("Drinks") {
                            toggleSelectedCategory("drinks")
                        }
                        .buttonStyle(MenuCategoryButtonStyle(isActive: (self.selectedCategory == "drinks")))
                    }
                }
                
                Divider()

            }
            .padding(.init(top: 10, leading: 10, bottom: 0, trailing: 10))
                              
            VStack {
                NavigationView {
                    FetchedObjects(predicate:buildPredicate(),
                                   sortDescriptors: buildSortDescriptors()) {
                        (dishes: [Dish]) in
                        List {
                            // Code for the list enumeration here
                            ForEach(dishes, id: \.self) { dish in
                                MenuItemView(dish)
                            }
                        }
                        .listStyle(.plain)
                    }
                }
            }
            .padding(.init(top: 0, leading: 15, bottom: 0, trailing: 15))
        }
//        .task {
//            await dishesModel.reload(viewContext)
//        }
    }
    
    private func buildPredicate() -> NSPredicate {
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
    
    private func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title",
                                 ascending: true,
                                 selector: #selector(NSString .localizedStandardCompare))]
    }
    
    private func toggleSelectedCategory(_ category: String) {
        let ls_category = ["starters", "mains", "desserts","drinks"]
        if self.selectedCategory == category {
            // deselect
            self.selectedCategory = ""
        } else if ls_category.contains(category) {
            self.selectedCategory = category
        } else {
            self.selectedCategory = ""
        }
        print("current selected category: ", self.selectedCategory)
    }
    
    
}



#Preview {
    Menu()
}
