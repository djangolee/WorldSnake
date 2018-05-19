//
//  DetailViewController.m
//  WorldSnake Example
//
//  Created by Panghu Lee on 2018/5/19.
//  Copyright © 2018 Panghu Lee. All rights reserved.
//

#import "DetailViewController.h"

#import "RequestViewController.h"
#import "ResponseViewController.h"
#import "URLComponetsViewController.h"

@import WorldSnake;

@interface DetailViewController ()

@property (nonatomic, strong) RequestViewController *requestViewController;
@property (nonatomic, strong) ResponseViewController *responseViewController;
@property (nonatomic, strong) URLComponetsViewController *urlComponetsViewController;

@property (nonatomic, strong) UIViewController *currentViewController;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@property (nonatomic, strong) WSURLComponents *URLComponents;
@property (nonatomic, strong) NSURLSessionTask *task;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) WorldSnakeResult *result;

@end

@implementation DetailViewController

- (instancetype)initWithRequest:(id <WSEncodingURLRequestConvertible>)URLRequest {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _URLComponents = [[WSURLComponents alloc] initWithURLRequest:URLRequest];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self onValueChangeRefresh:nil];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}
    
- (void)onValueChangeRefresh:(UIRefreshControl *)sender {
    __weak typeof(self) weakSelf = self;
    WorldSnakeSession
    .dataRequest(self.URLComponents)
    .response
    .scheduling(dispatch_get_main_queue())
    .progress(^(NSProgress *progress) {
        NSLog(@"%@", progress);
    })
    .success(^(NSURLSessionDataTask *task, WorldSnakeDataResult * _Nullable result) {
        weakSelf.task = task;
        weakSelf.result = result;
        weakSelf.error = nil;
        [weakSelf reloadData];
        [sender endRefreshing];
    })
    .failure(^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        weakSelf.task = task;
        weakSelf.result = nil;
        weakSelf.error = error;
        [weakSelf reloadData];
        [sender endRefreshing];
    });
}

- (void)reloadData {
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        self.urlComponetsViewController.URLComponents = self.URLComponents;
    } else if (self.segmentedControl.selectedSegmentIndex == 1) {
        self.requestViewController.request = self.task.currentRequest;
    } else {
        [self.responseViewController setResponse:self.task.response result:self.result error:self.error];
    }
}

- (void)onValueChangeSegmented:(UIControl *)sender {
    UIViewController *viewController = nil;
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        viewController = self.urlComponetsViewController;
        self.urlComponetsViewController.URLComponents = self.URLComponents;
    } else if (self.segmentedControl.selectedSegmentIndex == 1) {
        viewController = self.requestViewController;
        self.requestViewController.request = self.task.currentRequest;
    } else {
        viewController = self.responseViewController;
        [self.responseViewController setResponse:self.task.response result:self.result error:self.error];
    }
    if (viewController == self.currentViewController) return;
    
    [self addChildViewController:viewController];
    [self.view addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];
    
    viewController.view.bounds = self.view.bounds;
    viewController.view.center = CGPointMake(self.view.center.x + CGRectGetWidth(self.view.frame), self.view.center.y);
    if (self.currentViewController) {
        [UIView animateWithDuration:0.25 animations:^{
            self.currentViewController.view.center = CGPointMake(self.view.center.x - CGRectGetWidth(self.view.frame), self.view.center.y);
            viewController.view.center = self.view.center;
        } completion:^(BOOL finished) {
            [self.currentViewController willMoveToParentViewController:nil];
            [self.currentViewController removeFromParentViewController];
            [self.currentViewController.view removeFromSuperview];
            self.currentViewController = viewController;
        }];
    } else {
        viewController.view.center = self.view.center;
        self.currentViewController = viewController;
    }
}

- (void)setupUI {
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.titleView = self.segmentedControl;
}

#pragma mark Getter

- (UISegmentedControl *)segmentedControl {
    if (!_segmentedControl) {
        _segmentedControl = UISegmentedControl.new;
        [_segmentedControl insertSegmentWithTitle:@"URLComponets" atIndex:0 animated:NO];
        [_segmentedControl insertSegmentWithTitle:@"Request" atIndex:1 animated:NO];
        [_segmentedControl insertSegmentWithTitle:@"Response" atIndex:2 animated:NO];
        _segmentedControl.selectedSegmentIndex = 0;
        [self onValueChangeSegmented:_segmentedControl];
        [_segmentedControl addTarget:self action:@selector(onValueChangeSegmented:) forControlEvents:(UIControlEventValueChanged)];
    }
    return _segmentedControl;
}

- (RequestViewController *)requestViewController {
    if (!_requestViewController) {
        _requestViewController = RequestViewController.new;
    }
    return _requestViewController;
}

- (ResponseViewController *)responseViewController {
    if (!_responseViewController) {
        _responseViewController = ResponseViewController.new;
        [_responseViewController.refreshControl addTarget:self action:@selector(onValueChangeRefresh:) forControlEvents:(UIControlEventValueChanged)];
    }
    return _responseViewController;
}

- (URLComponetsViewController *)urlComponetsViewController {
    if (!_urlComponetsViewController) {
        _urlComponetsViewController = URLComponetsViewController.new;
    }
    return _urlComponetsViewController;
}

@end
