#import "UIImageView+AFNetworkingFadeInAdditions.h"
#import "UIImageView+AFNetworking.h"

@implementation UIImageView (AFNetworkingFadeInAdditions)

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage fadeInWithDuration:(CGFloat)duration {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPShouldHandleCookies:NO];
    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    
    __weak typeof (self) weakSelf = self;
    
    [self setImageWithURLRequest:request placeholderImage:placeholderImage success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        [UIView transitionWithView:weakSelf duration:duration options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            [weakSelf setImage:image];
        } completion:nil];
    } failure:nil];
}

@end
