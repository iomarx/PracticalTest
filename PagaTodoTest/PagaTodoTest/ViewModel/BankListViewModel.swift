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
    @Published var hasError = false
    @Published var error = ""
    
    private let repository: BanksRepository
    private var disposables = Set<AnyCancellable>()
    
    init(repository: BanksRepository) {
        self.repository = repository
        fetchBanks()
    }
    
    private func fetchBanks() {
        repository.fetchBanks()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                    self?.hasError = true
                }
            } receiveValue: { [weak self] banks in
                self?.banks = banks
            }
            .store(in: &disposables)
    }
}
