//
//  VisionManafer.swift
//  CoreML_Vision_Detection
//
//  Created by kahn on 2018/4/19.
//  Copyright © 2018年 NSblakcer. All rights reserved.
//

import UIKit
import Vision

enum VNRequestType {
    
    case ObjDectectCoreML
    case RectangleDetection
    case ObjectTracking
    case FaceRectangle
    case FaceLandmark
}

typealias MyVNRequestCompletionHandler = (VNRequest, VNRequestType ,Error?) -> Swift.Void

public class VisionManafer: NSObject {
    
    //Machine-Learning Image Analysis
    //func objDetectionUsingCoreML(pixelBuffer:CVPixelBuffer) -> Void {
    func objDetectionUsingCoreML(cgImage:CGImage ,completeHandler:@escaping MyVNRequestCompletionHandler) -> Void {
        
        let model = try! VNCoreMLModel(for: Resnet50().model)
        
        //let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer)
        let handler = VNImageRequestHandler(cgImage: cgImage)
        
        let request = VNCoreMLRequest(model: model, completionHandler:{ (request: VNRequest, error: Error?) in
            
            completeHandler(request ,VNRequestType.ObjDectectCoreML ,error)
        });
        
        try! handler.perform([request])//传入request数组，即可以针对同一图片，做多种识别处理
    }
    
    //Object Tracking
    func objTracking(pixelBuffer:CVPixelBuffer) -> Void {
        
        //let request = VNtr
    }
    
    
    //Rectangle Detection
    func rectangleDetection(cgImage:CGImage ,completeHandler:@escaping MyVNRequestCompletionHandler) -> Void {
        
        let handler = VNImageRequestHandler(cgImage: cgImage)
        let request = VNDetectRectanglesRequest { (request: VNRequest, error : Error?) in
            
            completeHandler(request, VNRequestType.ObjDectectCoreML, error)
        }
        try! handler.perform([request])
    }
    
    //Face Rectangle Detection
    func faceRectangleDetection(cgImage:CGImage ,completeHandler:@escaping MyVNRequestCompletionHandler) -> Void {
        
        let handler = VNImageRequestHandler(cgImage: cgImage)
        let request = VNDetectFaceRectanglesRequest { (request: VNRequest, error : Error?) in
            
            completeHandler(request, VNRequestType.FaceRectangle, error)
        }
        try! handler.perform([request])
    }
    
    //Face Landmark Detection(eyes,mouth e.g.)
    func faceLandmarkDetection(cgImage: CGImage ,completeHandler:@escaping MyVNRequestCompletionHandler) ->Void {
        
        let handler = VNImageRequestHandler(cgImage: cgImage)
        
        let request = VNDetectFaceLandmarksRequest { (request: VNRequest, error :Error?) in
            
            completeHandler(request, VNRequestType.FaceLandmark, error)
        }
        try! handler.perform([request])
    }
    
}
