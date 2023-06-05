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
            Bank(bankName: "Paga Todo", description: "Banco Paga Todo es Para Todos", age: 10, url: "url"),
            Bank(bankName: "BBVA Bancomer", description: "BBVA Bancomer Creando Oportunidades", age: 10, url: "url"),
        ]
    }
}
