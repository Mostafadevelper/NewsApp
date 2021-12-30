//
//  DataController.swift
//  NewsApp
//
//  Created by Mostafa on 30/12/2021.
//

import Foundation
import CoreData


/*
 
 1 - to hold a persistance container instance
 2 - to help us to load persistance store
 3 - to help us access the context
 **/
class DataController {
    
    //=====> (1)
    let persistanceContainer : NSPersistentContainer
    
    init(modelName : String) {
        persistanceContainer = NSPersistentContainer(name: modelName)
    }
    
    // =====> (3)
    var viewContext : NSManagedObjectContext {
        return persistanceContainer.viewContext
    }

    // ======> (2)
    func load( completion : (() -> Void)? = nil ){
        persistanceContainer.loadPersistentStores { (storeDescription, error) in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            self.autoSaveViewContext()
            completion?()
        }
    }
    
}


extension DataController {
    func autoSaveViewContext(interval : TimeInterval = 30 ){
        print("autoSaving")
        guard  interval > 0 else {
            print("cannot set negative autosave interval")
            return
        }
        if viewContext.hasChanges {
            try? viewContext.save()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            self.autoSaveViewContext()
        }
    }
}


public extension NSManagedObject {

    convenience init(context: NSManagedObjectContext) {
        let name = String(describing: type(of: self))
        let entity = NSEntityDescription.entity(forEntityName: name, in: context)!
        self.init(entity: entity, insertInto: context)
    }

}
