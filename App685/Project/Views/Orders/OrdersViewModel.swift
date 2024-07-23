//
//  OrdersViewModel.swift
//  App685
//
//  Created by IGOR on 28/06/2024.
//

import SwiftUI
import CoreData

final class OrdersViewModel: ObservableObject {

    @AppStorage("revenues") var revenues: Int = 0
    @AppStorage("Numorders") var Numorders: Int = 0

    @Published var isAdd: Bool = false
    @Published var isDelete: Bool = false
    @Published var isDetail: Bool = false
    @Published var isSettings: Bool = false

    @Published var orName = ""
    @Published var orDate = ""
    @Published var orAmount = ""

    @Published var orders: [OrderModel] = []
    @Published var selectedOrder: OrderModel?

    func addOrder() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "OrderModel", into: context) as! OrderModel

        loan.orName = orName
        loan.orDate = orDate
        loan.orAmount = orAmount

        CoreDataStack.shared.saveContext()
    }

    func fetchOrders() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<OrderModel>(entityName: "OrderModel")

        do {

            let result = try context.fetch(fetchRequest)

            self.orders = result

        } catch let error as NSError {

            print("catch")

            print("Error fetching persons: \(error), \(error.userInfo)")

            self.orders = []
        }
    }
}
