//
//  SettingsView.swift
//  App685
//
//  Created by IGOR on 28/06/2024.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    
    @Environment(\.presentationMode) var router

    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack(spacing: 15) {
                
                Text("Settings")
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .regular))
                
                HStack {
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            router.wrappedValue.dismiss()
                        }
                        
                    }, label: {
                        
                        HStack {
                            
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color("bg2"))
                                .font(.system(size: 17, weight: .medium))
                            
                            Text("Back")
                                .foregroundColor(Color("bg2"))
                                .font(.system(size: 16, weight: .regular))
                        }
                    })
                    
                    Spacer()
                }
                .padding(.bottom)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 15) {
                        
                        Button(action: {
                            
                            guard let url = URL(string: "https://www.termsfeed.com/live/6dac73c4-3ffb-4668-8759-caca6d12dc41") else { return }
                            
                            UIApplication.shared.open(url)
                            
                        }, label: {
                            
                            HStack {
                                
                                Image(systemName: "doc.text.fill")
                                    .foregroundColor(Color("bg2"))
                                    .font(.system(size: 16, weight: .regular))
                                    .padding(.horizontal)
                                
                                Text("Usage Policy")
                                    .foregroundColor(.black)
                                    .font(.system(size: 15, weight: .medium))
                                
                                Spacer()
                                
                                Image(systemName: "arrow.up.right")
                                    .foregroundColor(.black)
                                    .font(.system(size: 13, weight: .regular))
                                    .padding()
                                    .background(Circle().fill(.gray.opacity(0.15)))
                            }
                            .padding(9)
                            .background(RoundedRectangle(cornerRadius: 25).fill(.white))
                        })
                        
                        Button(action: {
                            
                            SKStoreReviewController.requestReview()
                            
                        }, label: {
                            
                            HStack {
                                
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color("bg2"))
                                    .font(.system(size: 16, weight: .regular))
                                    .padding(.horizontal)
                                
                                Text("Rate app")
                                    .foregroundColor(.black)
                                    .font(.system(size: 15, weight: .medium))
                                
                                Spacer()
                                
                                Image(systemName: "arrow.up.right")
                                    .foregroundColor(.black)
                                    .font(.system(size: 13, weight: .regular))
                                    .padding()
                                    .background(Circle().fill(.gray.opacity(0.15)))
                            }
                            .padding(9)
                            .background(RoundedRectangle(cornerRadius: 25).fill(.white))
                        })
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    SettingsView()
}
