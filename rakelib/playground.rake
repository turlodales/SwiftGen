# frozen_string_literal: true

# Used constants:
# _none_

## [ Playground Resources ] ###################################################

namespace :playground do
  task :clean do
    sh 'rm -rf SwiftGen.playground/Resources'
    sh 'mkdir SwiftGen.playground/Resources'
  end

  task :coredata do
    sdk = Utils.run('--sdk iphonesimulator --show-sdk-path', task, xcrun: true, formatter: :to_string).strip
    source = File.expand_path('Sources/TestUtils/Fixtures/Resources/CoreData/Model.xcdatamodeld', Dir.pwd)
    destination = File.expand_path('SwiftGen.playground/Resources', Dir.pwd)
    Utils.run(
      %(momc --sdkroot "#{sdk}" --iphonesimulator-deployment-target 13.0 ) +
        %("#{source}" "#{destination}"),
      task,
      xcrun: true
    )
  end
  task :files do
    sh %(cp -R Sources/TestUtils/Fixtures/Resources/Files/* SwiftGen.playground/Resources/)
  end
  task :fonts do
    sh %(cp Sources/TestUtils/Fixtures/Resources/Fonts/Avenir.ttc SwiftGen.playground/Resources/)
    sh %(cp Sources/TestUtils/Fixtures/Resources/Fonts/ZapfDingbats.ttf SwiftGen.playground/Resources/)
  end
  task :ib do
    Utils.run(
      %(ibtool --compile SwiftGen.playground/Resources/Wizard.storyboardc --flatten=NO ) +
        %(Sources/TestUtils/Fixtures/Resources/IB-iOS/Wizard.storyboard),
      task,
      xcrun: true
    )
  end
  task :json do
    sh %(cp Sources/TestUtils/Fixtures/Resources/JSON/array.json SwiftGen.playground/Resources/)
    sh %(cp Sources/TestUtils/Fixtures/Resources/JSON/configuration.json SwiftGen.playground/Resources/)
  end
  task :plist do
    sh %(cp Sources/TestUtils/Fixtures/Resources/Plist/good/Info.plist SwiftGen.playground/Resources/TestInfo.plist)
    sh %(cp Sources/TestUtils/Fixtures/Resources/Plist/good/shopping-list.plist SwiftGen.playground/Resources/)
    sh %(cp Sources/TestUtils/Fixtures/Resources/Plist/good/configuration.plist SwiftGen.playground/Resources/)
  end
  task :strings do
    Utils.run(
      %(plutil -convert binary1 -o SwiftGen.playground/Resources/Localizable.strings ) +
        %(Sources/TestUtils/Fixtures/Resources/Strings/Localizable.strings),
      task,
      xcrun: true
    )
  end
  task :xcassets do
    Utils.run(
      %(actool --compile SwiftGen.playground/Resources --platform iphoneos --minimum-deployment-target 11.0 ) +
        %(--output-format=human-readable-text Sources/TestUtils/Fixtures/Resources/XCAssets/*.xcassets),
      task,
      xcrun: true
    )
  end

  desc "Regenerate all the Playground resources based on the test fixtures.\n" \
    'This compiles the needed fixtures and place them in SwiftGen.playground/Resources'
  task :resources => %w[clean coredata files fonts ib json plist strings xcassets]
end
