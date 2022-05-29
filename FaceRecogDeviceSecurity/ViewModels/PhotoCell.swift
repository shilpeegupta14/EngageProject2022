//
//  PhotoCell.swift
//  FaceRecogDeviceSecurity
//
//  Created by Shilpee Gupta on 26/05/22.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    let selectedColor = UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0).cgColor
    let unselectedColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0).cgColor
    
    @IBOutlet weak var photoImageView: UIImageView! {
        didSet {
            photoImageView.layer.borderColor = unselectedColor
        }
    }
    
    var type: CellType = .square {
        didSet {
            photoImageView.layer.cornerRadius = type == .round ? frame.width / 2.0 : 0.0
            photoImageView.layer.borderWidth = type == .round ? 3.0 : 0.0
        }
    }
    
    override var bounds: CGRect {
        didSet {
            guard photoImageView != nil else {
                return
            }
            
            photoImageView.layer.cornerRadius = type == .round ? frame.width / 2.0 : 0.0
        }
    }
    
    override var isSelected: Bool {
        didSet {
            photoImageView.layer.borderColor = isSelected ? selectedColor : unselectedColor
        }
    }
}
