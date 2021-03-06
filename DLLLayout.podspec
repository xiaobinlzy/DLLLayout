Pod::Spec.new do |s|
  s.name             = 'DLLLayout'
  s.version          = '0.1.1'
  s.summary          = 'DLLLayout 是一个基于 UIView.frame 的轻量级 iOS 布局框架。'


  s.description      = <<-DESC
DLLLayout 是一个基于 UIView.frame 的轻量级 iOS 布局框架。相比苹果的 AutoLayout，它有着更友善的 API 和更高的性能，虽然功能上不如 AutoLayout 大又全，比如不支持 greaterThan、lesserThan、priority 等，但也能够满足90%以上的业务场景。在性能上，如果需要通过视图内容自适应宽高（例如 UILabel、UIButton 根据内容计算宽高），布局耗时为苹果 AutoLayout 的 1/2 左右；反之如果设置了视图的宽高，布局耗时只有苹果 AutoLayout 的不到 1/8。
给 UIView 设置布局规则，通过 hook UIView.layoutSubviews，在这个方法里对设置过布局规则的视图设置 frame，实现布局功能。因为布局活动触发在系统的 layoutSubviews 之前，所以仍然可以通过重写子类的 layoutSubviews 来实现自己的布局。
                       DESC

  s.homepage         = 'https://github.com/xiaobinlzy/DLLLayout'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xiaobinlzy' => 'xiaobinlzy@163.com' }
  s.source           = { :git => 'https://github.com/xiaobinlzy/DLLLayout.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '6.0'

  s.source_files = 'DLLLayout/**/*'
  s.public_header_files = 'DLLLayout/DLLLayout.h', 'DLLLayout/DLLLayoutDefine.h', 'DLLLayout/UIView+DLLLayout.h', 'DLLLayout/DLLLayoutRelativeMaker.h', 'DLLLayout/DLLLayoutRelative.h'


end
