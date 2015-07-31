source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!
platform :ios, '8.0'

def import_pods
    pod 'GoogleMaps'
    pod 'Cartography', '~> 0.5.0'
    pod 'PromiseKit', '~> 2.1'
    pod 'Alamofire', '~> 1.2.3'
    pod 'SwiftyJSON', '~> 2.2.0'
    pod 'SwiftLoader', '0.2.2'
    pod 'FontAwesome.swift'
end


target 'BikeBlackSpot-iOS', exclusive: true do
    import_pods
end

target 'BikeBlackSpot-iOSTests', exclusive: true do
    import_pods
    pod 'Quick', '~> 0.3.1'
    pod 'Nimble', '1.0.0'
end
