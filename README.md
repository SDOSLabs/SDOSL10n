- [SDOSL10n](#sdosl10n)
  - [Introducción](#introducción)
  - [Instalación](#instalación)
    - [Cocoapods](#cocoapods)
    - [Swift Package Manager](#swift-package-manager)
  - [Cómo se usa](#cómo-se-usa)

# SDOSL10n

- Enlace confluence: https://kc.sdos.es/x/YALLAQ
- Changelog: https://github.com/SDOSLabs/SDOSL10n/blob/master/CHANGELOG.md

## Introducción
SDOSL10n es un script que genera los ficheros `.strings` a partir de un proyecto creado en la plataforma https://l10n.sdos.es o de un portal derivado de https://github.com/l10nws/l10n-app. Esta plataforma permite definir los strings de un proyecto en varios idiomas y se pueden usar tanto en iOS como en Android.

## Instalación

### Cocoapods

Usaremos [CocoaPods](https://cocoapods.org).

Añadir el "source" privado de SDOSLabs al `Podfile`. Añadir también el source público de cocoapods para poder seguir instalando dependencias desde éste:
```ruby
source 'https://github.com/SDOSLabs/cocoapods-specs.git' #SDOSLabs source
source 'https://github.com/CocoaPods/Specs.git' #Cocoapods source
```

Añadir la dependencia al `Podfile`:
```ruby
pod 'SDOSL10n', '~> 1.1.0' 
```

### Swift Package Manager

Esta librería la usaremos en la `Build Phase` de nuestro proyecto. El script de esta librería no se debe incluir en el binario de la aplicación y sólamente servirá para generar código. Para que podamos usarlo deberemos instalar la librería de la siguiente forma:

1. Crearnos una dependencia local en nuestro proyecto. Para ello nuestro proyecto debe estar incluido en un `.xcworkspace`. Debemos pulsar el botón `+` situado en la parte inferior izquierda del Xcode y seleccionar la opción "New Swift Package...".
2. Le pondremos el nombre "Autogenerate" al paquete.
3. Añadiremos la dependencia de `SDOSL10n` en el `Package.swift`, sin necesidad de añadirlo al target:

``` swift
dependencies: [
    .package(url: "https://github.com/SDOSLabs/SDOSL10n.git", .upToNextMajor(from: "1.1.0"))
]
```

De esta forma tendremos una carpeta en la raiz de nuestro proyecto que se llamará "Autogenerate" que contendrá un fichero `Package.swift` que usaremos más adelante para ejecutar el script.

## Cómo se usa

Hay que lanzar un script durante la compilación que generará los ficheros `.strings` configurados en el proyecto de l10n indicado. Estos ficheros deberán añadirse en el proyecto. Para la ejecución del script hay que seguir los siguientes pasos:

1. En Xcode: Pulsar sobre *File*, *New*, *Target*, elegir la opción *Cross-platform*, seleccionar *Aggregate* e indicar el nombre *L10n*
2. Seleccionar el proyecto, elegir el TARGET que acabamos de crear, seleccionar la pestaña de `Build Phases` y pulsar en añadir `New Run Script Phase` en el icono de **`+`** arriba a la izquierda
3. (Opcional) Renombrar el script a `L10n`
4. Copiar el siguiente script:

    **Si la instalación es con cocoapods**
    ```sh
    if [ -x "$PODS_ROOT/SDOSL10n/src/Scripts/SDOSL10n" ]; then
        "$PODS_ROOT/SDOSL10n/src/Scripts/SDOSL10n" -cloudAccesToken ${L10N_ACCESS_TOKEN} -cloudVersion ${L10N_VERSION} -cloudBundleKey ${L10N_BUNDLE_KEY} -output-directory "${SRCROOT}/main/resources/generated" -output-file-name "LocalizableGenerated.strings"
    fi
    ```
    **Si la instalación es con Swift Package Manager**
    ```sh
    SPM_PATH="${SRCROOT}/Autogenerate"

    (cd $SPM_PATH && xcrun --sdk macosx swift run SDOSL10nScript -cloudAccesToken ${L10N_ACCESS_TOKEN} -cloudVersion ${L10N_VERSION} -cloudBundleKey ${L10N_BUNDLE_KEY} -output-directory "${SRCROOT}/main/resources/generated" -output-file-name "LocalizableGenerated.strings")
    ```
    > Los valores del script pueden cambiarse en función de las necesidades del proyecto
5. Añadir `${TEMP_DIR}/SDOSL10n-lastrun` al apartado `Input Files`. **No poner comillas**
6. Añadir `${SRCROOT}/main/resources/generated/es.lproj/LocalizableGenerated.strings` al apartado `Output Files`. **No poner comillas**. **Cuidado**: este valor variará dependiendo de los idiomas que tenga el proyecto de L10n. Hay que añadir todos los ficheros `.strings` que genere el script a este paso
7. Editar el Scheme del target de *L10n* para marcar la opción *Shared*
8. Compilar el scheme del target. Esto generará los ficheros en la ruta `${SRCROOT}/main/resources/generated` que deberán ser incluidos en el proyecto. **Hay que añadir los fichero `.strings`, no las carpetas**

Los valores del script `${L10N_ACCESS_TOKEN}`, `${L10N_VERSION}` y `${L10N_BUNDLE_KEY}` son parámetros que deben estar en el *Build Settings* del TARGET. Por lo general, estos parámetros están definidos en el fichero `.xcconfig` del proyecto. Hay que asegurarse que los ficheros `.xcconfig` están añadidos al TARGET de L10n. Esta configuración se puede consultar en el proyecto, siguiendo los siguientes pasos:
1. Seleccionar el proyecto, elegir el *Project* y pulsar sobre el apartado *Info*
2. En la parte de *Configurations* desplegar las diferentes configuraciones y comprobar que el target *L10n* tiene configurado el fichero `.xcconfig` correcto
3. (Comprobación) Seleccionar el apartado *Build Settings* y realizar una búsqueda de cualquiera de las claves indicadas anteriormente (*L10N_ACCESS_TOKEN*, *L10N_VERSION* o *L10N_BUNDLE_KEY*). Comprobar que aparezcan resultados con los valores correctos


Además de estos pasos el script tiene otros parámetros que pueden incluirse en base a las necesidades del proyecto:

|Parámetro|Obligatorio|Descripción|Ejemplo|
|---------|-----------|-----------|-----------|
|`-output-directory [valor]`|[x]|Directorio de salida para el fichero localizableGenerate.strings generado | `${SRCROOT}/main/resources/generated`|
|`-cloudBundleKey [valor]`|[x]|Key del proyecto de l10n  para generar los ficheros|`yyyyy`|
|`-cloudVersion`|[x]|Versión del proyecto de l10n para generar los ficheros |`1.0.0`|
|`-cloudAccesToken`||Access token del proyecto cloud para generar los ficheros (por defecto el de SDOS)|`xxxxx`|
|`-cloudEndpoint`||Endpoint de la aplicación cloud para descargar los ficheros|`https://l10n.sdos.es/api/v1/m`|
|`-cloudCustomRegEx`||Listado de expresiones regulares separados por (%s). No pueden contener espacios. El caracter \\\\ se representa con \\\\\\\\|`\\{[^\\{\\}\\s]+\\}` esta expresión sustituye un string con formato `{dato}` por `%@`|
|`-output-file-name`|[x]|Nombre del fichero generado|`LocalizableGenerated.strings`|
|`--disable-input-output-files-validation`||Deshabilita la validación de los inputs y outputs files. Usar sólo para dar compatibilidad a `Legacy Build System`|
|`--unlock-files`||Indica que los ficheros de salida no se deben bloquear en el sistema|
