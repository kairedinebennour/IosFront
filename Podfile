# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

# arch -x86_64 pod install

post_install do |installer|   
      installer.pods_project.build_configurations.each do |config|
        config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
      end
end

target 'projetIOSAnimalyy' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for projetIOSAnimalyy
  pod 'Alamofire', '~> 5.4'
  pod 'SwiftyJSON', '~> 4.0'
  pod 'Braintree', '~> 4.22.0'
  pod 'AppCenter'
  
end


