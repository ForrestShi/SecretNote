//
//  DetailViewController.m
//  SecretNote
//
//  Created by forrest on 13-3-30.
//  Copyright (c) 2013年 DFA. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()<UITextViewDelegate>
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController


#pragma mark - UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView{
    NSLog(@"textView did end editting.");
    if (_detailItem) {
        [_detailItem setValue:textView.text forKey:@"content"];
        NSArray *stringArray = [textView.text componentsSeparatedByString:@"\n"];
        NSString *possibleTitle = [stringArray objectAtIndex:0];
        [_detailItem setValue:possibleTitle forKey:@"title"];
    }
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [self.noteTextView resignFirstResponder];
    return YES;
}


#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{    
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"timeStamp"] description];
        self.noteTextView.text = [self.detailItem valueForKey:@"content"];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)viewDidUnload{
    [super viewDidUnload];
    
    NSLog(@"unload ");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
