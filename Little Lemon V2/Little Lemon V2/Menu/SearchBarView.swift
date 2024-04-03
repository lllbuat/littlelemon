//
//  SearchBar.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 19/3/2024.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
        
    private let fontToUse: UIFont
    
    init(fontToUse: UIFont, searchText: Binding<String>) {
        self.fontToUse = fontToUse
        self._searchText = searchText
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .strokeBorder(Colors.DarkGray, style: StrokeStyle(lineWidth: 0.5))
                .fill(Colors.LightGray)
                .frame(maxWidth: .infinity, maxHeight: self.fontToUse.pointSize * 2)
            
            HStack {
                Image(systemName: "magnifyingglass").foregroundStyle(Colors.DarkGreen)
                TextField("Search", text: $searchText)
            }
            .padding([.leading, .trailing], 10)
            .font(Font(self.fontToUse))
            .foregroundStyle(Colors.DarkGreen)
        }
    }
}

#Preview {
    SearchBarView(fontToUse: Fonts.CardTitle, searchText: .constant("hello"))
}
