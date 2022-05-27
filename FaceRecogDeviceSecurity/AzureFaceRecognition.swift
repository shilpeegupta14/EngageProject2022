//
//  AzureFaceRecognition.swift
//  FaceRecogDeviceSecurity
//
//  Created by Shilpee Gupta on 15/05/22.
//


import UIKit

let APIKey = "776d8d853e1641cd8c1389bba4234618" // Ocp-Apim-Subscription-Key
let Region = "eastus"
let FindSimilarsUrl = "https://\(Region).api.cognitive.microsoft.com/face/v1.0/findsimilars"
let DetectUrl = "https://\(Region).api.cognitive.microsoft.com/face/v1.0/detect?returnFaceId=true"

class AzureFaceRecognition: NSObject {

    static let shared = AzureFaceRecognition()

    
    // See Face - Detect endpoint details
    // https://westus.dev.cognitive.microsoft.com/docs/services/563879b61984550e40cbbe8d/operations/563879b61984550f30395236
    // @NOTE: This function must called from a background thread.
    func syncDetectFaceIds(imageData: Data) -> [String] {
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/octet-stream"
        headers["Ocp-Apim-Subscription-Key"] = APIKey
        
        let response = self.makePOSTRequest(url: DetectUrl, postData: imageData, headers: headers)
        let faceIds = extractFaceIds(fromResponse: response)
        
        return faceIds
    }
    
    func getSyncDetectFaceIds(imageData: Data) -> String {
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/octet-stream"
        headers["Ocp-Apim-Subscription-Key"] = APIKey
        
        let response = self.makePOSTRequest(url: DetectUrl, postData: imageData, headers: headers)
        for faceInfo in response {
            if let faceId = faceInfo["faceId"] as? String  {
                return faceId
            }
        }
        return ""
    }

    
    // See Face - Find Similar endpoint details
    // https://westus.dev.cognitive.microsoft.com/docs/services/563879b61984550e40cbbe8d/operations/563879b61984550f30395237
    func findSimilars(faceId: String, faceIds: [String], completion: @escaping (Bool) -> Void) {
        
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        headers["Ocp-Apim-Subscription-Key"] = APIKey
        
        let params: [String: Any] = [
            "faceId": faceId,
            "faceIds": faceIds,
            "mode": "matchFace"
        ]
        
        // Convert the Dictionary to Data
        let data = try! JSONSerialization.data(withJSONObject: params)
        
        DispatchQueue.global(qos: .background).async {
            let response = self.makePOSTRequest(url: FindSimilarsUrl, postData: data, headers: headers)
            var authenticated = false
            let minConfidence = 0.3
            for info in response {
//                if let faceId = info["faceId"] as? String  {
                let confidence = (info["confidence"] as! NSNumber).doubleValue
                print(confidence)
                if (confidence >= minConfidence) {
                    print(confidence)
                    authenticated = true
                }
            }
            DispatchQueue.main.async {
                completion(authenticated)
            }
        }
    }
    
    func groupSimilars(faceId: String, faceIds: [String], completion: @escaping ([String]) -> Void) {

        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        headers["Ocp-Apim-Subscription-Key"] = APIKey
        
        let params: [String: Any] = [
            "faceId": faceId,
            "faceIds": faceIds,
            "mode": "matchFace"
        ]
        
        // Convert the Dictionary to Data
        let data = try! JSONSerialization.data(withJSONObject: params)
        
        DispatchQueue.global(qos: .background).async {
            let response = self.makePOSTRequest(url: FindSimilarsUrl, postData: data, headers: headers)
            
            // Use a low confidence value to get more matches
            let faceIds = self.extractFaceIds(fromResponse: response, minConfidence: 0.4)

            DispatchQueue.main.async {
              completion(faceIds)
            }
        }
    }
    
    private func extractFaceIds(fromResponse response: [AnyObject], minConfidence: Float? = nil) -> [String] {
        var faceIds: [String] = []
        for faceInfo in response {
            if let faceId = faceInfo["faceId"] as? String  {
                var canAddFace = true
                if minConfidence != nil {
                    let confidence = (faceInfo["confidence"] as! NSNumber).floatValue
                    canAddFace = confidence >= minConfidence!
                }
                if canAddFace { faceIds.append(faceId) }
            }
            
        }
        
        return faceIds
    }
    
    // Just a function that makes a POST request.
    private func makePOSTRequest(url: String, postData: Data, headers: [String: String] = [:]) -> [AnyObject] {
        var object: [AnyObject] = []
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.httpBody = postData

        for header in headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        // Using semaphore to make request synchronous
        let semaphore = DispatchSemaphore(value: 0)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [AnyObject], json != nil {
                object = json
            }
            else {
                print("ERROR response: \(String(data: data!, encoding: .utf8) ?? "")")
            }
            
            semaphore.signal()
        }
        
        task.resume()
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        
        return object
    }
}
