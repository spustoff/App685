//
//  Reviews.swift
//  App685
//
//  Created by IGOR on 28/06/2024.
//

import SwiftUI
import StoreKit

struct Reviews: View {
    var body: some View {

        ZStack {
            
            Color("bg2")
                .ignoresSafeArea()
            
            VStack {
                
                VStack(spacing: 15) {
                    
                    Text("Rate us in the AppStore")
                        .foregroundColor(.white)
                        .font(.system(size: 34, weight: .medium))
                        .padding(.top, 50)
                    
                    Text("Make the app better")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .regular))
                    
                }
                
                Spacer()
                
                NavigationLink(destination: {
                    
                    Not()
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
                
                Image("Reviews")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .onAppear {
            
            SKStoreReviewController.requestReview()
        }
    }
}

#Preview {
    Reviews()
}
