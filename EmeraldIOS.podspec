Pod::Spec.new do |spec|
  spec.resources = ['Resources/Images/*.png', 'EmeraldIOS/**/*.{xcassets}', 'EmeraldIOS.bundle']
  spec.resource_bundles  = { "Resources" => ["Resources/Fonts/*.ttf", "Resources/Images/*.png", "Resources/Images/*.pdf","EmeraldIOS/**/*.{xcassets}", "EmeraldIOS.bundle"] }
  spec.name                 = "EmeraldIOS"
  spec.version              = "1.4.3"
  spec.summary              = "Custom widgets management"
  spec.description          = "Custom widgets management."
  spec.homepage             = "https://github.com/cebroker/emerald-ios.git"
  spec.license              = { :type => "MIT", :file => "LICENSE" }
  spec.author               = { "CE Broker" => ""}
  spec.platform             = :ios, "11.0"
  spec.source               = { :git => "https://github.com/cebroker/emerald-ios.git", :tag => "#{spec.version}" }
  spec.source_files         = "EmeraldIOS/**/*.{swift}"
  spec.swift_version        = "5.0"
  spec.dependency 'BEMCheckBox'
  spec.dependency 'Charts'
end
