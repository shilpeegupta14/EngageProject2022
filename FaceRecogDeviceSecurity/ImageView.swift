//
//  ImageView.swift
//  FaceRecogDeviceSecurity
//
//  Created by Shilpee Gupta on 20/05/22.
//

import UIKit

//enum CellType {
//    case square
//    case round
//}

class ImageView: UICollectionViewCell {
    
    let selectedColor = UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0).cgColor
    let unselectedColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0).cgColor
    

//    @IBOutlet weak var imageView: UIImageView! {
//        didSet {
//            imageView.layer.borderColor = unselectedColor
//        }
//    }
    @IBOutlet weak var imageView: UIImageView!
    
    var type: CellType = .square {
        didSet {
            imageView.layer.cornerRadius = type == .round ? frame.width / 2.0 : 0.0
            imageView.layer.borderWidth = type == .round ? 3.0 : 0.0
        }
    }
    
    override var bounds: CGRect {
        didSet {
            guard imageView != nil else {
                return
            }
            
            imageView.layer.cornerRadius = type == .round ? frame.width / 2.0 : 0.0
        }
    }
    
    override var isSelected: Bool {
        didSet {
            imageView.layer.borderColor = isSelected ? selectedColor : unselectedColor
        }
    }
}
