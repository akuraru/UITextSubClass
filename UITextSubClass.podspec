

Pod::Spec.new do |s|
  s.name         = "UITextSubClass"
  s.version      = "1.0.3"
  s.summary      = "UITextField/UITextView SubClass library."
  s.homepage     = "https://github.com/azu/UITextSubClass"
  s.screenshots  = "http://f.cl.ly/items/2O0W2X3e1j3z1a2h3Y0J/UITextWithDatepicker.png"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "azu" => "info@efcl.info" }
  s.platform     = :ios, '12.0'
  s.source       = {
    :git => "https://github.com/azu/UITextSubClass.git",
    :tag => s.version.to_s
  }
  s.requires_arc = true
  s.swift_version = '5.6'

  s.subspec 'Core' do |a|
    a.resource_bundles = { 'UITextSubClassLocalize' => ['UITextSubClass/*.lproj'] }
    a.source_files  = 'UITextSubClass/UITextSubClassHelper.swift'
  end
  s.subspec 'UITextFieldWithDatePicker' do |a|
    a.source_files = 'UITextSubClass/UITextFieldWithDatePicker/*.swift'
    a.dependency 'UITextSubClass/Core'
  end
  s.subspec 'UITextFieldWithPicker' do |a|
    a.source_files = 'UITextSubClass/UITextFieldWithPicker/*.swift'
    a.dependency 'UITextSubClass/Core'
  end
  s.subspec 'UITextFieldWithDecimalPad' do |a|
    a.source_files = 'UITextSubClass/UITextFieldWithDecimalPad/*.swift'
    a.dependency 'UITextSubClass/Core'
  end
  s.subspec 'UITextFieldWithNumberPad' do |a|
    a.source_files = 'UITextSubClass/UITextFieldWithNumberPad/*.swift'
    a.dependency 'UITextSubClass/Core'
  end
  s.subspec 'UITextViewWithPlaceholder' do |a|
    a.source_files = 'UITextSubClass/UITextViewWithPlaceholder/*.swift'
    a.dependency 'UITextSubClass/Core'
  end
end
