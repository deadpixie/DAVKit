//
//  ocDAVViewController.m
//  DAVKit
//
//  Created by Björn Perrech on 09/12/2015.
//  Copyright (c) 2015 Björn Perrech. All rights reserved.
//

#import "ocDAVViewController.h"

@interface ocDAVViewController ()

@end

@implementation ocDAVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.addressField setText:[[NSUserDefaults standardUserDefaults] stringForKey:@"LastUsedURL"] ];
    [self.userNameField setText:[[NSUserDefaults standardUserDefaults] stringForKey:@"LastUsedUser"] ];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)go:(id)sender
{
    NSURL *url = [NSURL URLWithString:[self.addressField text]];

    if (url)
    {
        [self.activityIndicator startAnimating];
        [self.label setText:@"Am laden dranne..."];

        
        DAVCredentials *credentials = [DAVCredentials credentialsWithUsername:[self.userNameField text] password:[self.passwordField text]];
        DAVSession *session = [[DAVSession alloc]  initWithRootURL:url credentials:credentials];
        [session setAllowUntrustedCertificate:YES];
        
        DAVGetRequest *getRequest = [[DAVGetRequest alloc] initWithPath:@"index.html"];
        [getRequest setDelegate:self];
        
        [session enqueueRequest:getRequest];

        [[NSUserDefaults standardUserDefaults] setObject:[self.addressField text] forKey:@"LastUsedURL"];
        [[NSUserDefaults standardUserDefaults] setObject:[self.userNameField text] forKey:@"LastUsedUser"];

        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
}




// The error can be a NSURLConnection error or a WebDAV error
- (void)request:(DAVRequest *)aRequest didFailWithError:(NSError *)error
{
    [self.label setText:@"Alte Scheiße! Ein Fehler!! Wat soll dat denn werden?!"];
    ;

    [self.activityIndicator stopAnimating];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:error.description preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Ach du Scheiße! Und jetzt?" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];

}
// The resulting object varies depending on the request type
- (void)request:(DAVRequest *)aRequest didSucceedWithResult:(id)result;
{
    [self.label setText:@"Läuft. Da hasse..."];

    [self.webview loadData:result MIMEType:@"text/html" textEncodingName:@"utf-8" baseURL:[NSURL URLWithString:[self.addressField text]]];

    [self.activityIndicator stopAnimating];
}
@end
