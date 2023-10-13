# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'MyMap' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MyMap

pod 'FirebaseAuth'
pod 'FirebaseDatabase'
pod 'FirebaseCore'
pod 'Alamofire'

pod 'KakaoSDKCommon'
pod 'KakaoSDKAuth'  
pod 'KakaoSDKUser'

end

post_install do |installer|   

      installer.pods_project.build_configurations.each do |config|

        config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"

      end

end