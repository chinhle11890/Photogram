# Uncomment this line to define a global platform for your project
platform :ios, '8.0'
use_frameworks!

target 'Photogram' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks


  # Pods for Photogram

pod 'TextFieldEffects'
pod 'JSQMessagesViewController'
pod 'ALRadial'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
