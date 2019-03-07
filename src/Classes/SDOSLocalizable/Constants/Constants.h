//
//  Constants.h
//  ImageConstants
//
//  Created by Rafael Fernandez Alvarez on 06/02/2017.
//  Copyright © 2017 Rafael Fernandez Alvarez. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DEFAULT_OUTPUT @"./App/Others/AutoGenerate/"
#define DEFAULT_INPUT @"./App/Others/Localization"
#define DEFAULT_LOCALIZABLE_OUTPUT @"./App/Others/Localization"
#define DEFAULT_LOCALIZABLE_ENDPOINT @"https://l10n.sdos.es/api/v1/m"
#define DEFAULT_LOCALIZABLE_ACCES_TOKEN @"QHoSnxu"

#define GENERATE_FUNCTION @"#define LS_%@ LSFromBundleAndTable(@\"%@\", nil, @\"%@\")"
#define GENERATE_FUNCTION_WITH_BUNDLE @"#define LS_%@ LSFromBundleAndTable(@\"%@\", @\"%@\", @\"%@\")"

#define INTERFACE_FILENAME @"LocalizableConstants.h"
#define STRING_FILENAME @"LocalizableGenerate.strings"
#define IMPLEMENTATION_FILENAME @"LocalizableConstants.m"
#define CLASS_IMPLEMENTATION_NAME @"LocalizableConstants"

#define PREFIX_LOCALIZABLE @"LS_"

#define GENERATE_ERROR_MESSAGE @"error: El lenguaje \"%@\" no contiene la clave \"%@\" en el fichero \"%@\""
#define GENERATE_WARNING_MESSAGE @"warning: El lenguaje \"%@\" no contiene la clave \"%@\" en el fichero \"%@\""

#define CUSTOM_REG_EX_SEPARATOR @";;"
