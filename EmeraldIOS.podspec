Pod::Spec.new do |spec|
  spec.resource_bundles  = { "Resources" => ["Resources/Fonts/*.ttf", "Resources/Images/*.png"] }
  spec.name                 = "EmeraldIOS"
  spec.version              = "0.1.0"
  spec.summary              = "Custom widgets management"
  spec.description          = "Custom widgets management."
  spec.homepage             = "https://github.com/cebroker/CondorUIComponentsIOS"
  spec.license              = { :type => "MIT", :file => "LICENSE" }
  spec.author               = { "CE Broker" => ""}
  spec.platform             = :ios, "11.0"
  spec.source               = { :git => "git@github.com:cebroker/CondorUIComponentsIOS.git", :tag => "#{spec.version}" }
  spec.source_files         = "EmeraldIOS/**/*.{swift}"
  spec.swift_version        = "4.2"
  spec.dependency 'BEMCheckBox'
end
