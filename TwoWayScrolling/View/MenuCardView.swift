//
//  MenuCardView.swift
//  TwoWayScrolling
//
//  Created by Vikash Anand on 23/11/23.
//

import SwiftUI

struct MenuCardView: View {
    var tab: Tab
    @Binding var currentTab: String
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(tab.tab)
                .font(.title.bold())
                .padding(.vertical)
            
            ForEach(tab.foods) { food in
                //Food View
                HStack(spacing: 15) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(food.title)
                            .font(.title3.bold())
                        
                        Text(food.description)
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        Text("Price: \(food.price)")
                            .fontWeight(.bold)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(food.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 75, height: 75)
                        .cornerRadius(10)
                }
                
                Divider()
            }
        }
        .modifier(OffsetModifier(tab: tab, currentTab: $currentTab))
        //Setting id for scrollview reader...
        .id(tab.id)
    }
}

#Preview {
    Home()
}
