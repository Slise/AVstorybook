//
//  Model.m
//  AVstorybook
//
//  Created by Benson Huynh on 2016-01-29.
//  Copyright © 2016 Benson Huynh. All rights reserved.
//

#import "Model.h"

@interface Model ()

@property (nonatomic) NSURL *audioFilePath;
@property (nonatomic) NSURL *imageFilePath;
@property (nonatomic) int page;

@end

@implementation Model

- (instancetype)init
{
    self = [super init];
    if (self) {
        _audioFilePath = [NSURL new];
        _imageFilePath = [NSURL new];
        _page = -1;
    }
    return self;
}

- (instancetype)initWith:(int)page
{
    self = [super init];
    if (self) {
        _audioFilePath = [NSURL new];
        _imageFilePath = [NSURL new];
        _page = page;
    }
    return self;
}

-(void) setImageFilePath:(NSURL *)imageFilePath {
    _imageFilePath = imageFilePath;
}

-(void) setAudioFilePath:(NSURL *)audioFilePath
{
    _audioFilePath = audioFilePath;
}

-(int) getPage {
    return _page;
}

-(NSURL*) getAudioFilePath {
    return _audioFilePath;
}

-(NSURL*) getImageFilePath {
    return _imageFilePath;
}

@end
