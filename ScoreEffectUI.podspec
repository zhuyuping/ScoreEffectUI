Pod::Spec.new do |spec|
  spec.name         = "ScoreEffectUI"
  spec.version      = "1.0.1"
  spec.summary      = "ScoreEffectUI"
  spec.description  = "ScoreEffectUI"

  spec.homepage     = "https://github.com"
  spec.license      = "MIT"
  spec.author       = { "ZYP" => "zhuyuping@agora.io" }
  spec.source       = { :git => "https://github.com/zhuyuping/ScoreEffectUI.git", :tag => '1.0.1' }
  spec.source_files  = "Class/**/*.swift"
  spec.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64', 'DEFINES_MODULE' => 'YES' }
  spec.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64', 'DEFINES_MODULE' => 'YES' }
  spec.ios.deployment_target = '10.0'
  spec.swift_versions = "5.0"
  spec.requires_arc  = true
  spec.resource_bundles = {
    'ScoreEffectUIBundle' => ['Resources/*.xcassets']
  }
  
  spec.test_spec 'Tests' do |test_spec|
    test_spec.source_files = "Tests/**/*.{swift}"
    test_spec.frameworks = 'UIKit','Foundation'
  end
end
