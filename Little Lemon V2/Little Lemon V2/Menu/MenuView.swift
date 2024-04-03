//
//  Menu.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 1/3/2024.
//

import SwiftUI

struct MenuView: View {
    static let tag = ViewTags.MenuView
    @Binding var path: NavigationPath
                
    @ObservedObject var dishesModel = DishesModel()
    @ObservedObject var memberProfile: MemberProfileModel
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var searchText = ""
    @State var selectedCategory = ""
    
//    @FetchRequest(sortDescriptors: []) private var todos: FetchedResults<Dish>
    
    var ls_menuCategories = ["Starters", "Mains", "Desserts", "Drinks"]
    
    var body: some View {
        VStack {
//            Text(dishesModel.debugMsg)
            
            NavBarView(path: $path, memberProfile: memberProfile, showBackBtn: false)
            
            HeroSectionView()
                .frame(maxHeight: 300)
            
            SearchBarView(fontToUse: Fonts.CardTitle, searchText: $searchText)
                .padding(10)
                .background(Colors.DarkGreen)
                .offset(y: -20)
            
            
//            VStack(spacing: 0) {
//                VStack {
//                    Text("Little Lemon")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .font(Font(Fonts.DisplayTitle))
//                        .foregroundStyle(Colors.Yellow)
//                    
//                    Text("Chicago")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .font(Font(Fonts.Subtitle))
//                        .foregroundStyle(.white)
//                        .offset(y: -20)
//                }
//                
//                HStack {
//                    Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
//                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
//                        .font(Font(Fonts.HighlightText))
//                        .foregroundStyle(.white)
//                    
//                    Image("hero-image")
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 120, height: 150, alignment: .center)
//                        .clipped()
//                        .clipShape(RoundedRectangle(cornerRadius: 15))
//                    
//                }
//                .offset(y: -20)
//                
//                SearchBarView(fontToUse: Fonts.CardTitle, searchText: $searchText)
//                    .padding([.top], 10)
//                    .offset(y: -20)
//            }
//            .padding(.init(top: 10, leading: 10, bottom: 0, trailing: 10))
//            .background(Colors.DarkGreen)
            
            VStack {
                Text("Order for Delivery!")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .textCase(.uppercase)
                    .font(Font(Fonts.SectionTitle))
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(ls_menuCategories, id: \.self) { cat in
                            MenuCategoryButton(selectedCategory: $selectedCategory,
                                               category: cat)
                        }
                    }
                }
                
                Divider()
                
            }
            .padding(.init(top: 10, leading: 10, bottom: 0, trailing: 10))
            
            VStack {
                FetchedObjects(predicate:buildPredicate(),
                               sortDescriptors: buildSortDescriptors()) {
                    (dishes: [Dish]) in
                    if dishes.count == 0 {
                        Text("None matches criteria")
                            .font(Font(Fonts.HighlightText))
                            .foregroundStyle(Colors.DarkGray)
                            .padding(10)
                    } else {
                        List {
                            // Code for the list enumeration here
                            ForEach(dishes, id: \.self) { dish in
//                                let _ = print("ForEach ", dish.title ?? "")
                                MenuItemView(dish)
                            }
                        }
                        .listStyle(.plain)
                    }
                }
            }
            .padding(.init(top: 0, leading: 15, bottom: 0, trailing: 15))
            
            Spacer()
        }
//        .onAppear() {
//            let _ = print(String(Dish.countRecords(viewContext)))
//        }
        .task {
            await dishesModel.fetchData(viewContext)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func buildPredicate() -> NSPredicate {
        if (self.searchText == "") && (self.selectedCategory == "") {
            return NSPredicate(value: true)
        } else if (self.searchText == "")  {
            return NSPredicate(format: "category == %@", self.selectedCategory)
        } else if (self.selectedCategory == "") {
            return NSPredicate(format: "title CONTAINS[cd] %@", self.searchText)
        } else {
            return NSPredicate(format: "(title CONTAINS[cd] %@) && (category == %@)", self.searchText, self.selectedCategory)
        }
    }
    
    private func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title",
                                 ascending: true,
                                 selector: #selector(NSString .localizedStandardCompare))]
    }

}



//#Preview {
//    Menu()
//}
