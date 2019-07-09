//
//  CharAnimationVC.m
//  CharAnimation
//
//  Created by magic on 2019/7/9.
//  Copyright © 2019 magic. All rights reserved.
//

#import "CharAnimationVC.h"
#import "OpenCVHelper.h"
#import "CVAnimateStringModel.h"
#import "CVVideoModel.h"
#import <Photos/Photos.h>


@interface CharAnimationVC ()
@property (weak, nonatomic) IBOutlet UILabel *imageLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) CVVideoModel *videoModel;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, assign) BOOL animationStart;

@end

@implementation CharAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareLoadVideo];
}

-(void)prepareLoadVideo{
    if (self.fileUrl) {
        NSString * fileUrl = self.fileUrl;
        if ([fileUrl hasPrefix:@"file://"]) {
            fileUrl = [fileUrl substringFromIndex:7];
        }
        
        AVURLAsset *asset =[[AVURLAsset alloc] initWithURL:[NSURL URLWithString:_fileUrl] options:nil];
        NSArray *array = asset.tracks;
        
        CGSize videoSize = CGSizeZero;
        
        for(AVAssetTrack  *track in array)
        {
            
            if([track.mediaType isEqualToString:AVMediaTypeVideo])
            {
                videoSize = track.naturalSize;
            }
        }
        [self loadVideoWithFileUrl:fileUrl andSize:videoSize];
    }
}
-(void)loadVideoWithFileUrl:(NSString *)fileUrl andSize:(CGSize)siz{
    CGFloat ratio = siz.width/siz.height;
    SizeT size;
    size.width = 64;
    size.height = 64/ratio;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        CVVideoModel *videoModel = [[OpenCVHelper shareInstance] processVideo:fileUrl withSize:size processPercent:^(CGFloat percent) {
            self.imageLabel.text = [NSString stringWithFormat:@"已加载: %.2f%%", percent * 100];
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.videoModel = videoModel;
            
        });
    });
    
}

- (void)setVideoModel:(CVVideoModel *)videoModel {
    _videoModel = videoModel;
    [self startAnimate];
    
}

- (void)startAnimate {
    if (_animationStart) return;
    
    _animationStart = true;
    
    self.imageLabel.font = [OpenCVHelper defaultFont];
    
    [self showAnimate];
}

- (void)showAnimate {
    if (_currentIndex >= self.videoModel.animatedList.count) return;
    
    CVAnimateStringModel *model = self.videoModel.animatedList[self.currentIndex];
    
    self.imageLabel.text = model.animateString;
    
    self.imageView.image = model.image;
    
    self.currentIndex ++;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.videoModel.frameDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showAnimate];
    });
}


-(void)setFileUrl:(NSString *)fileUrl{
    _fileUrl = fileUrl;
    
}



@end
