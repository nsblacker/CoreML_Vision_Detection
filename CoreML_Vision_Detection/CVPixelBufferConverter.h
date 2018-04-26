//
//  CVPixelBufferConverter.h
//  CoreML_Vision_Detection
//
//  Created by kahn on 2018/4/26.
//  Copyright © 2018年 NSblakcer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface CVPixelBufferConverter : NSObject
+ (CVPixelBufferRef)pixelBufferFromCGImage:(CGImageRef)image;
@end
