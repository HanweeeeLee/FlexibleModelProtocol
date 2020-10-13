

Pod::Spec.new do |spec|

  spec.name         = "FlexibleModelProtocol"
  spec.version      = "1.0.1"
  spec.summary      = "FlexibleModelProtocol"
  spec.swift_version   = '5.0'
  spec.license      = 'MIT'
  spec.description  = <<-DESC
Navigation view whose shape changes depending on the scroll position
                   DESC

  spec.homepage     = "https://github.com/HanweeeeLee/FlexibleModelProtocol"
  
  spec.author             = { "hanwe lee" => "mobiledev@kakao.com" }
  
  spec.source       = { :git => "https://github.com/HanweeeeLee/FlexibleModelProtocol.git", :tag => "1.0.1" }


  
  spec.source_files  = 'FlexibleModelProtocol/**/*.{h,m,swift}','FlexibleModelProtocolTests/**/*.{h,m,swift}'
  spec.exclude_files = "Classes/Exclude"
  spec.platform = :ios, "11.0"

end
