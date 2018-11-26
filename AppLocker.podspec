
Pod::Spec.new do |s|

  s.name         = "AppLocker"
  s.version      = "2.0"
  s.summary      = "Simple lockscreen for iOS Application"

  s.description  = <<-DESC
AppLocker - simple lock screen for iOS Application 
                   DESC

  s.homepage     = "https://github.com/Ryasnoy/AppLocker"

  s.license      = { :type => "MIT", :file => "LICENSE" }


 
  s.author             = { "Oleg Ryasnoy" => "ryasnoy.oleg@gmail.com" }
  s.social_media_url   = "http://twitter.com/ryasn0y"
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/Ryasnoy/AppLocker.git", :tag => "#{s.version}" }
  s.source_files = "Source/**/*.{xib,swift}"

  s.dependency 'Valet'

  s.swift_version = '4.0'	

end
