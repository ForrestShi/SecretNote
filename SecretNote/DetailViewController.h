//
//  DetailViewController.h
//  SecretNote
//
//  Created by forrest on 13-3-30.
//  Copyright (c) 2013年 DFA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
