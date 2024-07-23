//
//  AddFlower.swift
//  App685
//
//  Created by IGOR on 28/06/2024.
//

import SwiftUI

struct AddFlower: View {

    @StateObject var viewModel: StockViewModel
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack(spacing: 15) {
                
                Text("Create a new order")
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
                        
                        Menu(content: {
                            
                            ForEach(viewModel.photos, id: \.self) { index in
                            
                                Button(action: {
                                    
                                    viewModel.currentPhoto = index
                                    
                                }, label: {
                                    
                                    Image(index)
                                })
                            }
                            
                        }, label: {
                            
                            if viewModel.currentPhoto.isEmpty {
                                
                                Image("emptyPhoto")
                                    .resizable()
                                    .frame(width: 180, height: 180)
                                
                            } else {
                                
                                Image(viewModel.currentPhoto)
                                    .resizable()
                                    .frame(width: 180, height: 180)
                                
                            }
                            
                        })
                        .padding()

                        ZStack(alignment: .leading, content: {
                            
                            Text("Name")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.stName.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.stName)
                                .foregroundColor(Color.black)
                                .font(.system(size: 14, weight: .semibold))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                        .padding(1)

                        ZStack(alignment: .leading, content: {
                            
                            Text("Quantity:")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.stQuantity.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.stQuantity)
                                .foregroundColor(Color.black)
                                .font(.system(size: 14, weight: .semibold))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                        .padding(1)
                    }
                }
                
                Button(action: {
                    
                    viewModel.stPhoto = viewModel.currentPhoto
                    
                    viewModel.addFlower()
                    
                    viewModel.currentPhoto = ""
                    viewModel.stName = ""
                    viewModel.stQuantity = ""
                    
                    viewModel.fetchFlowers()

                    withAnimation(.spring()) {
                        
                        router.wrappedValue.dismiss()
                    }
                    
                }, label: {
                    
                    Text("Create")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .regular))
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(RoundedRectangle(cornerRadius: 25).fill(Color("bg2")))
                })
                .opacity(viewModel.stName.isEmpty || viewModel.stQuantity.isEmpty ? 0.5 : 1)
                .disabled(viewModel.stName.isEmpty || viewModel.stQuantity.isEmpty ? true : false)
            }
            .padding()
        }
    }
}

#Preview {
    AddFlower(viewModel: StockViewModel())
}
