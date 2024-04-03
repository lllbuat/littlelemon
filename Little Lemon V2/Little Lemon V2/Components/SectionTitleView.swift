//
//  SectionTitleView.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 29/3/2024.
//

import SwiftUI

struct SectionTitleView: View {
    var title: String = ""
    var body: some View {
        Text(title)
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(Font(Fonts.CardTitle))
            .foregroundStyle(Colors.DarkGray)
    }
}

#Preview {
    SectionTitleView(title: "Hello")
}
