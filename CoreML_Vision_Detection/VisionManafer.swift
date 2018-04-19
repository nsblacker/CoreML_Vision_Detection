//
//  VisionManafer.swift
//  CoreML_Vision_Detection
//
//  Created by kahn on 2018/4/19.
//  Copyright © 2018年 NSblakcer. All rights reserved.
//

import UIKit
import Vision


class VisionManafer: NSObject {

    //Machine-Learning Image Analysis
    func objDetectionUsingCoreML(pixelBuffer:CVPixelBuffer) -> Void {
        
        let model = try! VNCoreMLModel(for: Resnet50().model)
        let request = VNCoreMLRequest(model: model, completionHandler: objDetectionUsingCoreMLDidComplete)
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer)
        try! handler.perform([request])
    }
    
    func objDetectionUsingCoreMLDidComplete(request: VNRequest, error: Error?) {
        guard let results = request.results as? [VNClassificationObservation]
            else { fatalError("huh") }
        //recogLabel.text = results[0].identifier
        for classification in results {
            print(classification.identifier, // the scene label
                classification.confidence)
        }
    }
    
    //Object Tracking
    func objTracking(pixelBuffer:CVPixelBuffer) -> Void {
        
        //let request = VNtr
    }
    
    //Rectangle Detection
    func rectangleDetection(pixelBuffer:CVPixelBuffer) -> Void {
//        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer)
//        let request = VNDetectRectanglesRequest(completionHandler: <#T##VNRequestCompletionHandler?##VNRequestCompletionHandler?##(VNRequest, Error?) -> Void#>)
//        try! handler.perform([request])
    }
    
}
