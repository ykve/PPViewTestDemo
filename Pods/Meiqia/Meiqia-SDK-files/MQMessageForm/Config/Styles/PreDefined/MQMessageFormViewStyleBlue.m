//
//  MQMessageFormViewStyleBlue.m
//  Meiqia-SDK-Demo
//
//  Created by bingoogol on 16/5/24.
//  Copyright © 2016年 Meiqia. All rights reserved.
//

#import "MQMessageFormViewStyleBlue.h"

@implementation MQMessageFormViewStyleBlue

- (instancetype)init {
    if (self = [super init]) {
        self.navBarColor =  [UIColor colorWithHexString:belizeHole];
        self.navTitleColor = [UIColor colorWithHexString:gallery];
        self.navBarTintColor = [UIColor colorWithHexString:clouds];
    }
    return self;
}

@end
