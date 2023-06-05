//
//  PersistenceController.swift
//  PagaTodoTest
//
//  Created by Omar Bacilio on 05/06/23.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        self.container = NSPersistentContainer(name: "BanksDataModel")
        container.loadPersistentStores { storeDescritpion, error in
            if let error {
                fatalError("Container load failed: \(error)")
            }
        }
    }
    
    var context: NSManagedObjectContext {
        container.viewContext
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Saving Context error: \(error)")
            }
        }
    }
}
