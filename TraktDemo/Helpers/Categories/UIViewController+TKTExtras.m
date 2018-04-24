//
//  UIViewController+TKTExtras.m
//  TraktDemo
//
//  Created by Guillermo Sáenz on 4/24/18.
//

#import "UIViewController+TKTExtras.h"

@implementation UIViewController (TKTExtras)

- (BOOL)isVisible {
    
    return self.isViewLoaded && self.view.window;
}

@end
