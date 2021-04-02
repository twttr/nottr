//
//  CoreDataManager.swift
//  notey
//
//  Created by Pavel Romanishkin on 02.04.21.
//

import UIKit
import CoreData

struct CoreDataManager {
                
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveData() {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func loadData<T: NSManagedObject>() -> [T] {
        let request = T.fetchRequest()
        var out: [T] = []
        do {
            out = try context.fetch(request) as! [T]
        } catch {
            print(error)
        }
        return out
    }
}
