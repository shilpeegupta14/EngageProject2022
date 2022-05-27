//
//  HomeViewController.swift
//  FaceRecogDeviceSecurity
//
//  Created by Shilpee Gupta on 18/05/22.
//

import Foundation
import UIKit
import PhotosUI

class HomeViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
   var imageArray = [UIImage()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        var config = PHPickerConfiguration()
        config.selectionLimit=3
        
        let phPickerVC = PHPickerViewController(configuration: config)
        self.present(phPickerVC, animated: true)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self){ object, error in
                if let image = object as? UIImage{
                    self.imageArray.append(image)
                }
                DispatchQueue.main.async {
                    self.photoCollectionView.reloadData()
                }
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        cell.photoImageView.image=imageArray[indexPath.row]
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    // photos stored in collection view of 3 rows and 5 columns with a gap of 2 mm btw each other
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.size.width/3 - 2, height: collectionView.frame.size.height/5 - 2)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

