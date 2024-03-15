//
//  TempSample.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 13/3/2024.
//

import SwiftUI
import PhotosUI

struct TempSample: View {
    @ObservedObject var dishesModel = DishesModel()
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var test: String = ""
    //
    //    @State private var avatarItem: PhotosPickerItem?
    //    @State private var avatarImage: Image?
    //
    //    let myFont = Font(Fonts.DisplayTitle).leading(.tight)
    
    let meals = ["bread","milk","burger","fries","fish","veggies"]
    
    var body: some View {
        VStack {
            Text("Hello")
            
            NavigationView {
                FetchedObjects() {
                        (dishes: [Dish]) in
                        let _ = print("FetchObjects \(dishes.count)")
                        List {
                            // Code for the list enumeration here
                            ForEach(dishes, id: \.self) { dish in
                                MenuItemView(dish)
                            }
                        }
                    }
            }
        }
        .task {
            await dishesModel.reload(viewContext)
        }
        
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
        
        //        NavigationStack {
        //            List {
        //                ForEach(meals, id: \.self) { meal in
        //                   Text(meal)
        //                }
        //                .listRowSeparator(.hidden,
        //                                  edges: .all)
        //            }
        //            .listStyle(.plain)
        //            .navigationTitle("Find Your Next Meal")
        //            .searchable(text: $test)
        //
        
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
}
    


#Preview {
    TempSample()
}
