//
//  UIImage+VisionExtension.swift
//  CoreML_Vision_Detection
//
//  Created by kahn on 2018/4/26.
//  Copyright © 2018年 NSblakcer. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics
extension UIImage{
    
    func addDetectBoxes(uiImage: UIImage ,boxes: NSArray) -> UIImage {
        
        var newImage: UIImage?
        //let context = UIGraphicsBeginImageContext(uiImage.size)
        for rect in boxes {
            //draw rect
//            CGContextSetRGBStrokeColor(context, 0.18, 0.72, 0.95, 0.95);//rect color
//            CGContextSetLineWidth(context, 2.0);
//            CGContextAddRect(context, rect);
//            CGContextStrokePath(context);
        }
        
        uiImage = UIGraphicsGetImageFromCurrentImageContext()
        return uiImage;
    }
    public func pixelBuffer(width: Int, height: Int) -> CVPixelBuffer? {
        var maybePixelBuffer: CVPixelBuffer?
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue,
                     kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue]
        let status = CVPixelBufferCreate(kCFAllocatorDefault,
                                         Int(width),
                                         Int(height),
                                         kCVPixelFormatType_32ARGB,
                                         attrs as CFDictionary,
                                         &maybePixelBuffer)
        
        guard status == kCVReturnSuccess, let pixelBuffer = maybePixelBuffer else {
            return nil
        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer)
        
        guard let context = CGContext(data: pixelData,
                                      width: Int(width),
                                      height: Int(height),
                                      bitsPerComponent: 8,
                                      bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer),
                                      space: CGColorSpaceCreateDeviceRGB(),
                                      bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
            else {
                return nil
        }
        
        context.translateBy(x: 0, y: CGFloat(height))
        context.scaleBy(x: 1, y: -1)
        
        UIGraphicsPushContext(context)
        self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        UIGraphicsPopContext()
        CVPixelBufferUnlockBaseAddress(pixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
        
        return pixelBuffer
    }
}

/*
 func buffer(from image: UIImage) -> CVPixelBuffer? {
 let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
 var pixelBuffer : CVPixelBuffer?
 let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(image.size.width), Int(image.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
 guard (status == kCVReturnSuccess) else {
 return nil
 }
 
 CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
 let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
 
 let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
 let context = CGContext(data: pixelData, width: Int(image.size.width), height: Int(image.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
 
 context?.translateBy(x: 0, y: image.size.height)
 context?.scaleBy(x: 1.0, y: -1.0)
 
 UIGraphicsPushContext(context!)
 image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
 UIGraphicsPopContext()
 CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
 
 return pixelBuffer
 }
 */
