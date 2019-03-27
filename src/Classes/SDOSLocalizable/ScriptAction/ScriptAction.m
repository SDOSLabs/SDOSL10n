//
//  ScriptAction.m
//  ScriptAction
//
//  Created by Rafael Fernandez Alvarez on 06/02/2017.
//  Copyright © 2017 Rafael Fernandez Alvarez. All rights reserved.
//

#import "./ScriptAction.h"
#import "../Util/Util.h"
#import "../ConsoleParameter/ConsoleParameter.h"
#import "../Constants/Constants.h"
#import "./LanguageObject/LanguageObject.h"
#import "./LanguageCollectionObject/LanguageCollectionObject.h"

#import "SDOSL10n-Swift.h"

@interface ScriptAction()

@property (nonatomic, strong) NSMutableArray *arrayParameters;

@property (nonatomic, strong) ScriptActionSwift *scriptActionSwift;
@property (nonatomic, copy) NSString *pwd;
@property (nonatomic, copy) NSString *outputLocalizableDirectory;
@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, copy) NSString *cloudBundleKey;
@property (nonatomic, copy) NSString *cloudVersion;
@property (nonatomic, copy) NSString *cloudAccesToken;
@property (nonatomic, copy) NSString *cloudEndpoint;
@property (nonatomic, copy) NSArray *cloudCustomRegEx;
@property (nonatomic, assign) BOOL disableInputOutputFilesValidation;
@property (nonatomic, assign) BOOL unlockFiles;


@end

@implementation ScriptAction

#pragma mark - Inject

- (NSMutableArray *)arrayParameters {
	if (!_arrayParameters) {
		_arrayParameters = [NSMutableArray array];
	}
	return _arrayParameters;
}

#pragma mark - Initialize

- (void) registerParameters {
	ConsoleParameter *consoleParameter0 = [[ConsoleParameter alloc] init];
	consoleParameter0.numArgs = 0;
	[consoleParameter0 setActionExecute:^BOOL (ConsoleParameter *consoleParameter, NSArray *values){
		self.pwd = [[NSFileManager defaultManager] currentDirectoryPath];
		//self.pwd = @"/Users/rafael.fernandez/Documents/GIT/SDOS/src/ScriptAction";
		return true;
	}];
	[self.arrayParameters addObject:consoleParameter0];
	
	ConsoleParameter *consoleParameter3 = [[ConsoleParameter alloc] init];
	consoleParameter3.option = @"-h";
	consoleParameter3.numArgs = 0;
	[consoleParameter3 setActionExecute:^BOOL (ConsoleParameter *consoleParameter, NSArray *values){
		return false;
	}];
	[self.arrayParameters addObject:consoleParameter3];
    
    ConsoleParameter *consoleParameter5 = [[ConsoleParameter alloc] init];
    consoleParameter5.option = @"-output-directory";
    consoleParameter5.numArgs = 1;
    [consoleParameter5 setActionExecute:^BOOL (ConsoleParameter *consoleParameter, NSArray *values){
        NSString *result = values[1];
        if (![result hasPrefix:@"/"]) {
            result = [NSString stringWithFormat:@"%@/%@", self.pwd, result];
        }
        self.outputLocalizableDirectory = result;
        return true;
    }];
    [self.arrayParameters addObject:consoleParameter5];
    
    ConsoleParameter *consoleParameter6 = [[ConsoleParameter alloc] init];
    consoleParameter6.option = @"-cloudBundleKey";
    consoleParameter6.numArgs = 1;
    [consoleParameter6 setActionExecute:^BOOL (ConsoleParameter *consoleParameter, NSArray *values){
        NSString *result = values[1];
        self.cloudBundleKey = result;
        return true;
    }];
    [self.arrayParameters addObject:consoleParameter6];
    
    ConsoleParameter *consoleParameter7 = [[ConsoleParameter alloc] init];
    consoleParameter7.option = @"-cloudVersion";
    consoleParameter7.numArgs = 1;
    [consoleParameter7 setActionExecute:^BOOL (ConsoleParameter *consoleParameter, NSArray *values){
        NSString *result = values[1];
        self.cloudVersion = result;
        return true;
    }];
    [self.arrayParameters addObject:consoleParameter7];
    
    ConsoleParameter *consoleParameter8 = [[ConsoleParameter alloc] init];
    consoleParameter8.option = @"-cloudAccesToken";
    consoleParameter8.numArgs = 1;
    [consoleParameter8 setActionExecute:^BOOL (ConsoleParameter *consoleParameter, NSArray *values){
        NSString *result = values[1];
        self.cloudAccesToken = result;
        return true;
    }];
    [self.arrayParameters addObject:consoleParameter8];
    
    ConsoleParameter *consoleParameter9 = [[ConsoleParameter alloc] init];
    consoleParameter9.option = @"-cloudEndpoint";
    consoleParameter9.numArgs = 1;
    [consoleParameter9 setActionExecute:^BOOL (ConsoleParameter *consoleParameter, NSArray *values){
        NSString *result = values[1];
        self.cloudEndpoint = result;
        return true;
    }];
    [self.arrayParameters addObject:consoleParameter9];
    
    ConsoleParameter *consoleParameter10 = [[ConsoleParameter alloc] init];
    consoleParameter10.option = @"-output-file-name";
    consoleParameter10.numArgs = 1;
    [consoleParameter10 setActionExecute:^BOOL (ConsoleParameter *consoleParameter, NSArray *values){
        NSString *result = values[1];
        self.fileName = result;
        return true;
    }];
    [self.arrayParameters addObject:consoleParameter10];

    ConsoleParameter *consoleParameter12 = [[ConsoleParameter alloc] init];
    consoleParameter12.option = @"-cloudCustomRegEx";
    consoleParameter12.numArgs = 1;
    [consoleParameter12 setActionExecute:^BOOL (ConsoleParameter *consoleParameter, NSArray *values){
        NSString *regexs = values[1];
        self.cloudCustomRegEx = [regexs componentsSeparatedByString:CUSTOM_REG_EX_SEPARATOR];
        return true;
    }];
    [self.arrayParameters addObject:consoleParameter12];
    
    ConsoleParameter *consoleParameter13 = [[ConsoleParameter alloc] init];
    consoleParameter13.option = @"--disable-input-output-files-validation";
    consoleParameter13.numArgs = 0;
    [consoleParameter13 setActionExecute:^BOOL (ConsoleParameter *consoleParameter, NSArray *values){
        self.disableInputOutputFilesValidation = true;
        return true;
    }];
    [self.arrayParameters addObject:consoleParameter13];
    
    ConsoleParameter *consoleParameter14 = [[ConsoleParameter alloc] init];
    consoleParameter14.option = @"--unlock-files";
    consoleParameter14.numArgs = 0;
    [consoleParameter14 setActionExecute:^BOOL (ConsoleParameter *consoleParameter, NSArray *values){
        self.unlockFiles = true;
        return true;
    }];
    [self.arrayParameters addObject:consoleParameter14];
}

- (ConsoleParameter *) consoleParameterWithOption:(NSString *) option {
	ConsoleParameter *consoleParameter = nil;
	for (ConsoleParameter *cp in self.arrayParameters) {
		if ((cp.option == nil && option == nil ) || [cp.option isEqualToString:option]) {
			consoleParameter = cp;
			break;
		}
	}
	return consoleParameter;
}

- (void) initDefaultValues {
    self.outputLocalizableDirectory = DEFAULT_LOCALIZABLE_OUTPUT;
    self.cloudBundleKey = nil;
    self.cloudVersion = nil;
    self.cloudCustomRegEx = nil;
    self.cloudAccesToken = DEFAULT_LOCALIZABLE_ACCES_TOKEN;
    self.cloudEndpoint = DEFAULT_LOCALIZABLE_ENDPOINT;
    self.unlockFiles = false;
    self.disableInputOutputFilesValidation = false;
}

#pragma mark - Load

- (void) loadWithArgs:(const char *[]) argv numArgs:(int) numArgs {
	[self initDefaultValues];
	[self registerParameters];
	
	if ([self managerArgs:argv numArgs:numArgs]) {
		[self executeAction];
	} else {
		[self printUsage];
	}
}

#pragma mark - Arguments

- (BOOL) managerArgs:(const char *[]) argv numArgs:(int) numArgs {
	BOOL result = true;
	NSString *lastOption = nil;
	for (int i = 0; i < numArgs; i++) {
		BOOL isCorrect = true;
		NSString *option = [NSString stringWithUTF8String:argv[i]];
		
		ConsoleParameter *consoleParameter;
		if (i == 0) {
			consoleParameter = [self consoleParameterWithOption:nil];
		} else {
			if ([self isArgOption:option]) {
				consoleParameter = [self consoleParameterWithOption:option];
			}
		}
		if (consoleParameter) {
			NSMutableArray *arrayValues = [NSMutableArray array];
			[arrayValues addObject:option];
			for (int j = 0; j < consoleParameter.numArgs; j++) {
				i++;
				if (i < numArgs) {
					[arrayValues addObject:[NSString stringWithUTF8String:argv[i]]];
				} else {
					isCorrect = false;
					break;
				}
			}
			if (isCorrect) {
				isCorrect = consoleParameter.actionExecute(consoleParameter, [arrayValues copy]);
			}
		} else {
			isCorrect = false;
		}
		
		lastOption = option;
		if (!isCorrect) {
			result = false;
			break;
		}
	}
	
	return result;
}

- (BOOL) isArgOption:(NSString *) arg {
	BOOL result = false;
	if ([arg hasPrefix:@"-"]) {
		result = true;
	}
	return result;
}

#pragma mark - Help

- (void)printUsage
{
	printf("Los valores válidos son los siguientes:\n");
	printf("-output-directory directorio de salida para el fichero localizableGenerate.strings generado\n"
           "-cloudBundleKey key de la aplicación cloud para descargar los ficheros\n"
           "-cloudVersion versión de la aplicación cloud para descargar los ficheros\n"
           "-cloudAccesToken acces token de la aplicación cloud para descargar los ficheros (por defecto el de SDOS)\n"
           "-cloudEndpoint endpoint de la aplicación cloud para descargar los ficheros (por defecto: %s)\n"
           "-cloudCustomRegEx listado de expresiones regulares separados por (%s). No pueden contener espacios. El caracter \\ se representa con \\\\ (Ejemplo \\\\{[^\\\\{\\\\}\\\\s]+\\\\})\n"
           "-output-file-name Nombre del fichero generado\n"
           "--disable-input-output-files-validation Deshabilita la validación de los inputs y outputs files. Usar sólo para dar compatibilidad a Legacy Build System\n"
           "--unlock-files Indica que los ficheros de salida no se deben bloquear en el sistema\n\n", [DEFAULT_LOCALIZABLE_ENDPOINT UTF8String], [CUSTOM_REG_EX_SEPARATOR UTF8String]);
}

#pragma mark - BL

- (void) executeAction {
    self.scriptActionSwift = [[ScriptActionSwift alloc] initWithOutputDirectory:self.outputLocalizableDirectory pwd:self.pwd unlockFiles:self.unlockFiles disableInputOutputFilesValidation:self.disableInputOutputFilesValidation];
    [self getFileFromCloud];
    [self.scriptActionSwift createTempFile];
    //exit(0);
}
    
- (void) getFileFromCloud {
    if (self.cloudBundleKey != nil && self.cloudVersion != nil) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?b=%@&v=%@", self.cloudEndpoint, self.cloudBundleKey, self.cloudVersion]];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request addValue:self.cloudAccesToken forHTTPHeaderField:@"Access-Token"];
        [request setHTTPMethod:@"GET"];
        
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                fprintf(stderr, "Cloud error: %s\n", [error.description UTF8String]);
                exit(1);
            } else {
                NSString *str;
                if ([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]) {
                    str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                } else {
                    str = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                }
                NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
                
                [self parseCloud:dictionary];
                
                dispatch_semaphore_signal(semaphore);
            }
        }];
        
        [postDataTask resume];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    }
}

- (void) parseCloud:(NSDictionary *) root {
    
    if ([root valueForKey:@"reason"]) {
        fprintf(stderr, "Cloud error: %s\n", [[root valueForKey:@"reason"] UTF8String]);
        exit(1);
    } else {
        NSMutableDictionary *supportedLocales = [NSMutableDictionary dictionary];
        if ([root valueForKey:@"supportedLocales"]) {
            for (NSString *key in [root valueForKey:@"supportedLocales"]) {
                NSString *keyFinal = [[key componentsSeparatedByString:@"_"] objectAtIndex:0];
                NSInteger num = 0;
                if ([supportedLocales valueForKey:keyFinal]) {
                    num = [[supportedLocales valueForKey:keyFinal] integerValue];
                }
                [supportedLocales setValue:@(num+1) forKey:keyFinal];
            }
        }
        if ([root valueForKey:@"content"]) {
            for (NSDictionary *language in [root valueForKey:@"content"]) {
                NSMutableArray *constants = [NSMutableArray array];
                if ([language valueForKey:@"messages"]) {
                    for (NSDictionary *languageKey in [language valueForKey:@"messages"]) {
                        NSString *keyFinal = [languageKey valueForKey:@"key"];
                        NSString *valueFinal = [self parseValueString:[languageKey valueForKey:@"value"]];
                        
                        [constants addObject:[NSString stringWithFormat:@"\"%@\" = \"%@\";", keyFinal, valueFinal]];
                    }
                }
                NSString *locale;
                NSString *keyFinal = [[[language valueForKey:@"locale"] componentsSeparatedByString:@"_"] objectAtIndex:0];
                NSInteger num = [[supportedLocales valueForKey:keyFinal] integerValue];
                if (num == 1) {
                    locale = keyFinal;
                } else {
                    locale = [[language valueForKey:@"locale"] stringByReplacingOccurrencesOfString:@"_" withString:@"-"];
                }
                [constants sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
                [self generateFileStringWithConstants:constants locale:locale];
            }
        }
    }
}

- (NSString *) parseValueString:(NSString *) value {
    NSError *error = nil;
    NSRegularExpression *regex1 = [NSRegularExpression regularExpressionWithPattern:@"\\%((\\d+)\\$(d))" options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *modifiedString = [regex1 stringByReplacingMatchesInString:value options:0 range:NSMakeRange(0, [value length]) withTemplate:@"%d"];
    
    NSRegularExpression *regex2 = [NSRegularExpression regularExpressionWithPattern:@"\\%((\\d+)\\$(f))" options:NSRegularExpressionCaseInsensitive error:&error];
    modifiedString = [regex2 stringByReplacingMatchesInString:modifiedString options:0 range:NSMakeRange(0, [modifiedString length]) withTemplate:@"%f"];
    
    NSRegularExpression *regex3 = [NSRegularExpression regularExpressionWithPattern:@"\\%((\\d+)\\$([a-su-zA-SU-Z]))|(\\%(\\d+)\\$(t\\w))" options:NSRegularExpressionCaseInsensitive error:&error];
    modifiedString = [regex3 stringByReplacingMatchesInString:modifiedString options:0 range:NSMakeRange(0, [modifiedString length]) withTemplate:@"%@"];

    for(NSString *regex in self.cloudCustomRegEx) {
        NSRegularExpression *customRegex = [NSRegularExpression regularExpressionWithPattern:[regex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] options:NSRegularExpressionCaseInsensitive error:&error];
        modifiedString = [customRegex stringByReplacingMatchesInString:modifiedString options:0 range:NSMakeRange(0, [modifiedString length]) withTemplate:@"%@"];
    }
    modifiedString = [modifiedString stringByReplacingOccurrencesOfString:@"\r\n" withString:@"\\r\\n"];
    
    return modifiedString;
}

- (void) generateFileStringWithConstants:(NSArray *) arrayConstants locale:(NSString *) locale {
    NSMutableString *stringInterfaceOutput = [self generateHeaderStringFile:arrayConstants];
    
    for (NSString *constantLocalizable in arrayConstants) {
        [stringInterfaceOutput appendFormat:@"%@\n", constantLocalizable];
    }
    
    NSError *error;
    
    NSString *outDirectory = [self.outputLocalizableDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.lproj/", locale]];
    [[NSFileManager defaultManager] createDirectoryAtPath:outDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    printf("\n");
    if (error) {
        printf("%s", [error.description UTF8String]);
    } else {
        NSString *path = [outDirectory stringByAppendingPathComponent:self.fileName];
        [self.scriptActionSwift validateInputOutputWithOutput:path];
        [self.scriptActionSwift unlockFile:path];
        [stringInterfaceOutput writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
        [self.scriptActionSwift lockFile:path];
        if (error) {
            printf("%s", [error.description UTF8String]);
        } else {
            printf("Fichero %s generado en la ruta %s\n", [self.fileName UTF8String], [outDirectory UTF8String]);
            printf("Generadas %lu claves", (unsigned long)arrayConstants.count);
        }
    }
    printf("\n");
}

- (NSMutableString *) generateHeaderStringFile:(NSArray *) arrayConstants{
    NSMutableString *stringOutput = [NSMutableString new];
    [stringOutput appendString:@"//  This is a generated file, do not edit!\n"];
    [stringOutput appendFormat:@"//  %@\n", self.fileName];
    [stringOutput appendString:@"//\n"];
    [stringOutput appendString:@"//  Created by SDOS\n"];
    [stringOutput appendString:@"//\n"];
    [stringOutput appendFormat:@"//  Generate %@ keys\n", @(arrayConstants.count)];
    [stringOutput appendString:@"\n"];
    
    return stringOutput;
}

@end
