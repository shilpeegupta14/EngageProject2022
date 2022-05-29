
import SwiftUI
import Vision
import VisionKit

// Constructed with help from https://augmentedcode.io/2019/07/07/scanning-text-using-swiftui-and-vision-on-ios/
public struct CardReaderView: UIViewControllerRepresentable {

    private let completionHandler: (CardDetails?) -> Void
    
    //initialising a completion handler
    init(completionHandler: @escaping (CardDetails?) -> Void) {
        self.completionHandler = completionHandler
    }
     
    public typealias UIViewControllerType = VNDocumentCameraViewController
     
    //starting a camera view for detecting the card
    public func makeUIViewController(context: UIViewControllerRepresentableContext<CardReaderView>) -> VNDocumentCameraViewController {
        let viewController = VNDocumentCameraViewController()
        viewController.delegate = context.coordinator
        return viewController
    }
     //updates the UI
    public func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: UIViewControllerRepresentableContext<CardReaderView>) {
        
    }
    
    //coordinator to pass the completion handler to CardView screen and notify on performing completion of the scanning.
    public func makeCoordinator() -> Coordinator {
        Coordinator(completionHandler: completionHandler)
    }
     
    final public class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate, ImageTextRecognizable {
        private let completionHandler: (CardDetails?) -> Void
         
        init(completionHandler: @escaping (CardDetails?) -> Void) {
            self.completionHandler = completionHandler
        }
        //finishing the scan and validating image
        public func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            print("Document camera view controller did finish with ", scan)
            let image = scan.imageOfPage(at: 0)
            validateImage(image: image) { cardDetails in
                self.completionHandler(cardDetails)
            }
        }
         //cancel the scan
        public func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
            completionHandler(nil)
        }
         //error handling for failing to scan screen
        public func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
            print("Document camera view controller did finish with error ", error)
            completionHandler(nil)
        }
    }
}
