//
//  WelcomeViewController.m
//  Tusky
//
//  Created by Hendy Chua on 12/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (IBAction)createAccount:(id)sender
{
	NSLog(@"Create new account button clicked.");

	[self performSegueWithIdentifier:@"createNewAccountSegue" sender:self];

}

- (IBAction)login:(id)sender
{
	NSLog(@"Login button clicked.");
	
	[self performSegueWithIdentifier:@"loginSegue" sender:self];
	
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.navigationItem.hidesBackButton = YES;
	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:1.0 green:0.3 blue:0.0 alpha:0.5];
	
	//Create welcome image
	CGFloat imageWidth = 250;
	CGFloat imageHeight = 250;
	CGFloat xPosToCenter = (self.view.frame.size.width/2) - (imageWidth/2);
	CGFloat yPos = 20;
	
	CGRect welcomeFrame = CGRectMake(xPosToCenter, yPos, imageWidth, imageHeight);
	UIView *welcomeIconView = [[UIView alloc] initWithFrame:welcomeFrame];
	welcomeIconView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"welcome.png"]];
	
	//Create Login button
	UIImage *loginButtonImage = [UIImage imageNamed:@"loginBtn.png"];
	UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[loginButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
	
	CGFloat loginBtnImageWidth = 80;
	CGFloat loginBtnImageHeight = 25;
	CGFloat xPosToCenter_loginBtn = (self.view.frame.size.width/2) - (loginBtnImageWidth/2);
	CGFloat yPos_loginBtn = 300;
	
	loginButton.frame = CGRectMake(xPosToCenter_loginBtn, yPos_loginBtn, loginBtnImageWidth, loginBtnImageHeight);
	[loginButton setBackgroundImage:loginButtonImage forState:UIControlStateNormal];
	
	//Create create new account button
	UIImage *createButtonImage = [UIImage imageNamed:@"createBtn.png"];
	UIButton *createButton = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[createButton addTarget:self action:@selector(createAccount:) forControlEvents:UIControlEventTouchUpInside];
	
	CGFloat createBtnImageWidth = 200;
	CGFloat createBtnImageHeight = 25;
	CGFloat xPosToCenter_createBtn = (self.view.frame.size.width/2) - (createBtnImageWidth/2);
	CGFloat yPos_createBtn = 345;
	
	createButton.frame = CGRectMake(xPosToCenter_createBtn, yPos_createBtn, createBtnImageWidth, createBtnImageHeight);
	[createButton setBackgroundImage:createButtonImage forState:UIControlStateNormal];
	
	[self.view addSubview:loginButton];
	[self.view addSubview:createButton];
	[self.view addSubview:welcomeIconView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
