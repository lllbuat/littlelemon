//
//  MenuViewV2.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 5/4/2024.
//

import SwiftUI

struct MenuViewV2: View {
    static let tag = ViewTags.MenuViewV2
                
    @ObservedObject var dishesModel = DishesModel()
    @ObservedObject var memberProfile: MemberProfileModel
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var searchText = ""
    @State var selectedCategory = ""
    
    var ls_menuCategories = ["Starters", "Mains", "Desserts", "Drinks"]
    
    var body: some View {
        VStack {
            HeroSectionView()
                .frame(maxHeight: 300)
            
            SearchBarView(fontToUse: Fonts.CardTitle, searchText: $searchText)
                .padding(10)
                .background(Colors.DarkGreen)
                .offset(y: -20)
                        
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
//    MenuViewV2()
//}
