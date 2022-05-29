//
//  HostingViewController.swift
//  FaceRecogDeviceSecurity
//
//  Created by Shilpee Gupta on 26/05/22.
//

import UIKit
import SwiftUI

class HostingViewController: UIHostingController<CardFormView> {

    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder, rootView: CardFormView( completion: { cardDetails in
        })
    )}
                   }

