@version = "1.1.0"
Pod::Spec.new do |spec|
  spec.platform     = :ios, '9.0'
  spec.name         = 'SDOSL10n'
  spec.authors      = 'SDOS'
  spec.version      = @version
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/SDOSLabs/SDOSL10n'
  spec.summary      = 'Librería para la conversión de textos de la plataforma l10n a ficheros .string de Xcode'
  spec.source       = { :git => "https://github.com/SDOSLabs/SDOSL10n.git", :tag => "#{spec.version}" }

  spec.preserve_paths = "src/Scripts/SDOSL10n"

end
