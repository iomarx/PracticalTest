//
//  CoreDataDataSource.swift
//  PagaTodoTest
//
//  Created by Omar Bacilio on 05/06/23.
//

import Foundation
import Combine
import CoreData

struct CoreDataDataSource: LocalDataSource {
    let context: NSManagedObjectContext
    
    func getBanks() -> AnyPublisher<[Bank], Error> {
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
    
    func save(_ bank: Bank) {
        let newItem = BankEntity(context: context)
        newItem.fromBankModel(bank)
        
        do {
            try context.save()
            print("Item Saved!")
        } catch {
            print("Error on save Bank = \(error)")
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
    
    func fromBankModel(_ bank: Bank) {
        self.id = bank.id
        self.bankName = bank.bankName
        self.bankDescription = bank.description
        self.age = Int32(bank.age)
        self.url = bank.url
    }
}
