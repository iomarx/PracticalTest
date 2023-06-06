//
//  NetworkDataSource.swift
//  PagaTodoTest
//
//  Created by Omar Bacilio on 05/06/23.
//

import Foundation
import Combine

struct NetworkDataSource: RemoteDataSource {
    
    static let BANKS_ENDPOINT = "https://dev.obtenmas.com/catom/api/challenge/banks"
    
    func fetchBanks() -> AnyPublisher<[Bank], Error> {
        let url = URL(string: Self.BANKS_ENDPOINT)
        
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
