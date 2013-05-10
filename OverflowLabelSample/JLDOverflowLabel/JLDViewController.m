//
//  JLDViewController.m
//  JLDOverflowLabel
//
//  Created by Jean-Luc Dagon on 10/05/13.
//  Copyright (c) 2013 Cocoapps. All rights reserved.
//

#import "JLDViewController.h"

@interface JLDViewController ()

@end

@implementation JLDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self.overflowLabel1 setBackgroundColor:[UIColor clearColor]];
    [self.overflowLabel2 setBackgroundColor:[UIColor clearColor]];
    [self.overflowLabel3 setBackgroundColor:[UIColor clearColor]];
    
    [self.overflowLabel1 setText:@"This text is short, but a bit too long to fit."];
	[self.overflowLabel1 setTextColor:[UIColor whiteColor]];
	[self.overflowLabel1 setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:22.f]];
    
    self.overflowLabel1.leftShadowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ShadowLeft"]];
    self.overflowLabel1.rightShadowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ShadowRight"]];
    
    [self.overflowLabel2 setText:@"This one is short, won't scroll."];
    [self.overflowLabel2 setTextColor:[UIColor lightGrayColor]];
	[self.overflowLabel2 setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:22.f]];
    
    [self.overflowLabel3 setSpeed:14.f]; // pixels per second
    [self.overflowLabel3 setText:@"You can adjust the scrolling speed. A bit slower here."];
	[self.overflowLabel3 setTextColor:[UIColor whiteColor]];
	[self.overflowLabel3 setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:22.f]];
    
    self.overflowLabel3.leftShadowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ShadowLeft"]];
    self.overflowLabel3.rightShadowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ShadowRight"]];
    
}



@end
