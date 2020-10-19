//
//  ScriptAction.h
//  ScriptAction
//
//  Created by Rafael Fernandez Alvarez on 06/02/2017.
//  Copyright © 2017 Rafael Fernandez Alvarez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScriptAction : NSObject

- (void) loadWithArgs:(const char *[]) argv numArgs:(int) numArgs;

@end
