//
//  ViewController.m
//  OpenWebViewNeedAuthentication
//
//  Created by Thieu Mao on 3/10/17.
//  Copyright © 2017 thieumao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSURLConnection *connection;
@end

@implementation ViewController

- (void)viewDidLoad {
    NSLog(@"ViewController viewDidLoad");
    [super viewDidLoad];
    [self loadWebview];
    NSURL *url = [NSURL URLWithString:@"http://42.119.128.237/"];
    NSMutableURLRequest *request;
    request = [NSMutableURLRequest requestWithURL:url
                                      cachePolicy:NSURLRequestReloadIgnoringCacheData
                                  timeoutInterval:12];
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately: YES];
}
-(void)loadWebview
{
    NSURL *url = [NSURL URLWithString:@"http://42.119.128.237/"];
    
    NSMutableURLRequest *request;
    request = [NSMutableURLRequest requestWithURL:url
                                      cachePolicy:NSURLRequestReloadIgnoringCacheData
                                  timeoutInterval:12];
    [_webView loadRequest:request];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    return YES;
}


//Then
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    NSLog(@"ViewController didReceiveAuthenticationChallenge %@", challenge);
    NSURLCredential * cred = [NSURLCredential credentialWithUser:@"admin"
                                                        password:@"test"
                                                     persistence:NSURLCredentialPersistenceForSession];
    [[NSURLCredentialStorage sharedCredentialStorage]setCredential:cred forProtectionSpace:[challenge protectionSpace]];
    [self loadWebview];
}

- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection
{
    return YES;
}

@end
