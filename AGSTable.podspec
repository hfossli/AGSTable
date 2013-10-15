Pod::Spec.new do |s|
    s.name         = "AGSTable"
    s.version      = "1.0.SNAPSHOT"
    s.summary      = "A simple NSHashTable-replacement for small amounts of data for iOS 5 and above."
    s.homepage     = "https://github.com/hfossli/AGSTable"
    s.authors      = { "Håvard Fossli" => "hfossli@agens.no" }
    s.license      = 'MIT'
    s.source       = { 
        :git => "https://github.com/hfossli/AGSTable.git"
        }
    s.source_files  = 'Source/**/*.{h,m}'
    s.frameworks    = 'Foundation'
    s.platform      = :ios
    s.requires_arc  = true
end
