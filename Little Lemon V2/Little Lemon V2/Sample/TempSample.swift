//
//  TempSample.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 13/3/2024.
//

import SwiftUI
import PhotosUI

struct TempSample: View {
    @State private var test: String = ""
//    
//    @State private var avatarItem: PhotosPickerItem?
//    @State private var avatarImage: Image?
//    
//    let myFont = Font(Fonts.DisplayTitle).leading(.tight)
    
    let meals = ["bread","milk","burger","fries","fish","veggies"]
    
    var body: some View {
//        VStack {
//            Button("Change") {
//                // open photo library to select image
//            }
//            
//            avatarImage?
//                .resizable()
//                .scaledToFit()
//                .frame(width: 300, height: 300)
//        }

        NavigationStack {
            List {
                ForEach(meals, id: \.self) { meal in
                   Text(meal)
                }
//                .listRowSeparator(.hidden,
//                                  edges: .all)
            }
//            .listStyle(.plain)
            .navigationTitle("Find Your Next Meal")
            .searchable(text: $test)
            
        }
        
//        VStack {
//            TextField(test, text: $test)
//                .font(Font(Fonts.ParagraphText))
//                .foregroundStyle(Colors.DarkGray)
//                .padding(10)
//                .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Colors.DarkGray, style: StrokeStyle(lineWidth: 0.5)))
//        }
//        .padding([.top, .bottom], 10)
//        .padding([.leading, .trailing], 20)
    }
    
    func getData() async {
//        var menuItems = [MenuItem]()
        
        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!
        let urlSession = URLSession.shared
        
        do {
            let (data, resp) = try await urlSession.data(from: url)
            print(data)
//            let fullMenu = try JSONDecoder().decode(JSONMenu.self, from: data)
//            menuItems = fullMenu.menu
                        
            // populate Core Data
//            Dish.deleteAll(coreDataContext)
//            Dish.createDishesFrom(menuItems:menuItems, coreDataContext)
        } catch (let error){
            print(error.localizedDescription)
        }
        
    }
}

//struct JSONMenu: Codable {
//    let menu: [MenuItem]
//    
//    enum CodingKeys: String, CodingKey {
//        case menu = "menu"
//    }
//}

//struct MenuItem: Decodable {
//    let title: String
//    let image: String
//    let price: String
//    
//    let description: String
//    let category: String
//    let id: Int
//}
//


#Preview {
    TempSample()
}
