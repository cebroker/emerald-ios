Pod::Spec.new do |spec|
  spec.resource             = "CondorUIComponents/Fonts/*.ttf"
  spec.name                 = "CondorUIComponentsIOS"
  spec.version              = "0.0.9"
  spec.summary              = "Custom widgets management"
  spec.description          = "Custom widgets management."
  spec.homepage             = "https://github.com/cebroker/CondorUIComponentsIOS"
  spec.license              = { :type => "MIT", :file => "LICENSE" }
  spec.author               = { "CE Broker" => ""}
  spec.platform             = :ios, "11.0"
  spec.source               = { :git => "https://github.com/cebroker/CondorUIComponentsIOS.git", :tag => "#{spec.version}" }
  spec.source_files         = "CondorUIComponents/**/*.{swift}"
  spec.swift_version        = "4.2"
  spec.dependency 'BEMCheckBox'
end
