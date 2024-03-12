//
//  Temp.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 11/3/2024.
//

import SwiftUI

struct FontFamilySample: View {
    let fontsToSample: [UIFont] = [Fonts.DisplayTitle,
                                   Fonts.Subtitle,
                                   Fonts.LeadText,
                                   Fonts.SectionTitle,
                                   Fonts.SectionCategory,
                                   Fonts.CardTitle,
                                   Fonts.ParagraphText,
                                   Fonts.HighlightText]
    
    var body: some View {
        VStack {
            Text("Hello, World!")
            
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .monospaced()
            
            List {
                ForEach(fontsToSample, id: \.self) { sample in
                    Text(sample.fontName)
                        .font(Font(sample))
                }
            }
            
            List {
                ForEach(UIFont.familyNames, id: \.self) { family in
                    if (family == "Karla") || (family == "Markazi Text") {
//                    if family.starts(with: "M") {
                        Section(header: Text(family)) {
                            ForEach(UIFont.fontNames(forFamilyName: family), id: \.self) { font in
                                Text(font)
                                    .font(.custom(font, size: 20))
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    FontFamilySample()
}
