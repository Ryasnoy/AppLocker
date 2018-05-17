
Pod::Spec.new do |s|

  s.name         = "AppLocker"
  s.version      = "0.0.1"
  s.summary      = "Simple lockscreen for iOS Application"

  s.description  = <<-DESC
AppLocker - simple lock screen for iOS Application 
                   DESC

  s.homepage     = "https://github.com/Ryasnoy/AppLocker"

  s.license      = { :type => "MIT", :file => "LICENSE" }


 
  s.author             = { "Oleg Ryasnoy" => "ryasnoy.oleg@gmail.com" }
  s.social_media_url   = "http://twitter.com/ryasn0y"
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Ryasnoy/AppLocker.git", :tag => "#{s.version}" }
  s.source_files = "Source/*.{xib,swift}"

  #s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"
  s.swift_version = '3.0'	

end
