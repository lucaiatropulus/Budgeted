# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Budgeted - UIKit Test' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Budgeted - UIKit Test
   
   	pod 'Firebase/Auth'
   	pod 'Firebase/Firestore'
   	pod 'Firebase/Storage'
	pod 'lottie-ios'
	
post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12'
      end
    end
end
end
