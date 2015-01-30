//
//  SwitchCell.h
//  FacebookDemo
//
//  Created by Doupan Guo on 1/29/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SwitchCell;
@protocol SwitchCellDelegate <NSObject>

- (void)switchCell:(SwitchCell *)cell didChangeValue:(BOOL)value;

@end

@interface SwitchCell : UITableViewCell
@property (nonatomic, assign) BOOL on;
@property (nonatomic, weak) id<SwitchCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *switchLabel;

- (void)setOn:(BOOL)on animated:(BOOL)animated;

@end
