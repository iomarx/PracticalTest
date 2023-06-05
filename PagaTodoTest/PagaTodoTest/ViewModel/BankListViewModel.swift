//
//  BankListViewModel.swift
//  PagaTodoTest
//
//  Created by Omar Bacilio on 05/06/23.
//

import Foundation
import Combine

class BankListViewModel: ObservableObject {
    
    @Published var banks = [Bank]()
    
    private let repository: BanksRepository
    private var disposables = Set<AnyCancellable>()
    
    init(repository: BanksRepository) {
        self.repository = repository
        fetchBanks()
    }
    
    private func fetchBanks() {
        repository.fetchBanks()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("completion = \(completion)")
            } receiveValue: { [weak self] banks in
                self?.banks = banks
            }
            .store(in: &disposables)
    }
}
