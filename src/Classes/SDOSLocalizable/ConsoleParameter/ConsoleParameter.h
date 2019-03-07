//
//  ConsoleParameter.h
//  ImageConstants
//
//  Created by Rafael Fernandez Alvarez on 06/02/2017.
//  Copyright © 2017 Rafael Fernandez Alvarez. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ConsoleParameter;

typedef BOOL (^ConsoleParameterActionExecute) (ConsoleParameter *consoleParameter, NSArray *values);

@interface ConsoleParameter : NSObject

@property (nonatomic, strong) NSString *option;
@property (nonatomic, assign) NSInteger numArgs;
@property (nonatomic, copy) ConsoleParameterActionExecute actionExecute;

@end
