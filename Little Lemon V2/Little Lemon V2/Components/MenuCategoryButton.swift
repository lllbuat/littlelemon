//
//  MenuCategoryButton.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 21/3/2024.
//

import SwiftUI

struct MenuCategoryButton: View {
    @Binding var selectedCategory: String
    var category: String = ""
    private var isActive: Bool = false
    
    init(selectedCategory: Binding<String>, category: String) {
        self._selectedCategory = selectedCategory
        self.category = category
        self.isActive = (self.selectedCategory == self.category.lowercased())
    }
    
    var body: some View {
        HStack {
            Text(category)
            if (self.selectedCategory == category.lowercased()) {
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
            if (self.selectedCategory == category.lowercased()) {
                self.selectedCategory = ""
            } else {
                self.selectedCategory = category.lowercased()
            }
            
//            print(self.isActive, self.selectedCategory, self.category)
        }
    }
}

#Preview {
    MenuCategoryButton(selectedCategory: .constant(""), category: "Starters")
}
