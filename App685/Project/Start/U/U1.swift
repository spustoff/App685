//
//  U1.swift
//  App685
//
//  Created by IGOR on 28/06/2024.
//

import SwiftUI

struct U1: View {
    var body: some View {

        ZStack {
            
            Color("bg2")
                .ignoresSafeArea()
            
            VStack {
                
                VStack(spacing: 15) {
                    
                    Text("Fulfill your dreams")
                        .foregroundColor(.white)
                        .font(.system(size: 34, weight: .medium))
                        .padding(.top, 50)
                    
                    Text("Become popular and rich")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .regular))
                    
                }
                
                Spacer()
                
                NavigationLink(destination: {
                    
                    Reviews()
                        .navigationBarBackButtonHidden()
                    
                }, label: {
                    
                    Text("Next")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .regular))
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(RoundedRectangle(cornerRadius: 25).fill(Color("prim")))
                })
                .padding(.bottom)
            }
            .padding()
            .ignoresSafeArea()
            
            VStack {
                
                Image("U1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
}

#Preview {
    U1()
}
