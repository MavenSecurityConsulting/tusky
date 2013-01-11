//
//  CreateTaskViewController.m
//  Tusky
//
//  Created by Hendy Chua on 9/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CreateTaskViewController.h"
#import "API.h"

@interface CreateTaskViewController ()

@end

@implementation CreateTaskViewController

UITextField *title;
UITextField *desc;
UIButton *createTaskBtn;

NSString *OPEN_STATUS = @"0";
NSString *COMPLETED_STATUS = @"1";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)createTask:(id)sender {
	NSLog(@"Creating task");
	
	NSString *titleInput = [title.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	NSString *descInput = [desc.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

	// only the title is compulsory
	if ((titleInput.length == 0)) {
		
		[[[UIAlertView alloc] initWithTitle:@"Missing fields" 
									message:[NSString stringWithFormat:@"You must at least have a title!"]
								   delegate:nil 
						  cancelButtonTitle:@"Dismiss" 
						  otherButtonTitles: nil] show];
	} else {
		NSDictionary *user = [[API sharedInstance] user];
		NSMutableDictionary* params =[NSMutableDictionary dictionaryWithObjectsAndKeys: 
									  titleInput, @"title",
									  descInput, @"description",
									  OPEN_STATUS, @"status", //when a task its created, status is open
									  [user objectForKey:@"userID"], @"owner_id",
									  nil];
		
		NSString* action = @"/tasks/";
		//make the call to the web API
		[[API sharedInstance] commandWithParams:params
										   Path:action
										 Method:@"POST"
								   onCompletion:^(NSDictionary *json) {
									   //result returned
									   if ([json objectForKey:@"error"]==nil)
									   {
										   //move to the next view
										   [self performSegueWithIdentifier:@"segueToAllTasksView" sender:self];

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
	UITableView *taskCreationTable = [[UITableView alloc] initWithFrame:detailsFrame style:UITableViewStyleGrouped];
	[taskCreationTable setBackgroundColor:[UIColor grayColor]];
	taskCreationTable.dataSource = self;
    taskCreationTable.delegate = self;
	
	createTaskBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[createTaskBtn addTarget:self 
						 action:@selector(createTask:)
			   forControlEvents:UIControlEventTouchUpInside];
	[createTaskBtn setTitle:@"Create Task" forState:UIControlStateNormal];
	createTaskBtn.frame = CGRectMake((self.view.frame.size.width-160.0)/2, 120, 160.0, 40.0);

	
	[self.view addSubview:taskCreationTable];
	[self.view addSubview:createTaskBtn];
		
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
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
		title = [[UITextField alloc] init];
		title.placeholder = @"Task Title";
		title.autocorrectionType = UITextAutocorrectionTypeYes;
		title.returnKeyType = UIReturnKeyNext;
		cell.accessoryView = title;
		[table addSubview:title];
		title.delegate = self;
		[self positionContentsOfCell:cell withView:title];			
		
	} else if (indexPath.row == 1) {
		desc = [[UITextField alloc] init];
		desc.placeholder = @"Description";
		desc.autocorrectionType = UITextAutocorrectionTypeYes;
		desc.returnKeyType = UIReturnKeyDone;
		cell.accessoryView = desc;
		[table addSubview:desc];
		desc.delegate = self;
		[self positionContentsOfCell:cell withView:desc];
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
    if (textField == title) {
        [desc becomeFirstResponder];
    } else if (textField == desc) {
		[desc resignFirstResponder];
    }
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
