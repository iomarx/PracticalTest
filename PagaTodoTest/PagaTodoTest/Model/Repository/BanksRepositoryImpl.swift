//
//  BanksRepositoryImpl.swift
//  PagaTodoTest
//
//  Created by Omar Bacilio on 05/06/23.
//

import Foundation
import Combine

struct BanksRepositoryImpl: BanksRepository {
    
    func fetchBanks() -> AnyPublisher<[Bank], Error> {
        let url = URL(string: "https://dev.obtenmas.com/catom/api/challenge/bank2s")
        
        return URLSession.shared.dataTaskPublisher(for: url!)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Bank].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
