//
//  CreateAccountViewController.m
//  Tusky
//
//  Created by Hendy Chua on 13/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CreateAccountViewController.h"
#import "API.h"

@interface CreateAccountViewController ()

@end

@implementation CreateAccountViewController

//@synthesize sectionsAndFields = _sectionsAndFields;

UITextField *firstName;
UITextField *lastName;
UITextField *email;
UITextField *password;
UIButton *createAccountBtn;
UIScrollView *scrollView;

NSDictionary *sectionsAndFields;
NSArray *sequencedKeys;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) createAccount:(id) sender {
	NSString *firstNameInput = [firstName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	NSString *lastNameInput = [lastName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	NSString *emailInput = [email.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	NSString *passwordInput = [password.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	
	if ((firstNameInput.length == 0) || (lastNameInput.length == 0)
				|| (emailInput.length == 0) || (passwordInput.length == 0)) {
		
		[[[UIAlertView alloc] initWithTitle:@"Missing fields" 
									message:[NSString stringWithFormat:@"All fields are required."]
								   delegate:nil 
						  cancelButtonTitle:@"Dismiss" 
						  otherButtonTitles: nil] show];
	} else {
		
		NSMutableDictionary* params =[NSMutableDictionary dictionaryWithObjectsAndKeys: 
									  firstNameInput, @"first_name",
									  lastNameInput, @"last_name",
									  emailInput, @"email",
									  passwordInput, @"password",
									  nil];
		
		NSString* action = @"/users/";
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
										   [self performSegueWithIdentifier:@"segueToAllTasksAfterRegistration" sender:self];
										   
										   //show welcome message to the user
										   [[[UIAlertView alloc] initWithTitle:@"Logged in" 
																	   message:[NSString stringWithFormat:@"Welcome %@ %@! You have registered and logged in successfully.",[user objectForKey:@"firstName"], [user objectForKey:@"lastName"]]
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
	
	sequencedKeys = [[NSArray alloc] initWithObjects:@"names", @"login", nil];
	NSArray *namesArray = [[NSArray alloc] initWithObjects:@"First Name", @"Last Name", Nil];
	NSArray *loginArray = [[NSArray alloc] initWithObjects:@"Email", @"Password", nil];
	sectionsAndFields = [[NSDictionary alloc] initWithObjectsAndKeys:namesArray, @"names",
							  loginArray, @"login",
							  nil];
								  
	
	CGRect detailsFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
	UITableView *detailsTable = [[UITableView alloc] initWithFrame:detailsFrame style:UITableViewStyleGrouped];
	[detailsTable setBackgroundColor:[UIColor clearColor]];
	detailsTable.dataSource = self;
    detailsTable.delegate = self;
	
	createAccountBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[createAccountBtn addTarget:self 
			   action:@selector(createAccount:)
	 forControlEvents:UIControlEventTouchUpInside];
	[createAccountBtn setTitle:@"Create Account" forState:UIControlStateNormal];
	createAccountBtn.frame = CGRectMake((self.view.frame.size.width-160.0)/2, 230.0, 160.0, 40.0);
	
	CGRect fullScreenRect= CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y,self.view.bounds.size.width, self.view.bounds.size.height);
	scrollView=[[UIScrollView alloc] initWithFrame:fullScreenRect];
	[scrollView setBackgroundColor:[UIColor grayColor]];
	scrollView.contentSize=CGSizeMake(320,550);

	[scrollView addSubview:detailsTable];
	[scrollView addSubview:createAccountBtn];
	
	[self.view addSubview:scrollView];
	
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return [[sectionsAndFields allKeys] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSString *thisSectionKey = [sequencedKeys objectAtIndex:section];
	return [[sectionsAndFields objectForKey:thisSectionKey] count];
}

- (UITableViewCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell *cell = [table dequeueReusableCellWithIdentifier:@"Cell"];
	if( cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
	}
	
	cell.backgroundColor = [UIColor whiteColor];
	
	if (indexPath.section == 0) {
		if (indexPath.row == 0) {
			firstName = [[UITextField alloc] init];
			firstName.placeholder = @"First Name";
			firstName.autocorrectionType = UITextAutocorrectionTypeNo;
			firstName.returnKeyType = UIReturnKeyNext;
			cell.accessoryView = firstName;
			[table addSubview:firstName];
			firstName.delegate = self;
			[self positionContentsOfCell:cell withView:firstName];			
			
		} else if (indexPath.row == 1) {
			lastName = [[UITextField alloc] init];
			lastName.placeholder = @"Last Name";
			lastName.autocorrectionType = UITextAutocorrectionTypeNo;
			firstName.returnKeyType = UIReturnKeyNext;
			cell.accessoryView = lastName;
			[table addSubview:lastName];
			lastName.delegate = self;
			[self positionContentsOfCell:cell withView:lastName];
		}

	} else if (indexPath.section == 1) {
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
    if (textField == firstName) {
        [lastName becomeFirstResponder];
    } else if (textField == lastName) {
        [email becomeFirstResponder];
    } else if (textField == email) {
        [password becomeFirstResponder];
    } else if (textField == password) {
		[password resignFirstResponder];
    }
    return YES;
}

/*
 The commented code can be used to animate the screen so that views do not get
 blocked when the keyboard is displayed. But more work needs to be done.
 Right now, it just animates views up and down. Need to check whether it is being blocked
 first. Also, using this method to animate views to move up means that unless they resign
 as first responder (i.e. hide keyboard), you can't scroll them down.
*/
/*
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 80; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
	
    int movement = (up ? -movementDistance : movementDistance);
	
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}
 */



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
