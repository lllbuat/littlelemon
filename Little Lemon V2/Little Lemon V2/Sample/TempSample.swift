//
//  TempSample.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 13/3/2024.
//

import SwiftUI
import PhotosUI

struct TempSample: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var test: String = ""
    @State private var selectedCategory: String = ""
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                MenuCategoryButton(selectedCategory: $selectedCategory,
                             category: "Starters")
                MenuCategoryButton(selectedCategory: $selectedCategory,
                             category: "Mains")
                MenuCategoryButton(selectedCategory: $selectedCategory,
                             category: "Desserts")
                MenuCategoryButton(selectedCategory: $selectedCategory,
                             category: "Drinks")
            }
        }
    }
}
    


#Preview {
    TempSample()
}
