//
//  CVVideoModel.h
//  OpenCVDemo
//
//  Created by magic on 2019/7/9.
//  Copyright © 2019 magic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CVAnimateStringModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CVVideoModel : NSObject

@property (nonatomic, copy) NSArray <CVAnimateStringModel *>* animatedList;

@property (nonatomic, assign) NSTimeInterval frameDuration;

@end

NS_ASSUME_NONNULL_END
