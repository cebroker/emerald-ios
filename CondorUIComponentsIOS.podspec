Pod::Spec.new do |spec|

  spec.name         = "CondorUIComponentsIOS"
  spec.version      = "0.0.2"
  spec.summary      = "Custom widgets management"
  spec.description  = "Custom widgets management."
  spec.homepage     = "https://github.com/cebroker/CondorUIComponentsIOS"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "CE Broker" => ""}
  spec.platform     = :ios, "11.0"
  spec.source       = { :git => "https://github.com/cebroker/CondorUIComponentsIOS.git", :tag => "#{spec.version}" }
  spec.source_files  = "CondorUIComponents/**/*.{swift}"
  spec.swift_version = "4.2"

  spec.dependency 'MaterialComponents/TextFields'
  spec.dependency 'BEMCheckBox'

end
