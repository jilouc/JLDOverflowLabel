//
//  JLDOverflowLabel.m
//  JLDOverflowLabel
//
//  Created by Jean-Luc Dagon on 10/05/13.
//  Copyright (c) 2013 Cocoapps. All rights reserved.
//

#import "JLDOverflowLabel.h"
#import <QuartzCore/QuartzCore.h>

@interface JLDOverflowLabel () {
    BOOL _shouldAnimate;
}

@property (nonatomic, strong, readonly) UILabel *textLabel;

@end


@implementation JLDOverflowLabel

@dynamic font, text, textColor, shadowColor, shadowOffset;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _setupLabel];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
        [self _setupLabel];
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size
{
    return [_textLabel sizeThatFits:size];
}

#pragma mark - Label setup

- (void)setFrame:(CGRect)frame
{
    CGRect r = _textLabel.frame;
    r.origin = CGPointZero;
    r.size.height = CGRectGetHeight(frame);
    _textLabel.frame = r;
    
    [super setFrame:frame];
    [self _computeOverflowAndAnimateIfNeeded];
    
}

- (void)_setupLabel
{
    _delay = 3.f;
    _speed = 320.f / 15.f;
    _shouldAnimate = YES;
    
    [self setClipsToBounds:YES];
    
    _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    _textLabel.numberOfLines = 1;
    _textLabel.backgroundColor = [UIColor clearColor];
    _textLabel.minimumScaleFactor = 1.f;
    
    [self addSubview:_textLabel];
    
}

- (void)setLeftShadowView:(UIView *)leftShadowView
{
    _leftShadowView = leftShadowView;
    CGRect r = _leftShadowView.frame;
    r.origin = CGPointZero;
    r.size.height = CGRectGetHeight(self.frame);
    _leftShadowView.frame = r;
    _leftShadowView.contentMode = UIViewContentModeScaleToFill;
    _leftShadowView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleRightMargin;
    
    _leftShadowView.alpha = 0.f;
    [self addSubview:_leftShadowView];
}

- (void)setRightShadowView:(UIView *)rightShadowView
{
    _rightShadowView = rightShadowView;
    CGRect r = _rightShadowView.frame;
    r.origin.x = CGRectGetWidth(self.frame) - CGRectGetWidth(r);
    r.origin.y = 0;
    r.size.height = CGRectGetHeight(self.frame);
    _rightShadowView.frame = r;
    _rightShadowView.contentMode = UIViewContentModeScaleToFill;
    _rightShadowView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleRightMargin;
    
    _rightShadowView.alpha = 0.f;
    [self addSubview:_rightShadowView];
}

- (void)_resizeLabel
{
    [_textLabel sizeToFit];
    CGRect textRect = _textLabel.frame;
    textRect.origin = CGPointZero;
    textRect.size.height = CGRectGetHeight(self.frame);
    _textLabel.frame = textRect;
    
    [self _computeOverflowAndAnimateIfNeeded];
}

- (void)_computeOverflowAndAnimateIfNeeded
{
    CGFloat previousOverflow = _overflow;
    [self _computeOverflow];
    
    if (previousOverflow <= 0 && _overflow > 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
            [self _startSlidingLabelToTheLeft];
        });
        
    } else if (previousOverflow > 0 && _overflow <= 0) {
        [_textLabel.layer removeAllAnimations];
    }
}

- (void)_computeOverflow
{
    _overflow = CGRectGetWidth(_textLabel.frame) - CGRectGetWidth(self.frame);
}

- (void)_startSlidingLabelToTheLeft
{
    if (!_shouldAnimate) {
        return;
    }
    
    [self _computeOverflow];
    
    if (_overflow <= 0) {
        return;
    }
    
    [_textLabel.layer removeAllAnimations];
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.leftShadowView.alpha = 1;
    } completion:nil];
    
    [UIView animateWithDuration:(_overflow / _speed) delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        CGRect r = _textLabel.frame;
        r.origin.x = -_overflow;
        _textLabel.frame = r;
        
    } completion:^(BOOL finished) {
    
        if (!_shouldAnimate) {
            return;
        }
        
        if (finished) {
            
            [UIView animateWithDuration:0.1f animations:^{
                self.rightShadowView.alpha = 0;
            }];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
                [self _startSlidingLabelToTheRight];
            });
            
        }
        
    }];
}

- (void)_startSlidingLabelToTheRight
{
    if (!_shouldAnimate) {
        return;
    }
    
    [self _computeOverflow];
    
    if (_overflow <= 0) {
        return;
    }
    
    [_textLabel.layer removeAllAnimations];
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.rightShadowView.alpha = 1;
    } completion:nil];
    
    [UIView animateWithDuration:(_overflow / _speed) delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        CGRect r = _textLabel.frame;
        r.origin.x = 0;
        _textLabel.frame = r;
        
    } completion:^(BOOL finished) {
        
        if (!_shouldAnimate) {
            return;
        }
        
        if (finished) {
            [UIView animateWithDuration:0.1f animations:^{
                self.leftShadowView.alpha = 0;
            }];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
                [self _startSlidingLabelToTheLeft];
            });
        }
        
    }];
}

#pragma mark - Label properties that change the layout

- (void)setText:(NSString *)text
{
    [_textLabel setText:text];
    [self _resizeLabel];
}

- (void)setFont:(UIFont *)font
{
    [_textLabel setFont:font];
    [self _resizeLabel];
}

- (void)startAnimating
{
    _shouldAnimate = YES;
    [self _computeOverflowAndAnimateIfNeeded];
}

- (void)stopAnimating:(BOOL)animated
{
    _shouldAnimate = NO;
    [_textLabel.layer removeAllAnimations];
    
    [UIView animateWithDuration:animated ? 0.2f : 0.f animations:^{
        CGRect r = _textLabel.frame;
        r.origin = CGPointZero;
        r.size.height = CGRectGetHeight(self.frame);
        _textLabel.frame = r;
    }];
}

#pragma mark - Forward methods to the label

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    if ([_textLabel respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:_textLabel];
    } else {
        [super forwardInvocation:anInvocation];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (!signature) {
        signature = [_textLabel methodSignatureForSelector:aSelector];
    }
    return signature;
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    BOOL responds = [super respondsToSelector:aSelector];
    if (!responds) {
        responds = [_textLabel respondsToSelector:aSelector];
    }
    return responds;
}



@end
