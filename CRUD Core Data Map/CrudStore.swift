//
//  CrudStore.swift
//  CRUD Core Data Map
//
//  Created by Maxime BOINET on 17/12/2017.
//  Copyright © 2017 Maxime BOINET. All rights reserved.
//

import Foundation
import CoreData

public class CrudStore {
    private static var context: NSManagedObjectContext!
    
    public static func setContext(context: NSManagedObjectContext) {
        if  CrudStore.context == nil {
            self.context = context
        }
    }
    
    public static func fetchAll() -> [StoreC]? {
        let request: NSFetchRequest<StoreC> = StoreC.fetchRequest()
        guard let result = try? self.context.fetch(request) else {
            return [StoreC]()
        }
        return result
    }
    
    public static func saveStore(_ store: Store) {
        let s = StoreC(context: self.context)
        s.name = store.name
        s.long = store.coordinate.longitude
        s.lat = store.coordinate.latitude
        try? self.context.save()
    }
    
    public static func updateStore(current store: Store, updatedAs storeup: Store) {
        let request: NSFetchRequest<StoreC> = StoreC.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@ AND long == %@ AND lat == %@", store.name, store.coordinate.longitude.description, store.coordinate.latitude.description)
        
        guard let result = try? self.context.fetch(request) else {
            return
        }
        print(result)
        result.forEach{ $0.name=storeup.name; $0.lat=storeup.coordinate.latitude
            $0.long=storeup.coordinate.longitude
        }
        try?self.context.save()
    }
    
    public static func deleteStore(_ store: Store) {
        let request: NSFetchRequest<StoreC> = StoreC.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@ AND long == %@ AND lat == %@", store.name, store.coordinate.longitude.description, store.coordinate.latitude.description)
        guard let result = try? self.context.fetch(request) else {
            return
        }
        result.forEach{self.context.delete($0)}
        try? self.context.save()
    }
}
