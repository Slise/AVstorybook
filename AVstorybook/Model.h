//
//  Model.h
//  AVstorybook
//
//  Created by Benson Huynh on 2016-01-29.
//  Copyright © 2016 Benson Huynh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

- (instancetype)initWith:(int)page;

-(void) setAudioFilePath:(NSURL *)audioFilePath;
-(void) setImageFilePath:(NSURL *)imageFilePath;
-(int) getPage;

-(NSURL*) getAudioFilePath;
-(NSURL*) getImageFilePath;

@end
