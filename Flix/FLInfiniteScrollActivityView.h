//
//  FLInfiniteScrollActivityView.h
//  Flix
//
//  Created by parry on 10/16/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLInfiniteScrollActivityView : UIView

+ (CGFloat)defaultHeight;

- (void)startAnimating;
- (void)stopAnimating;

@end
