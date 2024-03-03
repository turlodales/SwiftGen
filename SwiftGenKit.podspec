# frozen_string_literal: true

Pod::Spec.new do |s|
  s.name         = 'SwiftGenKit'
  s.version      = '6.6.3'
  s.summary      = 'The SwiftGen framework responsible for parsing assets and turn them ' \
                   'in a dictionary representation suitable for Stencil templates'

  s.description  = <<-DESC
                   This pod contains asset parsers for
                   [SwiftGen](https://github.com/SwiftGen/SwiftGen), as well as
                   methods for converting the data into contexts for
                   [Stencil](https://github.com/kylef/Stencil).
  DESC

  s.homepage     = 'https://github.com/SwiftGen/SwiftGenKit'
  s.license      = 'MIT'
  s.author       = {
    'Olivier Halligon' => 'olivier@halligon.net',
    'David Jennes' => 'david.jennes@gmail.com'
  }
  s.social_media_url = 'https://twitter.com/aligatr'

  s.platform = :osx, '10.9'
  s.swift_version = '5.0'
  s.cocoapods_version = '>= 1.4.0'

  s.source = {
    git: 'https://github.com/SwiftGen/SwiftGenKit.git',
    tag: s.version.to_s
  }
  s.source_files = 'Sources/SwiftGenKit/**/*.swift'

  s.dependency 'Kanna', '~> 5.2'
  s.dependency 'PathKit', '~> 1.0'
  s.dependency 'Yams', '~> 4.0'
  s.framework = 'Foundation'
end
