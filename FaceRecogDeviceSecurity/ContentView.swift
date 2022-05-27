////
////  ContentView.swift
////  FaceRecogDeviceSecurity
////
////  Created by Shilpee Gupta on 25/05/22.
////
//
//import SwiftUI
//import FirebaseStorage
//import Firebase
//
//struct ContentView: View {
//    
//    @State var isPickerShowing = false
//    @State var selectedImage: UIImage?
//    @State var retrievedImages = [UIImage]()
//    
//    var body: some View {
//        VStack {
//            if selectedImage != nil {
//                Image(uiImage: selectedImage!)
//                    .resizable()
//                    .frame(width: 200, height: 200)
//            }
//            Button {
//                isPickerShowing=true
//            } label: {
//                Text("Select a Photo")
//            }
//            
//            //upload button
//            if selectedImage != nil {
//                Button {
//                    //upload image
//                    uploadPhoto()
//                } label: {
//                    Text("Upload Photo")
//                }
//            }
//            
//            Divider()
//            
//            
//            HStack {
//                
//                //loop through the images and display them
//                ForEach(retrievedImages, id: \.self) { image in
//                    Image(uiImage: image)
//                        .resizable()
//                        .frame(width: 200, height: 200)
//                }
//            }
//        }
//        .sheet(isPresented: $isPickerShowing, onDismiss: nil) {
//            ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing)
//        }
//    }
//    
//    func uploadPhoto() {
//        //make sure that the selected image property isnt nil
//        guard selectedImage != nil else {
//            return
//        }
//        
//        //create storage reference
//        let storageRef=Storage.storage().reference()
//        
//        // Turn our image into data
//        let imageData=selectedImage!.jpegData(compressionQuality: 0.8)
//        
//        //check that we were able to convert it to data
//        guard imageData != nil else{
//            return
//        }
//        //specify file path and name
//        let path="images/\(UUID().uuidString).jpg"
//        let fileRef = storageRef.child(path)
//        
//        //upload that data
//        let uploadTask = fileRef.putData(imageData!, metadata: nil){ metadata, error in
//            
//            //check for errors
//            if error == nil && metadata != nil{
//                
//                // Save a reference to the file in Firestore DB
//                let db=Firestore.firestore()
//                db.collection("images").document()
//                db.collection("images").document().setData(["url":path])
//            }
//        }
//    }
//    
//    func retrievePhotos {
//        //get the data from the database
//        let db=Firestore.firestore()
//        db.collection("images").getDocuments { snapshot, Error? in
//            if error == nil && snapshot != nil {
//                
//            }
//        }
//        
//        // get the image data in storage for each image reference
//        
//        //display the images
//    }
//    
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
