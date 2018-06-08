//
//  Store.swift
//  CRUD Core Data Map
//
//  Created by Maxime BOINET on 17/12/2017.
//  Copyright © 2017 Maxime BOINET. All rights reserved.
//

import CoreLocation
import MapKit
import CoreData

public class Store {
    static private(set) var stores: [Store]?
    
    public var name: String
    public var coordinate: CLLocationCoordinate2D
    static private var populated = false
    
    public var annotation: MKAnnotation {
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.title = self.name
        pointAnnotation.coordinate = self.coordinate
        return pointAnnotation
    }
    
    public init(_ name: String,_ coordinate: CLLocationCoordinate2D) {
        self.name = name
        self.coordinate = coordinate
        
        if Store.stores == nil {
            Store.stores = [Store]()
        }
        
        if Store.populated {
            self.save()
        } else {
            Store.stores?.append(self)
        }
    }
    
    public init(_ name: String,_ coordinate: CLLocationCoordinate2D, _ up: Bool) {
        self.name = name
        self.coordinate = coordinate
    }
    
    public static func populate() {
        if let s = CrudStore.fetchAll() {
            for store in s {
                Store(store.name!, CLLocationCoordinate2D(latitude: store.lat ,longitude: store.long))
            }
        }
        Store.populated = true
    }
    
    public func save() {
        Store.stores?.append(self)
        CrudStore.saveStore(self)
    }
    
    public func deletes(_ index: Int) {
        if (Store.stores?[index]) != nil {
            CrudStore.deleteStore(self)
            Store.stores?.remove(at: index)
        }
        
    }
    
    public func update(with name: String, and coord: CLLocationCoordinate2D) {
        CrudStore.updateStore(current: self, updatedAs: Store(name, coord, true))
        self.name = name
        self.coordinate = coord
    }
}
