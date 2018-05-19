//
//  ResponseViewController.m
//  WorldSnake Example
//
//  Created by Panghu on 2018/5/21.
//  Copyright © 2018 Panghu Lee. All rights reserved.
//

#import "ResponseViewController.h"

@import WorldSnake;

@interface ResponseViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) WorldSnakeResult *result;
@property (nonatomic, strong) NSURLResponse *response;
@property (nonatomic, strong) NSArray <NSURLQueryItem *> *headers;

@end

@implementation ResponseViewController

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
        cell.detailTextLabel.numberOfLines = 6;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.numberOfLines = 0;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 0) {
        NSURLQueryItem *queryItem = self.headers[indexPath.item];
        cell.textLabel.text = queryItem.name;
        cell.detailTextLabel.text = queryItem.value;
    } else {
        cell.detailTextLabel.text = nil;
        cell.textLabel.text = [self.result.responseObject description];
        cell.textLabel.text = cell.textLabel.text ? : [self.error description];
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.headers.count;
    } else if (section == 1) {
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 44;
    } else {
        static UITableViewCell *cell = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:NSStringFromClass(UITableViewCell.class)];
            cell.textLabel.numberOfLines = 0;
        });
        cell.textLabel.text = [self.result.responseObject description];
        cell.textLabel.text = cell.textLabel.text ? : [self.error description];
        return [cell sizeThatFits:(tableView.frame.size)].height;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        if ([self.response isKindOfClass:NSHTTPURLResponse.class]) {
            return [NSString stringWithFormat:@"Headers\t\t HTTPStatus: %d", (int)((NSHTTPURLResponse *)self.response).statusCode];
        } else {
            return @"Headers";
        }
    } else if (section == 1) {
        return @"Body";
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return section == 1 ? [NSString stringWithFormat:@"Elapsed Time: %.5f sec", self.result.timeline.endTime - self.result.timeline.startTime] : nil;
}

- (void)setResponse:(NSURLResponse * _Nullable)response result:(WorldSnakeResult * _Nullable)result error:(NSError * _Nullable)error {
    self.response = response;
    self.result = result;
    self.error = error;
    
    self.headers = nil;
    if ([self.response isKindOfClass:NSHTTPURLResponse.class]) {
        NSMutableArray *array = NSMutableArray.new;
        [[(NSHTTPURLResponse *)response allHeaderFields] enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [array addObject:[NSURLQueryItem queryItemWithName:key value:obj]];
        }];
        self.headers = array;
    }
    [self.tableView reloadData];
}

- (void)setupUI {
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.refreshControl];
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

@end
