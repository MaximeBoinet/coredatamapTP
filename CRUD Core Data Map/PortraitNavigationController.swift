//
//  PortraitNavigationController.swift
//  CRUD Core Data Map
//
//  Created by Maxime BOINET on 17/12/2017.
//  Copyright © 2017 Maxime BOINET. All rights reserved.
//

import UIKit

public class PortraitNavigationController: UINavigationController {
    
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return self.visibleViewController?.supportedInterfaceOrientations ?? super.supportedInterfaceOrientations
    }
}
