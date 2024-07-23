//
//  TabBar.swift
//  App685
//
//  Created by IGOR on 28/06/2024.
//

import SwiftUI

struct TabBar: View {
    
    @Binding var selectedTab: Tab
    
    var body: some View {
        
        HStack {
            
            ForEach(Tab.allCases, id: \.self) { index in
                
                Button(action: {
                    
                    selectedTab = index
                    
                }, label: {
                    
                    VStack(alignment: .center, spacing: 8, content: {
                        
                        Image(index.rawValue)
                            .renderingMode(.template)
                            .foregroundColor(selectedTab == index ? .white : Color("prim"))
                            .frame(width: 25, height: 25)
                            .padding()
                            .background(Circle().fill(selectedTab == index ? Color("bg2") : Color("bg")))
                        
                    })
                    .frame(maxWidth: .infinity)
                })
            }
        }
        .frame(width: 200)
        .padding(8)
        .background(RoundedRectangle(cornerRadius: 50).fill(Color.gray.opacity(0.2)))
    }
}

enum Tab: String, CaseIterable {
    
    case Home = "Home"
    
    case Orders = "Orders"
                
    case Stock = "Stock"
    
}
