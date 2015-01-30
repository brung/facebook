//
//  SettingsViewController.h
//  FacebookDemo
//
//  Created by Doupan Guo on 1/29/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SettingsViewController;

@protocol SettingsViewControllerDelegate <NSObject>

- (void)settingsViewController:(SettingsViewController *) setttingsViewController didChangeSettings: (NSInteger)setting;

@end

@interface SettingsViewController : UIViewController

@property (nonatomic, weak)id<SettingsViewControllerDelegate> delegate;
@end
