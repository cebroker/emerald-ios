platform :ios, '13.0'
workspace 'EmeraldIOS.xcworkspace'
use_frameworks!

target 'EmeraldIOS' do
  project 'EmeraldIOS'
  inherit! :search_paths
  pod 'BEMCheckBox'
  pod 'Charts'
end

target 'EmeraldIOSTests' do
  inherit! :search_paths
end

target 'ProofOfConcept' do
  project 'ProofOfConcept/ProofOfConcept'
  pod 'EmeraldIOS', :path=>'./'
end
