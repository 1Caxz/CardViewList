Pod::Spec.new do |s|
  s.name = 'CardViewList'
  s.version = '1.1.4'
  s.license = 'MIT'
  s.summary = 'Create CardView like Android easier in iOS.'
  s.homepage = 'https://github.com/icaksama/CardViewList'
  s.social_media_url = 'http://twitter.com/icaksama'
  s.authors = { 'icaksama' => 'icaksama@gmail.org' }
  s.source = { :git => 'https://github.com/icaksama/CardViewList.git', :tag => s.version }
  s.platform = :ios, '8.0'
  s.ios.deployment_target = '8.0'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }
  s.source_files = 'CardViewList/CardViewList/**/*.{swift,h}'
end
