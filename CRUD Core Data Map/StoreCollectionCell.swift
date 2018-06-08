//
//  StoreCollectionCell.swift
//  CRUD Core Data Map
//
//  Created by Maxime BOINET on 17/12/2017.
//  Copyright © 2017 Maxime BOINET. All rights reserved.
//

import UIKit

protocol StoreCollectionCellDelegate: class {
    func sharePressedDelete(_ cell: StoreCollectionCell)
    
    func sharedPressedUpdate(_ cell: StoreCollectionCell)
}

public class StoreCollectionCell: UICollectionViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var latLabel: UILabel!
    @IBOutlet var lonLabel: UILabel!
    
    var delegate: StoreCollectionCellDelegate?
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.borderColor = UIColor.darkGray.cgColor
        self.contentView.layer.borderWidth = 2
    }

    @IBAction func deletePush(_ sender: Any) {
        self.delegate?.sharePressedDelete(self)
    }
    
    @IBAction func updatePush(_ sender: Any) {
        self.delegate?.sharedPressedUpdate(self)
    }
}
