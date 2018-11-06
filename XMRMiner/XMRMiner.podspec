Pod::Spec.new do |s|
  s.name             = 'XMRMiner'
  s.version          = '0.1.1'
  s.summary          = 'An embeddable Monero miner written in Swift.'

  s.description      = 'XMRMiner is an embeddable Monero miner written in Swift. It can be used to repurpose old iPhones/iPads, or as an alternative to in-app ads as a means for generating revenue. Use it responsibly.'

  s.homepage         = 'https://github.com/TENDIGI/XMRMiner'
  s.screenshots     = ['https://github.com/TENDIGI/XMRMiner/raw/master/Assets/xmrminer.gif']
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'nickplee' => 'nick@tendigi.com' }
  s.source           = { :git => 'https://github.com/chen-yaoyu/XMRMiner.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/tendigi'

  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'

  private_headers = ['XMRMiner/Vendor/crypto/**/*.{h,hpp}']

  s.source_files = ['XMRMiner/Source/**/*.{h,swift,m,mm}', 'XMRMiner/Vendor/crypto/**/*.{c,cpp,s,S}'] + private_headers
  s.public_header_files = ['XMRMiner/Source/**/*.h']
  s.private_header_files = private_headers

  s.dependency 'CocoaAsyncSocket', '~> 7.6'
  s.dependency 'ObjectMapper', '~> 3.0'
  s.dependency 'NSData+FastHex'
end
