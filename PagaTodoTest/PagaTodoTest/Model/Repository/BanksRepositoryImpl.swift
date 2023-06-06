//
//  BanksRepositoryImpl.swift
//  PagaTodoTest
//
//  Created by Omar Bacilio on 05/06/23.
//

import Foundation
import Combine
import CoreData

struct BanksRepositoryImpl: BanksRepository {
    
    let remoteDataSource: RemoteDataSource
    let localDataSource: LocalDataSource
    
    func fetchBanks() -> AnyPublisher<[Bank], Error> {
        localDataSource.getBanks()
            .flatMap { banks in
                if banks.isEmpty {
                    return fetchAndSave()
                } else {
                    return Just(banks)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    func fetchAndSave() -> AnyPublisher<[Bank], Error> {
        remoteDataSource.fetchBanks().tryMap { banks in
            banks.forEach { bank in
                localDataSource.save(bank)
            }
            return banks
        }.eraseToAnyPublisher()
    }
}
