//
//  StoryPartViewController.m
//  AVstorybook
//
//  Created by Benson Huynh on 2016-01-29.
//  Copyright © 2016 Benson Huynh. All rights reserved.
//

#import "StoryPartViewController.h"

@interface StoryPartViewController ()

@property (nonatomic) AVAudioSession *session;
@property (nonatomic) AVAudioRecorder *audioRecorder;
@property (nonatomic) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;
@property (weak, nonatomic) IBOutlet UIButton *micButton;
@property (weak, nonatomic) IBOutlet UILabel *pageLabel;

@end

@implementation StoryPartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.cameraButton setTitle:@"Get Picture" forState:UIControlStateNormal];
    [self.micButton setTitle:@"Record Audio" forState:UIControlStateNormal];
    
    if (!self.model) {
        self.model = [Model new];
    }
    self.pageLabel.text = [NSString stringWithFormat:@"%i", [self.model getPage]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidAppear:(BOOL)animated {
    [self.audioPlayer stop];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    if (self.imagePicker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
    
    if (!self.model) {
        [self.model setImageFilePath: [info objectForKey: UIImagePickerControllerMediaURL]];
    }
    
    self.imageView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    if (flag) {
        [self.model setAudioFilePath:recorder.url];
    } else {
        NSLog(@"Unable to record audio");
    }
}

-(void) playAudio {
    if ([self.audioPlayer isPlaying]) {
        [self.audioPlayer stop];
    } else {
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[self.model getAudioFilePath] error:nil];
        [self.audioPlayer play];
    }
}

- (IBAction)grabPicture:(UIButton *)sender {
    self.imagePicker = [UIImagePickerController new];
    self.imagePicker.delegate = self;
    self.imagePicker.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    self.imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:self.imagePicker.sourceType];
    [self presentViewController:self.imagePicker animated:NO completion:nil];
}

- (IBAction)recordAdio:(UIButton *)sender {
    
    if ([self.micButton.titleLabel.text isEqualToString:@"Start Recording"]) {
        [self.micButton setTitle:@"Stop Recording" forState:UIControlStateNormal];
        
        NSString *dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)[0];
        NSString *recordingName = @"avstorybookaudio_";
        recordingName = [recordingName stringByAppendingString:[NSString stringWithFormat:@"%i",[self.model getPage]]];
        NSArray *pathArray = @[dirPath,recordingName];
        NSURL *filePath  = [NSURL fileURLWithPathComponents:pathArray];
        
        self.session = [AVAudioSession sharedInstance];
        [self.session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        
        NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
        
        [recordSetting setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
        [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
        [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
        
        [recordSetting setValue :[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
        [recordSetting setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
        [recordSetting setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
        
        self.audioRecorder = [[AVAudioRecorder alloc] initWithURL:filePath settings:recordSetting error:nil];
        self.audioRecorder.delegate = self;
        self.audioRecorder.meteringEnabled = YES;
        [self.audioRecorder prepareToRecord];
        [self.audioRecorder record];
        } else {
        [self.micButton setTitle:@"Record Audio" forState:UIControlStateNormal];
        [self.audioRecorder stop];
        [self.session setActive:NO error:nil];
    }
}

- (IBAction)tapDetected:(UITapGestureRecognizer *)sender {
    [self playAudio];
}

@end
