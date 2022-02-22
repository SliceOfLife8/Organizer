# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

def sdImage
  pod 'SDWebImage',                     '5.12.3'
  pod 'SDWebImageLottiePlugin',         '0.3.0'
end

def rxSwift
  pod 'RxSwift',                        '6.2.0'
  pod 'RxCocoa',                        '6.2.0'
end

target 'Organizer' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Organizer
  pod 'lottie-ios',                     '2.5.0'
  sdImage
  rxSwift

  target 'OrganizerTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'OrganizerUITests' do
    # Pods for testing
  end

end
