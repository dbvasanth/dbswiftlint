//
//  RemoteConfigManager.swift
//  uGlow
//
//  Created by DB-MBP-008 on 22/06/22.
//

import Foundation
import Firebase
import GooglePlaces
import GoogleMaps

struct RCKey {
    static let googleAPIKey = "ios_GoogleAPIKey"
}

struct RemoteConfigManager {
    
    private static var remoteConfig: RemoteConfig = {
        var remoteConfig = RemoteConfig.remoteConfig()
        let defaults = [RCKey.googleAPIKey: Constants.googleServerkey as NSObject]
        remoteConfig.setDefaults(defaults)
        return remoteConfig
    }()
    
    static func configure(_ expireDuration: TimeInterval = 0.0){
        remoteConfig.fetch(withExpirationDuration: expireDuration) { (status, error) in
            if status == .success,error == nil{
                self.remoteConfig.activate { (success, error) in
                    guard error == nil else {
                        print("errror",error?.localizedDescription as Any)
                        GMSPlacesClient.provideAPIKey(Constants.googleServerkey)
                        GMSServices.provideAPIKey(Constants.googleServerkey)
                        return
                    }
                    debugPrint("Remote config fetch activate!")
                    let value = remoteConfig.configValue(forKey: RCKey.googleAPIKey).stringValue ?? ""
                    debugPrint("Value = \(value)")
                    if !value.isEmpty {
                        GMSPlacesClient.provideAPIKey(value)
                        GMSServices.provideAPIKey(value)
                        Constants.googleServerkey = value
                    }else{
                        GMSPlacesClient.provideAPIKey(Constants.googleServerkey)
                        GMSServices.provideAPIKey(Constants.googleServerkey)
                    }
                }
            }else {
                debugPrint("Remote config fetch error")
                GMSPlacesClient.provideAPIKey(Constants.googleServerkey)
                GMSServices.provideAPIKey(Constants.googleServerkey)
            }
        }
    }
}
