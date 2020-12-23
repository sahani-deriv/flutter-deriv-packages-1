#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint survey_monkey.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'survey_monkey'
  s.version          = '0.0.1'
  s.summary          = 'SurveyMonkey Flutter plugin.'
  s.description      = <<-DESC
SurveyMonkey Flutter plugin.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'
  s.preserve_paths = 'SurveyMonkeyiOSSDK.framework'
  s.xcconfig = { 'OTHER_LDFLAGS' => '-framework SurveyMonkeyiOSSDK' }
  s.vendored_frameworks = 'SurveyMonkeyiOSSDK.framework'
  
  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
  s.public_header_files = 'Classes/**/*.h'
end
