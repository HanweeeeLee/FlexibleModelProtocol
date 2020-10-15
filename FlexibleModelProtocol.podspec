

Pod::Spec.new do |spec|

  spec.name         = "FlexibleModelProtocol"
  spec.version      = "1.0.2"
  spec.license      = 'MIT'
  spec.summary      = "Model protocol with flexible, diverse types of conversion"
  spec.homepage     = "https://github.com/HanweeeeLee/FlexibleModelProtocol"
  spec.author             = { "hanwe lee" => "mobiledev@kakao.com" }
  spec.source       = { :git => "https://github.com/HanweeeeLee/FlexibleModelProtocol.git", :tag => "1.0.2" }

  spec.platform = :ios, "11.0"

  spec.swift_version   = '5.0'

  spec.source_files  = 'FlexibleModelProtocol/FlexibleModelProtocol/*.{h,m,swift}'
  
  spec.description  = <<-DESC
Navigation view whose shape changes depending on the scroll position
                   DESC
  
  spec.exclude_files = "Classes/Exclude"

end
