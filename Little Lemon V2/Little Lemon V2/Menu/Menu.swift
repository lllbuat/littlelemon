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
            
            NavigationView {
                FetchedObjects(predicate:buildPredicate(),
                               sortDescriptors: buildSortDescriptors()) {
                        (dishes: [Dish]) in
                        let _ = print("FetchObjects \(dishes.count)")
                        List {
                            // Code for the list enumeration here
                            ForEach(dishes, id: \.self) { dish in
                                MenuItemView(dish)
                            }
                        }
//                        .searchable(text: $searchText,
//                                    prompt: "Search...")
                    }
            }
        }
        .task {
            await dishesModel.reload(viewContext)
        }
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

//#Preview {
//    Menu()
//}
