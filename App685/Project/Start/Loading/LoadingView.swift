//
//  LoadingView.swift
//  App685
//
//  Created by IGOR on 28/06/2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack(spacing: 35) {
                
                Image("llogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180)
            }
            
            VStack {
                
                Spacer()
                
                ProgressView()
                    .padding(90)
            }
        }
    }
}

#Preview {
    LoadingView()
}
