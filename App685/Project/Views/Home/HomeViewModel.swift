//
//  HomeViewModel.swift
//  App685
//
//  Created by IGOR on 28/06/2024.
//

import SwiftUI

final class HomeViewModel: ObservableObject {

    @AppStorage("revenues") var revenues: Int = 0
    @AppStorage("Numorders") var Numorders: Int = 0

    @Published var isAdd: Bool = false
    @Published var isDelete: Bool = false
    @Published var isDetail: Bool = false
    @Published var isSettings: Bool = false


}
