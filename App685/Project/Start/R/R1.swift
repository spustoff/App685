//
//  R1.swift
//  App685
//
//  Created by IGOR on 28/06/2024.
//

import SwiftUI

struct R1: View {
    var body: some View {

        ZStack {
            
            Color("bg2")
                .ignoresSafeArea()
            
            VStack {
                
                VStack(spacing: 15) {
                    
                    Text("Process control")
                        .foregroundColor(.white)
                        .font(.system(size: 34, weight: .medium))
                        .padding(.top, 60)
                    
                    Text("Order history and income counter")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .regular))
                    
                }
                
                Spacer()
                
                VStack {
                    
                    Spacer()
                    
                    NavigationLink(destination: {
                        
                        R2()
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
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg")))
                
            }
            .ignoresSafeArea()
            
            VStack {
                
                Image("R1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
}

#Preview {
    R1()
}
