//
//  CoreDataManager.swift
//  AppleShortcuts
//
//  Created by Hassan El Desouky on 8/9/19.
//  Copyright © 2019 Hassan El Desouky. All rights reserved.
//

import UIKit
import CoreData

struct CoreDataManager {
  static let shared = CoreDataManager()
  
  let persistentContainer: NSPersistentContainer = {
    let perCon = NSPersistentContainer(name: "Model")
    perCon.loadPersistentStores { (storeDescription, err) in
      if let err = err {
        fatalError("\(err)")
      }
    }
    return perCon
  }()
  
  func fetchLists() -> [List] {
    let context = persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<List>(entityName: "List")
    do {
      let lists = try context.fetch(fetchRequest)
      return lists
    } catch let err {
      print("\(err)")
      return []
    }
  }
  
  func resetLists() {
    let context = persistentContainer.viewContext
    let batchRequest = NSBatchDeleteRequest(fetchRequest: List.fetchRequest())
    do {
      try context.execute(batchRequest)
    } catch let err {
      print("\(err)")
    }
  }
}

