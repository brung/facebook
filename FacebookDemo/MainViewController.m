//
//  MainViewController.m
//  FacebookDemo
//
//  Created by Timothy Lee on 10/22/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

#import "MainViewController.h"
#import "NodeTableViewCell.h"
#import "SettingsViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface MainViewController () <UITableViewDelegate, UITableViewDataSource, SettingsViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NodeTableViewCell *protoTypeCell;
@property (nonatomic, strong) NSArray *endPoints;
@property (nonatomic) NSInteger current;

@property (strong, nonatomic) NSArray *dataArray;
- (void)reload;

@end

@implementation MainViewController

- (NodeTableViewCell *)protoTypeCell {
    if (!_protoTypeCell) {
        _protoTypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"NodeTableViewCell"];
    }
    return _protoTypeCell;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Configure the right button
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onRightButton)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    self.current = 0;
    self.endPoints = @[@"me/home", @"me/photos", @"me/movies", @"me/books"];
    UINib *movieCellNib = [UINib nibWithNibName:@"NodeTableViewCell" bundle:nil];
    [self.tableView registerNib:movieCellNib forCellReuseIdentifier:@"NodeTableViewCell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self reload];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NodeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NodeTableViewCell" forIndexPath:indexPath];
    [self configureCell:cell forRowAtIndexPat:indexPath];
    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (void)configureCell: (UITableViewCell *)cell forRowAtIndexPat: (NSIndexPath *)indexPath {
    if ([cell isKindOfClass:[NodeTableViewCell class]]) {
        NodeTableViewCell *nodeCell = (NodeTableViewCell *)cell;
        NSDictionary *dict = self.dataArray[indexPath.row];
        nodeCell.nameLabel.text = [dict valueForKeyPath:@"from.name"];
        nodeCell.typeLabel.text = dict[@"type"];
        nodeCell.statusLabel.text = dict[@"status_type"];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    [self configureCell:self.protoTypeCell forRowAtIndexPat:indexPath];
    [self.protoTypeCell layoutIfNeeded];
    
    CGSize size = [self.protoTypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1;
}

- (void)settingsViewController:(SettingsViewController *)setttingsViewController didChangeSettings:(NSInteger)setting {
    NSLog(@"new setting: %ld", setting);
    self.current = setting;
    [self reload];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Private methods
- (void)onRightButton {
    NSLog(@"clicked settings");
    SettingsViewController *vc = [[SettingsViewController alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.delegate = self;
    [self presentViewController:nvc animated:YES completion:nil];
}

- (void)reload {
    [FBRequestConnection startWithGraphPath:self.endPoints[self.current]
                                 parameters:nil
                                 HTTPMethod:@"GET"
                          completionHandler:^(
                                              FBRequestConnection *connection,
                                              id result,
                                              NSError *error
                                              ) {
                              /* handle the result */
                              NSLog(@"result: %@", result);
                              self.dataArray = result[@"data"];
                              [self.tableView reloadData];
                          }];
}

@end
