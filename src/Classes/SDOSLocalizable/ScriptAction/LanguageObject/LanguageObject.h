//
//  LanguageObject.h
//  SDOS
//
//  Created by Rafael Fernandez Alvarez on 17/03/2017.
//  Copyright © 2017 Rafael Fernandez Alvarez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LanguageObject : NSObject

@property (nonatomic, strong) NSDictionary *listKeys;
@property (nonatomic, copy) NSString *folderLanguage;
@property (nonatomic, copy) NSString *bundleName;

@end
