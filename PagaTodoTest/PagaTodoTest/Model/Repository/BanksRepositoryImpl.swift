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
    
    let context: NSManagedObjectContext
    
    func fetchBanks() -> AnyPublisher<[Bank], Error> {
        fetchFromCoreData()
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
        fetchFromService().tryMap { banks in
            banks.forEach { bank in
                saveToCoreData(bank: bank)
            }
            return banks
        }.eraseToAnyPublisher()
    }
    
    func fetchFromService() -> AnyPublisher<[Bank], Error> {
        let url = URL(string: "https://dev.obtenmas.com/catom/api/challenge/banks")
        
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
    
    func fetchFromCoreData() -> AnyPublisher<[Bank], Error> {
        let request = NSFetchRequest<BankEntity>(entityName: "BankEntity")
        
        return Future<[Bank], Error> { promise in
            do {
                let data = try context.fetch(request)
                let banks = data.map { $0.toBankModel }
                
                return promise(.success(banks))
            } catch {
                return promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    func saveToCoreData(bank: Bank) {
        let newItem = BankEntity(context: context)
        newItem.id = bank.id
        newItem.bankName = bank.bankName
        newItem.bankDescription = bank.description
        newItem.age = Int32(bank.age)
        newItem.url = bank.url

        do {
            try context.save()
            print("Item Saved!")
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

extension BankEntity {
    var toBankModel: Bank {
        Bank(bankName: self.bankName ?? "",
             description: self.bankDescription ?? "",
             age: Int(self.age),
             url: self.url ?? "")
    }
}
