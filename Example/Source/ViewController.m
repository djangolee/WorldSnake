//
//  ViewController.m
//  WorldSnake Example
//
//  Created by Panghu Lee on 2018/5/19.
//  Copyright © 2018 Panghu Lee. All rights reserved.
//

#import "ViewController.h"

@import WorldSnake;
#import "DetailViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo"]];
    self.navigationItem.titleView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:self.tableView];
}

#pragma mark UITableViewDelegate, UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO animated:YES];
    WSURLComponents *URLRequest = [[WSURLComponents alloc] initWithURL:@"http://httpbin.org"];
    URLRequest
    .query.adding.item([NSURLQueryItem queryItemWithName:@"中文" value:@"😊"]);
    URLRequest
    .query.adding.item([NSURLQueryItem queryItemWithName:@"中文中文" value:@"😊😊"]);
    URLRequest
    .query.adding.item([NSURLQueryItem queryItemWithName:@"中文文" value:@"文😊"]);
    
    URLRequest
    .head.adding.item([NSURLQueryItem queryItemWithName:@"header1" value:@"value1"]);
    URLRequest
    .head.adding.item([NSURLQueryItem queryItemWithName:@"header2" value:@"value2"]);
    URLRequest
    .head.adding.item([NSURLQueryItem queryItemWithName:@"header3" value:@"value3"]);
    
    
    URLRequest.query.adding.item([NSURLQueryItem queryItemWithName:@"名字" value:@"Value"]);
    if (indexPath.section == 0) {
        if (indexPath.item == 0) {
            URLRequest.path.set.string(@"/get");
        } else if (indexPath.item == 1) {
            URLRequest.path.set.string(@"/post");
        } else if (indexPath.item == 2) {
            URLRequest.path.set.string(@"/put");
        } else if (indexPath.item == 3) {
            URLRequest.path.set.string(@"/delete");
        }
    } else if (indexPath.section == 1) {
        if (indexPath.item == 0) {

        } else if (indexPath.item == 1) {

        }
    } else if (indexPath.section == 2) {
        if (indexPath.item == 0) {

        } else if (indexPath.item == 1) {

        }
    }
    [self.navigationController pushViewController:[[DetailViewController alloc] initWithRequest:URLRequest] animated:YES];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class)];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        if (indexPath.item == 0) {
            cell.textLabel.text = @"GET Request";
        } else if (indexPath.item == 1) {
            cell.textLabel.text = @"POST Request";
        } else if (indexPath.item == 2) {
            cell.textLabel.text = @"PUT Request";
        } else if (indexPath.item == 3) {
            cell.textLabel.text = @"DELETE Request";
        }
    } else if (indexPath.section == 1) {
        if (indexPath.item == 0) {
            cell.textLabel.text = @"Download Data";
        } else if (indexPath.item == 1) {
            cell.textLabel.text = @"Download File";
        }
    } else if (indexPath.section == 2) {
        if (indexPath.item == 0) {
            cell.textLabel.text = @"Upload Data";
        } else if (indexPath.item == 1) {
            cell.textLabel.text = @"Upload File";
        }
    }
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    } else if (section == 1) {
        return 2;
    } else if (section == 2) {
        return 2;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Data";
    }
    if (section == 1) {
        return @"Download";
    }
    if (section == 2) {
        return @"Upload";
    }
    return nil;
}

#pragma mark Getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    }
    return _tableView;
}

@end
