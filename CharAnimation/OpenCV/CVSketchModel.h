//
//  CVSketchModel.h
//  OpenCVDemo
//
//  Created by magic on 2019/7/9.
//  Copyright © 2019 magic. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CVSketchModel : NSObject

@property (nonatomic, strong) NSArray <UIImage *>* animatedList;

@property (nonatomic, assign) NSTimeInterval frameDuration;

@end

NS_ASSUME_NONNULL_END
