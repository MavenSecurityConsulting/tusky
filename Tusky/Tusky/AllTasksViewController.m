//
//  AllTasksViewController.m
//  Tusky
//
//  Created by Hendy Chua on 23/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AllTasksViewController.h"
#import "API.h"

@interface AllTasksViewController ()

@end

@implementation AllTasksViewController

UIScrollView *scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)logout:(id) sender {
	NSLog(@"Logging out.");
	//logs user out
	[[API sharedInstance] setUser: nil];
	[self performSegueWithIdentifier:@"segueAfterLogout" sender:nil];
}

- (void)addNewTask:(id) sender {
	[self performSegueWithIdentifier:@"segueToCreateTask" sender:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	CGRect fullScreenRect= CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y,self.view.bounds.size.width, self.view.bounds.size.height);
	scrollView=[[UIScrollView alloc] initWithFrame:fullScreenRect];
	[scrollView setBackgroundColor:[UIColor grayColor]];
	scrollView.contentSize=CGSizeMake(320,1000);
	
	self.navigationItem.hidesBackButton = YES;
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleBordered target:self action:@selector(logout:)];
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewTask:)];
	
	NSDictionary *user = [[API sharedInstance] user];
	
	NSString* action = @"/tasks/owner/";
	NSString* actionFullPath = [action stringByAppendingString:[[user objectForKey:@"userID"] stringValue]];
	//make the call to the web API
	[[API sharedInstance] commandWithParams:nil
									   Path:actionFullPath
									 Method:@"GET"
							   onCompletion:^(NSDictionary *json) {
								   //result returned
								   if ([json objectForKey:@"error"]==nil )
								   {
									   NSLog(@"Got list of tasks.");
									   NSLog(@"Number of tasks: %u",[[json objectForKey:@"all_tasks"] count]);
									   
									   NSEnumerator *e = [[json objectForKey:@"all_tasks"] objectEnumerator];
									   id object;
									   NSInteger i=0;
									   CGFloat frameWidth = 120;
									   CGFloat frameHeight = 100;
									   CGFloat orig_xPos = 20;
									   CGFloat orig_yPos = 20;
									   CGFloat xPos = 0;
									   CGFloat yPos = 0;
									   while (object = [e nextObject]) {
										   NSLog(@"%u: %@",i,object);
										   if (i%2==0) {
											   xPos = orig_xPos;
											   yPos = orig_yPos + (60*i);
										   } else if (i%2==1) {
											   xPos = orig_xPos + 160;
											   yPos = orig_yPos + (60*(i-1));
										   }
										   CGRect taskFrame = CGRectMake(xPos, yPos, frameWidth, frameHeight);
										   UIView *taskView = [[UIView alloc] initWithFrame:taskFrame];
										   taskView.backgroundColor = [UIColor whiteColor];
										   
										   UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 80)];
										   textLabel.lineBreakMode = UILineBreakModeWordWrap;
										   textLabel.numberOfLines = 0;
										   [textLabel setTextColor:[UIColor blackColor]];
										   [textLabel setBackgroundColor:[UIColor clearColor]];
										   NSString *status = @"";
										   if ([object objectForKey:@"status"] == 0) {
											   status = @"(Open)";
										   } else {
											   status = @"(Completed)";
										   }
										   NSString *fullText = [[object objectForKey:@"title"] stringByAppendingString:status];
										   [textLabel setText:fullText];
										   [taskView addSubview:textLabel];
										   
										   [scrollView addSubview:taskView];
										   i++;
									   }
									   
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
	
	[self.view addSubview:scrollView];
	

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
