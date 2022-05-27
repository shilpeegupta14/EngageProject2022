//
//  ContentManager.swift
//  FaceRecogDeviceSecurity
//
//  Created by Shilpee Gupta on 20/05/22.
//

import UIKit

class Person: NSObject {
    fileprivate(set) var faceId: String!
    fileprivate(set) var avatar: UIImage!
}

class Photo: NSObject {
    var faceIds: [String]!
    var image: UIImage!
}

class ContentManager: NSObject {
    
    static let shared = ContentManager()
    
    private(set) var persons: [Person] = []
    private(set) var photos: [Photo] = []
    
    lazy var allPhotosFaceIds: [String] = {
        var allFaceIds: [String] = []
        for photo in photos {
            allFaceIds.append(contentsOf: photo.faceIds)
        }
        return allFaceIds
    }()
    
    func load(completion: @escaping () -> Void) {
        
        DispatchQueue.global(qos: .background).async {
            
            let (avatarDatas, avatarImages) = self.loadImages(at: "/Images/Avatars")
            let (photoDatas, photoImages) = self.loadImages(at: "/Images/AllPhotos")
            
            // Create Persons
            for (avatarData, avatarImage) in zip(avatarDatas, avatarImages) {
                if let faceId = AzureFaceRecognition.shared.syncDetectFaceIds(imageData: avatarData).first {
                    let person = Person()
                    person.faceId = faceId
                    person.avatar = avatarImage
                    self.persons.append(person)
                }
            }
            
            // Create Photos
            for (photoData, photoImage) in zip(photoDatas, photoImages) {
                let faceIds = AzureFaceRecognition.shared.syncDetectFaceIds(imageData: photoData)
                if !faceIds.isEmpty {
                    let photo = Photo()
                    photo.faceIds = faceIds
                    photo.image = photoImage
                    self.photos.append(photo)
                }
            }
            
            DispatchQueue.main.async {
                completion()
            }
        }
        
    }
    
    private func loadImages(at path: String) -> ([Data], [UIImage]) {
        var datas: [Data] = []
        var images: [UIImage] = []
        
        let fullFolderPath = Bundle.main.resourcePath!.appending(path)
        let imageNames = try! FileManager.default.contentsOfDirectory(atPath: fullFolderPath)
        
        for imageName in imageNames {
            let imageUrl = fullFolderPath.appending("/\(imageName)")
            let data = try! Data.init(contentsOf: URL(fileURLWithPath: imageUrl))
            let image = UIImage.init(data: data, scale: UIScreen.main.scale)!
            
            datas.append(data)
            images.append(image)
        }
        
        return (datas, images)
    }
    
    func photos(withFaceIds faceIds: [String]) -> [Photo] {
        var filteredPhotos: [Photo] = []
        
        let faceIdsSet = Set(faceIds)
        for photo in photos {
            let hasFaceIds = Set(photo.faceIds).intersection(faceIdsSet).isEmpty == false
            if hasFaceIds {
                filteredPhotos.append(photo)
            }
        }
        
        return filteredPhotos
    }
    
}
