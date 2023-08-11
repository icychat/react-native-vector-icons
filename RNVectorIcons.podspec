require 'json'
version = JSON.parse(File.read('package.json'))["version"]

folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -Wno-comma -Wno-shorten-64-to-32'

fabric_enabled = ENV['RCT_NEW_ARCH_ENABLED'] == '1'

Pod::Spec.new do |s|

  s.name           = "RNVectorIcons"
  s.version        = version
  s.summary        = "Customizable Icons for React Native with support for NavBar/TabBar, image source and full styling."
  s.homepage       = "https://github.com/oblador/react-native-vector-icons"
  s.license        = "MIT"
  s.author         = { "Joel Arvidsson" => "joel@oblador.se" }
  s.platforms      = { :ios => "13.4", :tvos => "9.0" }
  s.source         = { :git => "https://github.com/oblador/react-native-vector-icons.git", :tag => "v#{s.version}" }
  s.source_files   = 'RNVectorIconsManager/**/*.{h,m,mm,swift}'
  s.resources      = "Fonts/*.ttf"
  s.preserve_paths = "**/*.js"
  s.dependency 'React-Core'

  if fabric_enabled
    s.dependency "React-utils"
    s.subspec "xxxutils" do |ss|
      ss.dependency "ReactCommon"
      ss.dependency "React-utils"
      ss.source_files         = "react/utils/**/*.{cpp,h}"
      ss.header_dir           = "react/utils"
      ss.pod_target_xcconfig  = { "HEADER_SEARCH_PATHS" => "\"${PODS_CONFIGURATION_BUILD_DIR}/React-utils/React_utils.framework/Headers\"" }
    end
  end

  install_modules_dependencies(s)

end
