//
//  LanguageCollectionObject.m
//  SDOS
//
//  Created by Rafael Fernandez Alvarez on 17/03/2017.
//  Copyright © 2017 Rafael Fernandez Alvarez. All rights reserved.
//

#import "LanguageCollectionObject.h"

@implementation LanguageCollectionObject

#pragma mark - Inject

- (NSMutableArray *)listLanguageObjects {
	if (!_listLanguageObjects) {
		_listLanguageObjects = [NSMutableArray array];
	}
	return _listLanguageObjects;
}

@end
