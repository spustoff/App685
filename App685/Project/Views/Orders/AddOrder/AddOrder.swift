//
//  AddOrder.swift
//  App685
//
//  Created by IGOR on 28/06/2024.
//

import SwiftUI

struct AddOrder: View {

    @StateObject var viewModel: OrdersViewModel
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

                        ZStack(alignment: .leading, content: {
                            
                            Text("Name")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.orName.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.orName)
                                .foregroundColor(Color.black)
                                .font(.system(size: 14, weight: .semibold))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                        .padding(1)

                        ZStack(alignment: .leading, content: {
                            
                            Text("Date")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.orDate.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.orDate)
                                .foregroundColor(Color.black)
                                .font(.system(size: 14, weight: .semibold))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                        .padding(1)
                        
                        ZStack(alignment: .leading, content: {
                            
                            Text("Amount to be paid")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.orAmount.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.orAmount)
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
                    
                    viewModel.revenues += Int(viewModel.orAmount) ?? 0
                    viewModel.Numorders += 1
                    
                    viewModel.addOrder()
                    
                    viewModel.orName = ""
                    viewModel.orDate = ""
                    viewModel.orAmount = ""
                    
                    viewModel.fetchOrders()

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
                .opacity(viewModel.orName.isEmpty || viewModel.orDate.isEmpty || viewModel.orAmount.isEmpty ? 0.5 : 1)
                .disabled(viewModel.orName.isEmpty || viewModel.orDate.isEmpty || viewModel.orAmount.isEmpty ? true : false)
            }
            .padding()
        }
    }
}

#Preview {
    AddOrder(viewModel: OrdersViewModel())
}
