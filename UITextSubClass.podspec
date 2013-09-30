Pod::Spec.new do |s|
  s.name         = "UITextSubClass"
  s.version      = "0.0.1"
  s.summary      = "UITextField/UITextView SubClass library."
  s.homepage     = "https://github.com/azu/UITextSubClass"
  s.screenshots  = "https://monosnap.com/image/TSwA3hPoDkdrr1jJRnGaaFQpI.png"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "azu" => "info@efcl.info" }
  s.platform     = :ios, '5.0'
  s.source       = { :git => "https://github.com/azu/UITextSubClass.git" }
  s.subspec 'Core' do |a|
    a.source_files  = 'UITextSubClass/UITextSubClassHelper.{h,m}'
  end
  s.subspec 'UITextFieldWithDatePicker' do |a|
    a.source_files = 'UITextSubClass/UITextFieldWithDatePicker/*.{h,m}'
    a.dependency 'UITextSubClass/Core'
  end
  s.subspec 'UITextFieldWithPicker' do |a|
    a.source_files = 'UITextSubClass/UITextFieldWithPicker/*.{h,m}'
    a.dependency 'UITextSubClass/Core'
  end
  s.subspec 'UITextFieldWithToolbar' do |a|
    a.source_files = 'UITextSubClass/UITextFieldWithToolbar/*.{h,m}'
    a.dependency 'UITextSubClass/Core'
  end
  s.subspec 'UITextViewWithToolbar' do |a|
    a.source_files = 'UITextSubClass/UITextViewWithToolbar/*.{h,m}'
    a.dependency 'UITextSubClass/Core'
    a.framework    = 'QuartzCore'
  end
  s.resource_bundles = { 'UITextSubClassLocalize' => ['UITextSubClass/*.lproj'] }
  s.requires_arc = true
end
