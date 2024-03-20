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
                SampleButton(category: "Starters")
                SampleButton(category: "Mains")
                SampleButton(category: "Desserts")
                SampleButton(category: "Drinks")
            }
        }
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
//        print("current selected category: ", self.selectedCategory)
    }
}
    


#Preview {
    TempSample()
}


struct MenuCategoryButtonStyle: ButtonStyle {
    var isActive = false
    
    func makeBody(configuration: Configuration) -> some View {
        
        configuration.label
            .padding([.top, .bottom], 10)
            .padding([.leading, .trailing], 15)
        
            .font(Font(Fonts.SectionCategory))
        
            .background(self.isActive ? Colors.DarkGreen : Colors.VeryLightGray)
            .foregroundColor(self.isActive ? Colors.VeryLightGray : Colors.DarkGreen)
        
            .cornerRadius(15)
//            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}

struct SampleButton: View {
    @State var isActive: Bool = false
//    @Binding var selectedCategory: String
    
    var category: String = ""
    
    var body: some View {
        HStack {
            Text(category)
            if self.isActive {
                Image(systemName: "xmark")
            }
        }
        .padding([.top, .bottom], 10)
        .padding([.leading, .trailing], 15)
        .font(Font(Fonts.SectionCategory))
        
        .background(self.isActive ? Colors.DarkGreen : Colors.VeryLightGray)
        .foregroundColor(self.isActive ? Colors.VeryLightGray : Colors.DarkGreen)
    
        .cornerRadius(15)
        
        .onTapGesture {
            self.isActive.toggle()
//            self.selectedCategory = category
        }
    }
}
