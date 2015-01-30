//
//  SettingsViewController.m
//  FacebookDemo
//
//  Created by Doupan Guo on 1/29/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

#import "SettingsViewController.h"
#import "SwitchCell.h"

@interface SettingsViewController () <UITableViewDataSource, UITableViewDelegate, SwitchCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *settings;
@property (nonatomic) NSInteger currentSelection;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(onLeftButton)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style:UIBarButtonItemStylePlain target:self action:@selector(onRightButton)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    self.settings = @[@"Home Feed", @"Photos", @"Movies", @"Books"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:@"SwitchCell" bundle:nil] forCellReuseIdentifier:@"SwitchCell"];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.settings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SwitchCell"];
    cell.switchLabel.text = self.settings[indexPath.row];
    if (indexPath.row == self.currentSelection) {
        [cell setOn:YES];
    } else {
        [cell setOn:NO];
    }
    cell.delegate = self;
    return cell;
}

- (void)switchCell:(SwitchCell *)cell didChangeValue:(BOOL)value {
    NSLog(@"Called didChangeValue");
    if (value) {
        self.currentSelection = [self.tableView indexPathForCell:cell].row;
        [self.tableView reloadData];
    }
}

#pragma mark - Private methods
- (void)onLeftButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onRightButton {
    
    [self.delegate settingsViewController:self didChangeSettings:self.currentSelection];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation
 


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
