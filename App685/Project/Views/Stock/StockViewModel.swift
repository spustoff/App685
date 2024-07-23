//
//  StockViewModel.swift
//  App685
//
//  Created by IGOR on 28/06/2024.
//

import SwiftUI
import CoreData

final class StockViewModel: ObservableObject {
    
    @Published var photos: [String] = ["1", "2", "3", "4"]
    @Published var currentPhoto = ""
    
    @AppStorage("revenues") var revenues: Int = 0
    @AppStorage("Numorders") var Numorders: Int = 0

    @Published var isAdd: Bool = false
    @Published var isDelete: Bool = false
    @Published var isDetail: Bool = false
    @Published var isSettings: Bool = false

    @Published var stPhoto = ""
    @Published var stName = ""
    @Published var stQuantity = ""

    @Published var flowers: [StockModel] = []
    @Published var selectedFlower: StockModel?

    func addFlower() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "StockModel", into: context) as! StockModel

        loan.stPhoto = stPhoto
        loan.stName = stName
        loan.stQuantity = stQuantity

        CoreDataStack.shared.saveContext()
    }

    func fetchFlowers() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<StockModel>(entityName: "StockModel")

        do {

            let result = try context.fetch(fetchRequest)

            self.flowers = result

        } catch let error as NSError {

            print("catch")

            print("Error fetching persons: \(error), \(error.userInfo)")

            self.flowers = []
        }
    }
}
