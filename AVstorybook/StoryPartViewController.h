//
//  StoryPartViewController.h
//  AVstorybook
//
//  Created by Benson Huynh on 2016-01-29.
//  Copyright © 2016 Benson Huynh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Model.h"

@interface StoryPartViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationBarDelegate, AVAudioRecorderDelegate>

@property (strong, nonatomic) Model *model;

@end
