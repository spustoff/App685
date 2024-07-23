//
//  OrdersView.swift
//  App685
//
//  Created by IGOR on 28/06/2024.
//

import SwiftUI

struct OrdersView: View {
    
    @StateObject var viewModel = OrdersViewModel()
    
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
                    
                    Text("Orders")
                        .foregroundColor(.black)
                        .font(.system(size: 28, weight: .regular))
                        .frame(maxWidth: .infinity, alignment: .leading)

                if viewModel.orders.isEmpty {
                    
                    VStack(spacing: 20) {
                        
                        Image("order")
                        
                        Text("You don't have any orders yet")
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
                                
                                Text("Add a new order")
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
                        
                        LazyVStack {
                            
                            ForEach(viewModel.orders, id: \.self) { index in
                                
                                Button(action: {
                                    
                                    viewModel.selectedOrder = index
                                    
                                    withAnimation(.spring()) {
                                        
                                        viewModel.isDelete = true
                                    }
                                    
                                }, label: {
                                    
                                    HStack {
                                        
                                        Image("order")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 18)
                                            .padding()
                                            .background(Circle().fill(.white))
                                        
                                        VStack(alignment: .leading, spacing: 5) {
                                            
                                            Text(index.orName ?? "")
                                                .foregroundColor(.black)
                                                .font(.system(size: 16, weight: .regular))
                                            
                                            Text(index.orDate ?? "")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 13, weight: .regular))
                                        }
                                        
                                        Spacer()
                                        
                                        Text("$ \(index.orAmount ?? "")")
                                            .foregroundColor(.black)
                                            .font(.system(size: 16, weight: .medium))

                                    }
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 15).fill(.gray.opacity(0.1)))
                                })
                                
                            }
                        }
                    }
                    
                }
                
            }
            .padding()
        }
        .onAppear{
            
            viewModel.fetchOrders()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            AddOrder(viewModel: viewModel)
        })
        .overlay(
            
            ZStack {
                
                Color.black.opacity(viewModel.isDelete ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isDelete = false
                        }
                    }
                
                VStack {
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isDelete = false
                            }
                            
                        }, label: {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .regular))
                        })
                    }
                    
                    Text("Delete")
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .semibold))
                        .padding()
                    
                    Text("Are you sure you want to delete?")
                        .foregroundColor(.gray)
                        .font(.system(size: 14, weight: .regular))
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        
                        CoreDataStack.shared.deleteOrder(withOrName: viewModel.selectedOrder?.orName ?? "", completion: {
                            
                            viewModel.fetchOrders()
                        })
          
                        withAnimation(.spring()) {
                            
                            viewModel.isDelete = false
                            
                        }
                                
                    }, label: {
                        
                        Text("Delete")
                            .foregroundColor(.red)
                            .font(.system(size: 18, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                        
                    })
                    .padding(.top, 25)
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isDelete = false
                        }
                        
                    }, label: {
                        
                        Text("Close")
                            .foregroundColor(.black)
                            .font(.system(size: 18, weight: .regular))
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                        
                    })
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg")))
                .padding()
                .offset(y: viewModel.isDelete ? 0 : UIScreen.main.bounds.height)
            }
        )
    }
}

#Preview {
    OrdersView()
}
