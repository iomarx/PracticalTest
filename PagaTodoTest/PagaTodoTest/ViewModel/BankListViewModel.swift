//
//  BankListViewModel.swift
//  PagaTodoTest
//
//  Created by Omar Bacilio on 05/06/23.
//

import Foundation

class BankListViewModel: ObservableObject {
    @Published var banks = [Bank]()
    
    init() {
        self.banks = [
            Bank(id: "1", bankName: "Paga Todo", description: "Banco Paga Todo es Para Todos", age: 10, url: "url"),
            Bank(id: "2", bankName: "BBVA Bancomer", description: "BBVA Bancomer Creando Oportunidades", age: 10, url: "url"),
        ]
    }
}
