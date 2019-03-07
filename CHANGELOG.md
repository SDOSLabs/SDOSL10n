## [1.9.0 Eliminadas algunas sustituciones](http://git.sdos.es/ios/SDOS/tree/v1.9.0)
- Se han eliminado las sustituciones que hacía la versión anterior para las ocurrencias de \n, \\, \r, \t y \". Por tanto, ahora escribir \n en l10n sí resulta en un salto de línea. 

## [1.8.0 Soporte para Swift](http://git.sdos.es/ios/SDOS/tree/v1.8.0)

- Añadido soporte para swift. Ahora se autogeneran métodos estáticos para que puedan ser invocados desde Swift
- Arreglo de tratamiento de nombre de imágenes. Ahora los "." se sustituyen por "_"

## [1.7.0 SDOSLocalizable con expresiones regulares ](http://git.sdos.es/ios/SDOS/tree/v1.7.0)

- Se ha modificado el script de SDOS y el de SDOSLocalizable para añadir la opción del tratamiento de los localizables descargados desde la plataforma l10n. Se pueden definir expresiones regulares que serán reemplazadas por %@.

## [1.6.1 Delete imports](http://git.sdos.es/ios/SDOS/tree/v1.6.1)

- Se han eliminado todos los imports de los módulos

## [1.6.0 Imports de los módulos](http://git.sdos.es/ios/SDOS/tree/v1.6.0)

- Se han vuelto a añadir todos los imports de los módulos. Es necesario usar use_moduler_headers en el podfile para el correcto funcionamiento

## [1.5.3 Añadida la dependencia SDOSHero. Soporte para Swift](http://git.sdos.es/ios/SDOS/tree/v1.5.3)

- Se han eliminado todos los imports de los demás módulos. Ahora se deben hacer en cada proyecto. Consultar la última versión del BaseProject para mirar los imports del .pch
- Añadida la dependencia SDOSHero.
- Se ha dado soporte para Swift modificando algunos imports de los ficheros autogenerados. Ahora es obligatorio hacer algunos imports en el fichero .pch (Seguir las instrucciones de cada fichero)

## [1.5.2 Añadida la dependencia SDOSHero. Soporte para Swift](http://git.sdos.es/ios/SDOS/tree/v1.5.2)

- Añadida la dependencia SDOSHero.
- Se ha dado soporte para Swift modificando algunos imports de los ficheros autogenerados. Ahora es obligatorio hacer algunos imports en el fichero .pch (Seguir las instrucciones de cada fichero)

## [1.5.1 Añadida la dependencia SDOSHero. Soporte para Swift](http://git.sdos.es/ios/SDOS/tree/v1.5.1)

- Añadida la dependencia SDOSHero.
- Se ha dado soporte para Swift modificando algunos imports de los ficheros autogenerados. Ahora es obligatorio hacer algunos imports en el fichero .pch (Seguir las instrucciones de cada fichero)

## [1.5.0 Añadida la dependencia SDOSHero](http://git.sdos.es/ios/SDOS/tree/v1.5.0)

- Añadida la dependencia SDOSHero.

## [1.4.0 Control de caracteres extraños](http://git.sdos.es/ios/SDOS/tree/v1.4.0)

- Añadida nuevo parámetro para el script de los localizable "forceBundleName". Este parámetro permite forzar un nombre de bundle de donde deberá coger los ficheros localzizable.
- El script de los localizable ahora coge los ficheros correctamente si están en un .bundle

## [1.3.1 Control de caracteres extraños](http://git.sdos.es/ios/SDOS/tree/v1.3.1)

- Corregidos los scripts ImagesConstants y SDOSLocalizable para que interpreten correctamente URLs de entrada que contengan espacios en blanco.
- Añadido un script al Build Phases de cada target (ImagesConstants, SDOS y SDOSLocalizable) para que borre automáticamente el ejecutable existente antes de generar el nuevo.  

## [1.3.0 Control de caracteres extraños](http://git.sdos.es/ios/SDOS/tree/v1.3.0)

- Añadido nuevo parámetro para el script de storyboards y el script general SDOS. Ahora se puede indicar que no genere las constantes de los segues. Parámetro: --skip-segue-constants
- Añadido nuevo parámetro para el script de storyboards y el script general SDOS. Ahora se puede indicar que los ficheros se generen con un prefijo. Parámetro: -prefix
- Añadida compatibilidad para generar constantes de imágenes a partir del .xccassets. Ahora genera constantes para las imágenes que esten contenidas en estos ficheros con el prefijo "IMG_XCA_"

## [1.2.4 Control de caracteres extraños](http://git.sdos.es/ios/SDOS/tree/v1.2.4)

- Controlado casos para: \n, \r y \t

## [1.2.3 Fix nombre de la propiedad cloudVersion](http://git.sdos.es/ios/SDOS/tree/v1.2.3)

- Arreglado nombre de la propiedad cloudVersion

## [1.2.2 Fix nombre de la propiedad cloudVersion](http://git.sdos.es/ios/SDOS/tree/v1.2.2)

- Arreglado nombre de la propiedad cloudVersion

## [1.2.1 Integración plataforma https://l10n.ws - Arreglos claves](http://git.sdos.es/ios/SDOS/tree/v1.2.1)

- Añadidos parámetros para la localización de strings:
	- cloudAccesToken: Access token de la aplicación
	- cloudEndpoint: Endpoint de la plataforma
- Modificado el endpoint por defecto a https://l10n.sdos.es/api/v1/m
- Para usar desde el script SDOS es necesario configurar los siguientes parametros
	- localizableShowWarnings
	- localizableInput
	- localizableOutput
	- localizableOutputStrings
	- localizableCloudBundleKey
	- localizableCloudVersion
	- localizableCloudAccesToken
	- localizableCloudEndpoint

## [1.2.0 Integración plataforma https://l10n.ws](http://git.sdos.es/ios/SDOS/tree/v1.2.0)

- Se ha integrado la plataforma l10n. Ahora el script SDOSLocalizable tiene 2 nuevos parámetros:
	- cloudBundleKey: key de la aplicación cloud para descargar los ficheros
	- cloudVersion: versión de la aplicación cloud para descargar los ficheros
- Estos nuevos comandos se pueden configurar directamente desde el script SDOS. Al asignarle un valor, cuando genere las constantes se conectará a la plataforma y generará nuevos ficheros con los strings configurados en la propia plataforma

## [1.1.0 Modificados puntos de entrada y nuevo script de constantes de localizables](http://git.sdos.es/ios/SDOS/tree/v1.1.0)

- Se ha añadido un nuevo script para generar las constantes de los ficheros .strings. Este script se encarga de comparar los diferentes ficheros con el mismo nombre en diferentes idiomas y detecta aquellas keys que no estén incluidas en todos los ficheros. El fichero de salida es "LocalizableConstants.h". El punto de entrada para la busqueda de ficheros es la ruta "./App/Others/Localization"
- Se han modificado los puntos de entrada por defecto de los scripts. Ahora empiezan a buscar desde la carpeta App.

## [1.0.4 Fix error script storyboard](http://git.sdos.es/ios/SDOS/tree/v1.0.4)

- Arreglado el error en el script de constantes de storyboard por el que no es utilizaba el directorio de entrada al generar los nombres de los controladores

## [1.0.3 Fix error script storyboard](http://git.sdos.es/ios/SDOS/tree/v1.0.3)

- Arreglado un problema con el script de constantes de storyboard que hacía que no funcionara correctamente al pasarle parámetros

## [1.0.2 Modificación script de generación de constantes de imágenes](http://git.sdos.es/ios/SDOS/tree/v1.0.2)

- Se ha modificado el script de generación de constantes de imágenes para aumentar su velocidad. Ahora está escrito en Objective-c.

## [1.0.1 Eliminación de las versiones de las dependencias](http://git.sdos.es/ios/SDOS/tree/v1.0.1)

- Eliminado del podspec las versiones de las dependencias.

## [1.0.0 Primera versión](http://git.sdos.es/ios/SDOS/tree/v1.0.0)

- Añadidas las conexiones con todas las librerías que conforman el nuevo Core de desarrollo SDOS
