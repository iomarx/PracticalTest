//
//  LocalDataSource.swift
//  PagaTodoTest
//
//  Created by Omar Bacilio on 05/06/23.
//

import Combine

protocol LocalDataSource {
    func getBanks() -> AnyPublisher<[Bank], Error>
    func save(_ bank: Bank)
}
