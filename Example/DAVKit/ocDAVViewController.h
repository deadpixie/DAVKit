//
//  ocDAVViewController.h
//  DAVKit
//
//  Created by Björn Perrech on 09/12/2015.
//  Copyright (c) 2015 Björn Perrech. All rights reserved.
//

@import UIKit;
#import <DAVKit/DAVKit.h>

@interface ocDAVViewController : UIViewController <DAVRequestDelegate>

@property (nonatomic, strong) NSURL* theURL;

@property IBOutlet UILabel *label;
@property IBOutlet UIWebView *webview;

@property IBOutlet UITextField *addressField;
@property IBOutlet UITextField *userNameField;
@property IBOutlet UITextField *passwordField;
@property IBOutlet UIActivityIndicatorView *activityIndicator;

- (IBAction)go:(id)sender;
@end
