//
//  LanguageCollectionObject.h
//  SDOS
//
//  Created by Rafael Fernandez Alvarez on 17/03/2017.
//  Copyright © 2017 Rafael Fernandez Alvarez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LanguageObject.h"

@interface LanguageCollectionObject : NSObject

@property (nonatomic, strong) NSMutableArray<LanguageObject *> *listLanguageObjects;
@property (nonatomic, copy) NSString *filename;

@end
