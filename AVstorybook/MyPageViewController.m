//
//  MyPageViewController.m
//  AVstorybook
//
//  Created by Benson Huynh on 2016-01-29.
//  Copyright © 2016 Benson Huynh. All rights reserved.
//

#import "MyPageViewController.h"
#import "StoryPartViewController.h"
#import "Model.h"

@interface MyPageViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic) NSMutableArray *modelArray;
@property (nonatomic,strong) NSArray *storyViewControllerArray;

@end

@implementation MyPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = self;
    self.delegate = self;
    
    StoryPartViewController *story1 = [self.storyboard instantiateViewControllerWithIdentifier:@"storyPage"];
    StoryPartViewController *story2 = [self.storyboard instantiateViewControllerWithIdentifier:@"storyPage"];
    StoryPartViewController *story3 = [self.storyboard instantiateViewControllerWithIdentifier:@"storyPage"];
    StoryPartViewController *story4 = [self.storyboard instantiateViewControllerWithIdentifier:@"storyPage"];
    StoryPartViewController *story5 = [self.storyboard instantiateViewControllerWithIdentifier:@"storyPage"];
    
    self.storyViewControllerArray = @[story1,story2,story3,story4,story5];
    self.modelArray = [NSMutableArray new];
    
    for (int i=0; i<5; i++) {
        Model *newModel = [[Model alloc] initWith:i];
        [self.modelArray addObject:newModel];
    }
    
    [story1 setModel:self.modelArray[0]];
    [self setViewControllers:@[self.storyViewControllerArray[0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
    }];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    StoryPartViewController *currentPage = (StoryPartViewController*)viewController;
    
    int currentPageNo = [currentPage.model getPage];
    
    switch (currentPageNo) {
        case 0:
            return nil;
        default: {
            Model *prevModel = [self.modelArray objectAtIndex:currentPageNo-1];
            [self.storyViewControllerArray[currentPageNo-1] setModel: prevModel];
            return self.storyViewControllerArray[currentPageNo-1];
            break;
        }
    }
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    StoryPartViewController *currentPage = (StoryPartViewController*)viewController;
    int currentPageNo = [currentPage.model getPage];
    
    switch (currentPageNo) {
        case 4:
            return nil;
            break;
        default: {
            Model *nextModel = [self.modelArray objectAtIndex:currentPageNo+1];
            [self.storyViewControllerArray[currentPageNo+1] setModel:nextModel];
            return self.storyViewControllerArray[currentPageNo+1];
            break;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
