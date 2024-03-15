//
//  MenuItemView.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 15/3/2024.
//

import SwiftUI

struct MenuItemView: View {
    @ObservedObject private var dish: Dish
    
    init(_ dish:Dish) {
        self.dish = dish
    }
    
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 8) {
                Text(self.dish.title ?? "")
                    .font(Font(Fonts.CardTitle))
                    .foregroundStyle(Colors.DarkGray)
                    .padding([.top, .bottom], 7)
                
                Text(self.dish.dishDescription ?? "")
                    .font(Font(Fonts.ParagraphText))
                    .foregroundStyle(Colors.DarkGreen)
                
                Text(self.dish.getPrice())
                    .font(Font(Fonts.HighlightText))
                    .foregroundStyle(Colors.DarkGreen)
            }
            
            Spacer()
            
            AsyncImage(url: URL(string: self.dish.image ?? "")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 80, height: 80)
            .aspectRatio(contentMode: .fit)
        }
//        .contentShape(Rectangle())
    }
}

//#Preview {
//    
//    MenuItemView()
//}

struct MenuItemView_Previews: PreviewProvider {
    static let context = PersistenceController.shared.container.viewContext
    let dish = Dish(context: context)
    static var previews: some View {
        MenuItemView(oneDish())
    }
    static func oneDish() -> Dish {
        let dish = Dish(context: context)
        dish.title = "Greek Salad"
        dish.price = "10"
        dish.image = "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/greekSalad.jpg?raw=true"
        dish.dishDescription = "The famous greek salad of crispy lettuce, peppers, olives, our Chicago."
        dish.category = "starters"
        dish.id = 1
        return dish
    }
}
