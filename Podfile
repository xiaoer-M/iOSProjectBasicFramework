platform :ios, '8.0'

inhibit_all_warnings!

target 'i84zcc' do
pod 'Masonry'
pod 'MBProgressHUD'
pod 'AFNetworking'
pod 'IQKeyboardManager'
pod 'SDWebImage'
pod 'YYModel'
pod 'YYText'
pod 'MJRefresh'
pod 'UITableView+FDTemplateLayoutCell'
pod 'CTMediator'
pod 'FMDB'

#为了去除第三方版本警告，只要支持到8.0以上
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 8.0
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '8.0'
      end
    end
  end
end

end
