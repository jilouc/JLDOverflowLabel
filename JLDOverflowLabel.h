//
//  JLDOverflowLabel.h
//  JLDOverflowLabel
//
//  Created by Jean-Luc Dagon on 10/05/13.
//  Copyright (c) 2013 Cocoapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JLDOverflowLabel : UIView

@property (nonatomic, assign) CGFloat speed;
@property (nonatomic, assign) NSTimeInterval delay;

@property (nonatomic, assign) CGFloat overflow;

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, assign) CGSize shadowOffset;
@property (nonatomic, strong) UIColor *shadowColor;
@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, strong) UIView *leftShadowView;
@property (nonatomic, strong) UIView *rightShadowView;

- (void)stopAnimating:(BOOL)animated;
- (void)startAnimating;

@end
