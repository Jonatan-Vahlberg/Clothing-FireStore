target 'Clothing-FireStore' do
use_frameworks!

pod 'Firebase/Core'
pod 'Firebase'
pod 'Firebase/Auth'
pod 'Firebase/Database'
pod 'Firebase/Firestore'
pod 'SVProgressHUD'
pod 'ChameleonFramework'


end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['CLANG_WARN_DOCUMENTATION_COMMENTS'] = 'NO'
        end
    end
end
