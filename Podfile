inhibit_all_warnings!
use_frameworks! # Defaulting to use_frameworks! See pre_install hook below for static linking.
use_modular_headers!

platform :ios, '11.0'
workspace 'WooCommerce.xcworkspace'

plugin 'cocoapods-repo-update'

# Main Target!
# ============
#
target 'WooCommerce' do
  project 'WooCommerce/WooCommerce.xcodeproj'


  # Automattic Libraries
  # ====================
  #

  # Use the latest bugfix for coretelephony
  #pod 'Automattic-Tracks-iOS', :git => 'https://github.com/Automattic/Automattic-Tracks-iOS.git', :tag => '0.2.4-beta.1'
  pod 'Automattic-Tracks-iOS', '0.3.3'

  pod 'Gridicons', '~> 0.18'
  
  # To allow pod to pick up beta versions use -beta. E.g., 1.1.7-beta.1
  pod 'WordPressAuthenticator', :git => 'git@github.com:wordpress-mobile/WordPressAuthenticator-iOS.git', :branch => 'static-framework'

  pod 'WordPressShared', :git => 'git@github.com:wordpress-mobile/WordPress-iOS-Shared.git', :branch => 'static-framework'
  pod 'WordPressUI', :git => 'git@github.com:wordpress-mobile/WordPressUI-iOS.git', :branch => 'static-framework'
  pod 'WordPressKit', :git => 'git@github.com:wordpress-mobile/WordPressKit-iOS.git', :branch => 'static-framework'

  # External Libraries
  # ==================
  #
  pod 'Alamofire', '~> 4.7'
  pod 'Crashlytics', '~> 3.10'
  pod 'KeychainAccess', '~> 3.1'
  pod 'CocoaLumberjack', '~> 3.4'
  pod 'CocoaLumberjack/Swift', '~> 3.4'
  pod 'XLPagerTabStrip', '~> 8.1'
  pod 'Charts', '~> 3.2'
  pod 'ZendeskSDK', '~> 2.3.1'

  # Unit Tests
  # ==========
  #
  target 'WooCommerceTests' do
    inherit! :search_paths
  end

end

# Yosemite Layer:
# ===============
#
def yosemite_pods
  pod 'Alamofire', '~> 4.7'
  pod 'CocoaLumberjack', '~> 3.4'
  pod 'CocoaLumberjack/Swift', '~> 3.4'
end

# Yosemite Target:
# ================
#
target 'Yosemite' do
  project 'Yosemite/Yosemite.xcodeproj'
  yosemite_pods
end

# Unit Tests
# ==========
#
target 'YosemiteTests' do
  project 'Yosemite/Yosemite.xcodeproj'
  yosemite_pods
end

# Networking Layer:
# =================
#
def networking_pods
  pod 'Alamofire', '~> 4.7'
  pod 'CocoaLumberjack', '~> 3.4'
  pod 'CocoaLumberjack/Swift', '~> 3.4'
end

# Networking Target:
# ==================
#
target 'Networking' do
  project 'Networking/Networking.xcodeproj'
  networking_pods
end

# Unit Tests
# ==========
#
target 'NetworkingTests' do
  project 'Networking/Networking.xcodeproj'
  networking_pods
end


# Storage Layer:
# ==============
#
def storage_pods
  pod 'CocoaLumberjack', '~> 3.4'
  pod 'CocoaLumberjack/Swift', '~> 3.4'
end

# Storage Target:
# ===============
#
target 'Storage' do
  project 'Storage/Storage.xcodeproj'
  storage_pods
end

# Unit Tests
# ==========
#
target 'StorageTests' do
  project 'Storage/Storage.xcodeproj'
  storage_pods
end

# Static Frameworks:
# ============
#
# Make all pods that are not shared across multiple targets into static frameworks by overriding the static_framework? function to return true
# Linking the shared frameworks statically would lead to duplicate symbols
# A future version of CocoaPods may make this easier to do. See https://github.com/CocoaPods/CocoaPods/issues/7428
pre_install do |installer|
  installer.pod_targets.each do |pod|
    next if pod.target_definitions.length > 1
    def pod.static_framework?;
      true
    end
  end
end

# Workarounds:
# ============
#
post_install do |installer|

  # Workaround: Drop 32 Bit Architectures
  # =====================================
  #
  installer.pods_project.build_configuration_list.build_configurations.each do |configuration|
    configuration.build_settings['VALID_ARCHS'] = '$(ARCHS_STANDARD_64_BIT)'
  end
end
