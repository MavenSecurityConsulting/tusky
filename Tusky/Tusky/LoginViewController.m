//
//  LoginViewController.m
//  Tusky
//
//  Created by Hendy Chua on 13/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "API.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

UITextField *email;
UITextField *password;
UIButton *loginBtn;
UIScrollView *scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) login:(id) sender {
	NSString *emailInput = [email.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	NSString *passwordInput = [password.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	
	if ((emailInput.length == 0) || (passwordInput.length == 0)) {
		
		[[[UIAlertView alloc] initWithTitle:@"Missing fields" 
									message:[NSString stringWithFormat:@"All fields are required."]
								   delegate:nil 
						  cancelButtonTitle:@"Dismiss" 
						  otherButtonTitles: nil] show];
	} else {
		NSMutableDictionary* params =[NSMutableDictionary dictionaryWithObjectsAndKeys:
									  emailInput, @"email",
									  passwordInput, @"password",
									  nil];
		NSString* action = @"/users/authenticate";
		
		//make the call to the web API
		[[API sharedInstance] commandWithParams:params
										   Path:action
										 Method:@"POST"
								   onCompletion:^(NSDictionary *json) {
									   //result returned
									   if ([json objectForKey:@"error"]==nil )
									   {
										   //successful
										   NSDictionary* user = [NSDictionary dictionaryWithObjectsAndKeys:
																 [json objectForKey:@"id"], @"userID", 
																 [json objectForKey:@"first_name"], @"firstName",
																 [json objectForKey:@"last_name"], @"lastName",
																 nil];
										   
										   [[API sharedInstance] setUser: user];
										   
										   //move to the next view
										   [self performSegueWithIdentifier:@"segueToAllTasksAfterLogin" sender:self];
										   
										   //show welcome message to the user
										   [[[UIAlertView alloc] initWithTitle:@"Logged in" 
																	   message:[NSString stringWithFormat:@"Welcome %@ %@! You have logged in successfully.",[user objectForKey:@"firstName"], [user objectForKey:@"lastName"]]
																	  delegate:nil 
															 cancelButtonTitle:@"Yeah, thank you!" 
															 otherButtonTitles: nil] show];
									   } 
									   else 
									   {
										   //unsuccessful
										   [[[UIAlertView alloc] initWithTitle:@"Error" 
																	   message:[json objectForKey:@"error"]
																	  delegate:nil 
															 cancelButtonTitle:@"Dismiss" 
															 otherButtonTitles: nil] show];
									   }
								   }];
		
	}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	
	CGRect detailsFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
	UITableView *detailsTable = [[UITableView alloc] initWithFrame:detailsFrame style:UITableViewStyleGrouped];
	[detailsTable setBackgroundColor:[UIColor clearColor]];
	detailsTable.dataSource = self;
    detailsTable.delegate = self;
	
	loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[loginBtn addTarget:self 
						 action:@selector(login:)
			   forControlEvents:UIControlEventTouchUpInside];
	[loginBtn setTitle:@"Login" forState:UIControlStateNormal];
	loginBtn.frame = CGRectMake((self.view.frame.size.width-160.0)/2, 120.0, 160.0, 40.0);
	
	CGRect fullScreenRect= CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y,self.view.bounds.size.width, self.view.bounds.size.height);
	scrollView=[[UIScrollView alloc] initWithFrame:fullScreenRect];
	[scrollView setBackgroundColor:[UIColor grayColor]];
	scrollView.contentSize=CGSizeMake(320,550);
	
	[scrollView addSubview:detailsTable];
	[scrollView addSubview:loginBtn];
	
	[self.view addSubview:scrollView];
	
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 2;
}

- (UITableViewCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell *cell = [table dequeueReusableCellWithIdentifier:@"Cell"];
	if( cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
	}
	
	cell.backgroundColor = [UIColor whiteColor];
	
	if (indexPath.row == 0) {
		email = [[UITextField alloc] init];
		email.placeholder = @"Email";
		email.autocorrectionType = UITextAutocorrectionTypeNo;
		email.returnKeyType = UIReturnKeyNext;
		cell.accessoryView = email;
		[table addSubview:email];
		email.delegate = self;
		[self positionContentsOfCell:cell withView:email];
		
	} else if (indexPath.row == 1) {
		password = [[UITextField alloc] init];
		password.placeholder = @"Password";
		password.autocorrectionType = UITextAutocorrectionTypeNo;
		password.returnKeyType = UIReturnKeyDone;
		[password setSecureTextEntry:YES];
		cell.accessoryView = password;
		[table addSubview:password];
		password.delegate = self;
		[self positionContentsOfCell:cell withView:password];
	}
	
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	return cell;
}

- (void)positionContentsOfCell:(UITableViewCell *)cell withView:(UIView *)theView {
	
	// Position the text field within the cell bounds
	CGRect cellBounds = cell.bounds;
	CGFloat textFieldBorder = 20.f;
	// Don't align the field exactly in the vertical middle, as the text
	// is not actually in the middle of the field.
	CGRect aRect = CGRectMake(textFieldBorder, 9.f, CGRectGetWidth(cellBounds)-(2*textFieldBorder), 28.f );
	theView.frame = aRect;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == email) {
        [password becomeFirstResponder];
    } else if (textField == password) {
		[password resignFirstResponder];
    }
    return YES;
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
