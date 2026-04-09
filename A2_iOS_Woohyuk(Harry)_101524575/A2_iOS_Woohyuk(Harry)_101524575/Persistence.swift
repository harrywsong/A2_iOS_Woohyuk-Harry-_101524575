//
//  Persistence.swift
//  A2_iOS_Woohyuk(Harry)_101524575
//
//  Created by Woohyuk Song on 2026-04-09.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = Product(context: viewContext)
            newItem.name = "Preview Product"
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "A2_iOS_Woohyuk_Harry__101524575")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        // seed 10 products on first launch
        seedDataIfNeeded()
    }

    // function that seeds the following data into Core Data
    private func seedDataIfNeeded() {
        let key = "hasSeededProducts"
        guard !UserDefaults.standard.bool(forKey: key) else { return }

        let ctx = container.viewContext
        let products: [(String, String, Double, String)] = [
            ("Test Item 1", "Test Description 1", 1.00, "Test Provider 1"),
            ("Test Item 2", "Test Description 2", 2.00, "Test Provider 2"),
            ("Test Item 3", "Test Description 3", 3.00, "Test Provider 3"),
            ("Test Item 4", "Test Description 4", 4.00, "Test Provider 4"),
            ("Test Item 5", "Test Description 5", 5.00, "Test Provider 5"),
            ("Test Item 6", "Test Description 6", 6.00, "Test Provider 6"),
            ("Test Item 7", "Test Description 7", 7.00, "Test Provider 7"),
            ("Test Item 8", "Test Description 8", 8.00, "Test Provider 8"),
            ("Test Item 9", "Test Description 9", 9.00, "Test Provider 9"),
            ("Test Item 10", "Test Description 10", 10.00, "Test Provider 10")
        ]

        for (name, desc, price, provider) in products {
            let product = Product(context: ctx)
            product.id = UUID()
            product.name = name
            product.productDescription = desc
            product.price = price
            product.provider = provider
        }

        try? ctx.save()
        UserDefaults.standard.set(true, forKey: key)
    }
}
