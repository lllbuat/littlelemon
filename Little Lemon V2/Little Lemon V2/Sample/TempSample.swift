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
    
    var body: some View {
        VStack {
            SearchBar(fontToUse: Fonts.ParagraphText, searchText: $test)
//                .background(RoundedCorner(radius: 5).fill(.gray))
//            Text(test)
        }
    }
}
    


#Preview {
    TempSample()
}
