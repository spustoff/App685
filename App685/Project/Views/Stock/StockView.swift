//
//  StockView.swift
//  App685
//
//  Created by IGOR on 28/06/2024.
//

import SwiftUI

struct StockView: View {
    
    @StateObject var viewModel = StockViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Button(action: {
                    
                    withAnimation(.spring()) {
                        
                        viewModel.isAdd = true
                    }
                    
                }, label: {
                    
                    Image(systemName: "plus")
                        .foregroundColor(Color("bg2"))
                        .font(.system(size: 17, weight: .medium))
                    
                })
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                Text("Stock")
                    .foregroundColor(.black)
                    .font(.system(size: 28, weight: .regular))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom)
                
                if viewModel.flowers.isEmpty {
                    
                    VStack(spacing: 20) {
                        
                        Image("list")
                        
                        Text("The warehouse is empty now")
                            .foregroundColor(.black)
                            .font(.system(size: 18, weight: .regular))
                            .frame(width: 160)
                            .multilineTextAlignment(.center)
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAdd = true
                            }
                            
                        }, label: {
                            
                            HStack {
                                
                                Image(systemName: "plus")
                                    .foregroundColor(Color("bg2"))
                                    .font(.system(size: 16, weight: .medium))
                                
                                Text("Add a new position")
                                    .foregroundColor(.black)
                                    .font(.system(size: 15, weight: .regular))
                                   
                            }
                            .padding(6)
                            .padding(.horizontal, 5)
                            .background(RoundedRectangle(cornerRadius: 15).stroke(.gray.opacity(0.7)))
                        })
                        
                    }
                    .frame(maxHeight: .infinity)
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], content: {
                            
                            ForEach(viewModel.flowers, id: \.self) { index in
                            
                                VStack {
                                    
                                    Image(index.stPhoto ?? "")
                                        .resizable()
                                        .frame(width: 150, height: 150)
                                    
                                    Text(index.stName ?? "")
                                        .foregroundColor(.black)
                                        .font(.system(size: 15, weight: .regular))
                                    
                                    Text(index.stQuantity ?? "")
                                        .foregroundColor(.white)
                                        .font(.system(size: 13, weight: .medium))
                                        .padding(4)
                                        .padding(.horizontal, 3)
                                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("bg2")))
                                    
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                            }
                        })
                    }
                }
                
            }
            .padding()
        }
        .onAppear {
            
            viewModel.fetchFlowers()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            AddFlower(viewModel: viewModel)
        })
    }
}

#Preview {
    StockView()
}
