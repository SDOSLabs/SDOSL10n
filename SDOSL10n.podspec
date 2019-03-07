@version = "0.9.0"
Pod::Spec.new do |spec|
  spec.platform     = :ios, '9.0'
  spec.name         = 'SDOS'
  spec.authors      = 'SDOS'
  spec.version      = @version
  spec.license      = { :type => 'SDOS License' }
  spec.homepage     = 'https://svrgitpub.sdos.es/iOS/SDOSL10n'
  spec.summary      = 'Librería para la conversión de textos de la plataforma l10n a ficheros .string de Xcode'
  spec.source       = { :git => "https://svrgitpub.sdos.es/iOS/SDOSL10n.git", :tag => "v#{spec.version}" }

  spec.preserve_paths = "src/Scripts/*"

end
