//
//  Not.swift
//  App685
//
//  Created by IGOR on 28/06/2024.
//

import SwiftUI

struct Not: View {
    
    @AppStorage("status") var status: Bool = false

    var body: some View {

        ZStack {
            
            Color("bg2")
                .ignoresSafeArea()
            
            VStack {
                
                VStack(spacing: 15) {
                    
                    Text("Don't miss anything!")
                        .foregroundColor(.white)
                        .font(.system(size: 34, weight: .medium))
                        .padding(.top, 50)
                    
                    Text("Get the most up-to-date information")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .regular))
                    
                }
                
                Spacer()
                
                Button(action: {
                    
                    status = true
                    
                }, label: {
                    
                    Text("Enable Notifications")
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
                
                Image("Not")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            VStack {
                
                Button(action: {
                    
                    status = true
                    
                }, label: {
                    
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .semibold))
                        .padding(5)
                        .background(Circle().fill(.white.opacity(0.3)))
                })
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal)
                
                Spacer()
            }
        }
    }
}

#Preview {
    Not()
}
