//
//  RequestViewController.m
//  WorldSnake Example
//
//  Created by Panghu on 2018/5/21.
//  Copyright © 2018 Panghu Lee. All rights reserved.
//

#import "RequestViewController.h"

@import WorldSnake;

@interface RequestViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (nonatomic, strong) WSURLComponents *URLComponents;

@end

@implementation RequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

#pragma mark UITableViewDelegate, UITableViewDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class)];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:NSStringFromClass(UITableViewCell.class)];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 0) {
        NSURLQueryItem *queryItem = self.URLComponents.URLHeadComponents.queryItems[indexPath.item];
        cell.textLabel.text = queryItem.name;
        cell.detailTextLabel.text = queryItem.value;
    } else if (indexPath.section == 1) {
        NSURLQueryItem *queryItem = self.URLComponents.URLComponents.queryItems[indexPath.item];
        cell.textLabel.text = queryItem.name;
        cell.detailTextLabel.text = queryItem.value;
    } else if (indexPath.section == 2) {
        NSString *name = nil;
        NSString *value = nil;
        
        switch (indexPath.item) {
            case 0:
                name = @"scheme";
                value = self.URLComponents.URLComponents.scheme;
                break;
            case 1:
                name = @"user";
                value = self.URLComponents.URLComponents.user;
                break;
            case 2:
                name = @"password";
                value = self.URLComponents.URLComponents.password;
                break;
            case 3:
                name = @"host";
                value = self.URLComponents.URLComponents.host;
                break;
            case 4:
                name = @"port";
                value = self.URLComponents.URLComponents.port.stringValue;
                break;
            case 5:
                name = @"path";
                value = self.URLComponents.URLComponents.path;
                break;
            default:
                break;
        }
        
        cell.textLabel.text = name;
        cell.detailTextLabel.text = value;
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.URLComponents.URLHeadComponents.queryItems.count;
    } else if (section == 1) {
        return self.URLComponents.URLComponents.queryItems.count;
    } else if (section == 2) {
        return 6;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Headers";
    } else if (section == 1) {
        return @"QueryItems";
    } else if (section == 2) {
        return @"Ohter";
    }
    return nil;
}

- (void)setupUI {
    [self.view addSubview:self.tableView];
}

#pragma mark Getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UIRefreshControl *)refreshControl {
    if (!_refreshControl) {
        _refreshControl = UIRefreshControl.new;
    }
    return _refreshControl;
}

- (void)setRequest:(NSURLRequest *)request {
    _request = request;
    self.URLComponents = [[WSURLComponents alloc] initWithURLRequest:request];
    [self.tableView reloadData];
}

@end
