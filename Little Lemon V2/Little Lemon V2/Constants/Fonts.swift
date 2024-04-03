//
//  Fonts.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 12/3/2024.
//

import Foundation
import SwiftUI

struct Fonts {
    static let KarlaRegular: String = "Karla-Regular"
    static let KarlaMedium: String = "Karla-Regular_Medium"
    static let KarlaBold: String = "Karla-Regular_Bold"
    static let KarlaExtraBold: String = "Karla-Regular_ExtraBold"
    
    static let MarkaziTextRegular: String = "MarkaziText-Regular"
    static let MarkaziTextMedium: String = "MarkaziText-Medium"
    
    static let DisplayTitle: UIFont = UIFont(name: MarkaziTextMedium, size: 64) ?? UIFont.systemFont(ofSize: 64)
    static let Subtitle: UIFont = UIFont(name: MarkaziTextRegular, size: 40) ?? UIFont.systemFont(ofSize: 40)
    
    static let LeadText: UIFont = UIFont(name: KarlaMedium, size: 18) ?? UIFont.systemFont(ofSize: 18)
    static let SectionTitle: UIFont = UIFont(name: KarlaExtraBold, size: 20) ?? UIFont.systemFont(ofSize: 20)
    static let SectionCategory: UIFont = UIFont(name: KarlaExtraBold, size: 16) ?? UIFont.systemFont(ofSize: 16)
    static let CardTitle: UIFont = UIFont(name: KarlaBold, size: 18) ?? UIFont.systemFont(ofSize: 18)
    static let ParagraphText: UIFont = UIFont(name: KarlaRegular, size: 16) ?? UIFont.systemFont(ofSize: 16)
    static let HighlightText: UIFont = UIFont(name: KarlaMedium, size: 16) ?? UIFont.systemFont(ofSize: 16)
}
