//
//  main.m
//  ScriptAction
//
//  Created by Rafael Fernandez Alvarez on 06/02/2017.
//  Copyright © 2017 Rafael Fernandez Alvarez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScriptAction/ScriptAction.h"

int main(int argc, const char * argv[]) {
	@autoreleasepool {
		ScriptAction *scriptAction = [ScriptAction new];
		[scriptAction loadWithArgs:argv numArgs:argc];
	}
    return 0;
}
