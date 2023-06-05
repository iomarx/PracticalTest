//
//  BanksRepository.swift
//  PagaTodoTest
//
//  Created by Omar Bacilio on 05/06/23.
//

import Combine

protocol BanksRepository {
    func fetchBanks() -> AnyPublisher<[Bank], Error>
}
