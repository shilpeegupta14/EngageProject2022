//

import Foundation
import Vision
import VisionKit

//protocol to conform to Vision Delegate
public protocol ImageTextRecognizable: VNDocumentCameraViewControllerDelegate { }

public extension ImageTextRecognizable {
    
    //Performns a text recognition reuest to Vision API and pass the recognized text on the card to parse function.
    func validateImage(image: UIImage?, completion: @escaping (CardDetails?) -> Void) {
        guard let cgImage = image?.cgImage else { return completion(nil) }
        
        var recognizedText = [String]()
        
        var textRecognitionRequest = VNRecognizeTextRequest()
        textRecognitionRequest.recognitionLevel = .accurate
        textRecognitionRequest.usesLanguageCorrection = false
        textRecognitionRequest.customWords = CardType.allCases.map { $0.rawValue } + ["Expiry Date"]
        textRecognitionRequest = VNRecognizeTextRequest() { (request, error) in
            guard let results = request.results,
                  !results.isEmpty,
                  let requestResults = request.results as? [VNRecognizedTextObservation]
            else { return completion(nil) }
            recognizedText = requestResults.compactMap { observation in
                return observation.topCandidates(1).first?.string
            }
        }
        
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do {
            try handler.perform([textRecognitionRequest])
            completion(parseResults(for: recognizedText))
        } catch {
            print(error)
        }
    }
    
    //Parse the recognized texts from the vision API to CardDetails struct and remove the extra words like PLatinum Card etc
    func parseResults(for recognizedText: [String]) -> CardDetails {
        // Credit Card Number
        let creditCardNumber = recognizedText.first(where: { $0.count >= 14 && ["4", "5", "3", "6"].contains($0.first) })
        
        // Expiry Date
        let expiryDateString = recognizedText.first(where: { $0.count > 4 && $0.contains("/") })
        let expiryDate = expiryDateString?.filter({ $0.isNumber || $0 == "/" })
        
        // Name
        let ignoreList = ["GOOD THRU", "GOOD", "THRU", "Gold", "GOLD", "Standard", "STANDARD", "Platinum", "PLATINUM", "WORLD ELITE", "WORLD", "ELITE", "World Elite", "World", "Elite"]
        let wordsToAvoid = [creditCardNumber, expiryDateString] +
            ignoreList +
            CardType.allCases.map { $0.rawValue } +
            CardType.allCases.map { $0.rawValue.lowercased() } +
            CardType.allCases.map { $0.rawValue.uppercased() }
        let name = recognizedText.filter({ !wordsToAvoid.contains($0) }).last
        
        return CardDetails(numberWithDelimiters: creditCardNumber, name: name, expiryDate: expiryDate)
    }
}
