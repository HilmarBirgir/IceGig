//
//  LoginViewModel.h
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 14/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LoginService;
@class RoutingService;

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewModel : NSObject

- (instancetype)initWithLoginService:(LoginService *)loginService
                      routingService:(RoutingService *)routingService;

- (void)startLogin;

@end

NS_ASSUME_NONNULL_END
