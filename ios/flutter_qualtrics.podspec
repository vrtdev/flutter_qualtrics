#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_qualtrics.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_qualtrics'
  s.version          = '0.0.1'
  s.summary          = 'A Flutter plugin which bridges Qualtrics\' Mobile iOS
   Intercept SDK.'
  s.description      = <<-DESC
This plugin bridges Qualtrics' Mobile iOS Intercept SDK to Flutter. Official
documentation can be found at https://api.qualtrics
.com/docs/mobile-ios-intercept-sdk.
                       DESC
  s.homepage         = 'https://github.com/vrtdev/flutter_qualtrics/'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'VRT' => 'jeremie@movify.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'Qualtrics', '1.16'
  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.2'
end
