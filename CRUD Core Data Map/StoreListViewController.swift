//
//  StoreListViewController.swift
//  CRUD Core Data Map
//
//  Created by Maxime BOINET on 17/12/2017.
//  Copyright © 2017 Maxime BOINET. All rights reserved.
//

import UIKit

public class StoreListViewController: UIViewController {
    
    @IBOutlet weak var storeCollectionView: UICollectionView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.storeCollectionView.dataSource = self
        self.storeCollectionView.delegate = self
        self.storeCollectionView.register(UINib(nibName: "StoreCollectionCell", bundle: nil), forCellWithReuseIdentifier: "Store")
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.storeCollectionView.reloadData()
    }
}

extension StoreListViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Store.stores?.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let store = Store.stores?[indexPath.item] else {
            fatalError("Not possible")
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Store", for: indexPath)
        
        if let storeCell = cell as? StoreCollectionCell {
            storeCell.titleLabel.text = store.name
            storeCell.latLabel.text = String(store.coordinate.latitude)
            storeCell.lonLabel.text = String(store.coordinate.longitude)
            storeCell.delegate = self
        }
        return cell
    }
    
    
}

extension StoreListViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = collectionView.bounds.width
        
        if let layout = collectionView.collectionViewLayout as?
            UICollectionViewFlowLayout {
            width -= layout.minimumInteritemSpacing
        }
        return CGSize(width: width-(width/20), height: width/3)
    }
}

extension StoreListViewController: StoreCollectionCellDelegate {
    func sharePressedDelete(_ cell: StoreCollectionCell) {
        if let index = self.storeCollectionView.indexPath(for: cell) {
            if let store = Store.stores?[index.item] as Store? {
                store.deletes(index.item)
            }
            self.storeCollectionView.deleteItems(at: [index])
        }
    }
    
    func sharedPressedUpdate(_ cell: StoreCollectionCell) {
        let updateViewController = UpdateViewController()
        updateViewController.delegate = self
        updateViewController.cell = cell
        self.present(PortraitNavigationController(rootViewController: updateViewController), animated: true)
    }
}

extension StoreListViewController: UpdateStoreViewControllerDelegate {
    public func updateStoreViewController(_ storeup: Store, _ updateView: UpdateViewController, _ cell: StoreCollectionCell) {
        if let index = self.storeCollectionView.indexPath(for: cell) {
            if let store = Store.stores?[index.item] as Store? {
                store.update(with: storeup.name, and: storeup.coordinate)
            }
            self.storeCollectionView.reloadData()
        }
        updateView.dismiss(animated: true)
    }
    
}
