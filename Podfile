platform :ios, '11.0'
workspace 'CondorUIComponents.xcworkspace'
use_frameworks!

target 'CondorUIComponents' do
  project 'CondorUIComponents'
  inherit! :search_paths
  pod 'MaterialComponents/TextFields'
  pod 'BEMCheckBox'
end

target 'CondorUIComponentsTests' do
  inherit! :search_paths
end

target 'ProofOfConcept' do
  project 'ProofOfConcept/ProofOfConcept'
  pod 'CondorUIComponentsIOS', :path=>'./'
end
