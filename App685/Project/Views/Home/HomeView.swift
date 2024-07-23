//
//  HomeView.swift
//  App685
//
//  Created by IGOR on 28/06/2024.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    @StateObject var flowerModel = StockViewModel()
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    Text("Welcome")
                        .foregroundColor(.black)
                        .font(.system(size: 28, weight: .regular))
                    
                    Spacer()
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isSettings = true
                        }
                        
                    }, label: {
                        
                        Image(systemName: "gear")
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .regular))
                            .padding(10)
                            .background(Circle().stroke(.gray))
                    })
                }
                
                VStack {
                
                HStack {
                    
                    VStack {
                        
                        VStack(alignment: .leading, spacing: 8) {
                            
                            Text("Total revenues:")
                                .foregroundColor(.black)
                                .font(.system(size: 14, weight: .regular))
                                .frame(width: 90)
                                                        
                            HStack {
                                
                                Text("$")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 22, weight: .bold))
                                
                                Text("\(viewModel.revenues)")
                                    .foregroundColor(.black)
                                    .font(.system(size: 22, weight: .bold))
                            }
                            
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(maxHeight: .infinity)
                        .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                        
                        VStack(alignment: .leading, spacing: 8) {
                            
                            Text("Orders sold:")
                                .foregroundColor(.black)
                                .font(.system(size: 14, weight: .regular))
                                .frame(width: 90)
                                                        
                            HStack {
                                
                                Text("$")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 22, weight: .bold))
                                
                                Text("\(viewModel.Numorders)")
                                    .foregroundColor(.black)
                                    .font(.system(size: 22, weight: .bold))
                            }
                            
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(maxHeight: .infinity)
                        .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                        
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Image(systemName: "arrow.up.right")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .regular))
                            .padding(8)
                            .background(Circle().fill(.black.opacity(0.1)))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        
                        Text("Flowers in stock:")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .regular))
                            .frame(width: 90)
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], content: {
                        
                        ForEach(flowerModel.flowers.prefix(4), id: \.self) { index in
                        
                                
                                Image(index.stPhoto ?? "")
                                    .resizable()
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 60)
                        }
                        })

                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(maxHeight: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg2")))
                }
            }
                .frame(height: 250)
                
                Spacer()
            }
            .padding()
        }
        .sheet(isPresented: $viewModel.isSettings, content: {
            
            SettingsView()
        })
        .onAppear{
            
            flowerModel.fetchFlowers()
        }
    }
}

#Preview {
    HomeView()
}
