//
//  AppUserdefault.swift
//  uGlow
//
//  Created by Doodleblue on 06/08/21.
//

import Foundation

struct AppUserdefault  {
    
    private static var shared = UserDefaults.standard
    private init() {}
    
    static var emailId:String? {
           get {
               return shared.value(forKey: "emailID") as? String
           }
           set {
               shared.set((newValue ?? ""), forKey: "emailID")
               shared.synchronize()
           }
       }
   
    static var roleID:Int? {
        get {
            return shared.value(forKey: "roleID") as? Int
        }
        set {
            shared.set((newValue ?? ""), forKey: "roleID")
            shared.synchronize()
        }
    }
    
    static var pass:String? {
        get {
            return shared.value(forKey: "password") as? String
        }
        set {
            shared.set((newValue ?? ""), forKey: "password")
            shared.synchronize()
        }
    }
    
    static var userID:Int? {
        get {
            return shared.value(forKey: "userID") as? Int
        }
        set {
            shared.set((newValue ?? ""), forKey: "userID")
            shared.synchronize()
        }
    }
    
    static var phoneNumberVerified:Bool? {
        get {
            return shared.value(forKey: "phoneNumberVerified") as? Bool
        }
        set {
            shared.set((newValue ?? ""), forKey: "phoneNumberVerified")
            shared.synchronize()
        }
    }
    
    static var latitude:Double? {
        get {
            return shared.value(forKey: "latitude") as? Double
        }
        set {
            shared.set((newValue ?? ""), forKey: "latitude")
            shared.synchronize()
        }
    }
    
    static var longitude:Double? {
        get {
            return shared.value(forKey: "longitude") as? Double
        }
        set {
            shared.set((newValue ?? ""), forKey: "longitude")
            shared.synchronize()
        }
    }
    
    static var address:String? {
       get {
           return shared.value(forKey: "address") as? String
       }
       set {
           shared.set((newValue ?? ""), forKey: "address")
           shared.synchronize()
       }
   }
    
    static var state:String? {
       get {
           return shared.value(forKey: "state") as? String
       }
       set {
           shared.set((newValue ?? ""), forKey: "state")
           shared.synchronize()
       }
   }
    
    static var city:String? {
       get {
           return shared.value(forKey: "city") as? String
       }
       set {
           shared.set((newValue ?? ""), forKey: "city")
           shared.synchronize()
       }
   }
    
    static var pincode:String? {
       get {
           return shared.value(forKey: "pincode") as? String
       }
       set {
           shared.set((newValue ?? ""), forKey: "pincode")
           shared.synchronize()
       }
   }
    
    static var profileImage:String? {
       get {
           return shared.value(forKey: "profileImage") as? String
       }
       set {
           shared.set((newValue ?? ""), forKey: "profileImage")
           shared.synchronize()
       }
   }
    
    static var firstName:String? {
       get {
           return shared.value(forKey: "firstName") as? String
       }
       set {
           shared.set((newValue ?? ""), forKey: "firstName")
           shared.synchronize()
       }
   }
    
    static var lastName:String? {
       get {
           return shared.value(forKey: "lastName") as? String
       }
       set {
           shared.set((newValue ?? ""), forKey: "lastName")
           shared.synchronize()
       }
   }
    
    static var countryCode:String? {
        get {
            return shared.value(forKey: "countryCode") as? String
        }
        set {
            shared.set((newValue ?? ""), forKey: "countryCode")
            shared.synchronize()
        }
    }
    
    static var mobileNumber:String? {
        get {
            return shared.value(forKey: "mobileNumber") as? String
        }
        set {
            shared.set((newValue ?? ""), forKey: "mobileNumber")
            shared.synchronize()
        }
    }
    
    static var isFirstLogin:Bool? {
        get {
            return shared.value(forKey: "isFirstLogin") as? Bool
        }
        set {
            shared.set((newValue ?? ""), forKey: "isFirstLogin")
            shared.synchronize()
        }
    }
    
    static var isSocial:Bool? {
        get {
            return shared.value(forKey: "isSocial") as? Bool
        }
        set {
            shared.set((newValue ?? ""), forKey: "isSocial")
            shared.synchronize()
        }
    }
    
    static var AESsecretKey:String? {
        get {
            return shared.value(forKey: "AESsecretKey") as? String
        }
        set {
            shared.set((newValue ?? ""), forKey: "AESsecretKey")
            shared.synchronize()
        }
    }
    
    static var password:String? {
        get {
            return shared.value(forKey: "password") as? String
        }
        set {
            shared.set((newValue ?? ""), forKey: "password")
            shared.synchronize()
        }
    }
    
    static var accessToken:String? {
        get {
            return shared.value(forKey: "accessToken") as? String
        }
        set {
            shared.set((newValue ?? ""), forKey: "accessToken")
            shared.synchronize()
        }
    }
    static var fcmToken:String? {
        get {
            return shared.value(forKey: "fcmToken") as? String
        }
        set {
            shared.set((newValue ?? ""), forKey: "fcmToken")
            shared.synchronize()
        }
    }
    static var refreshToken:String? {
        get {
            return shared.value(forKey: "refreshToken") as? String
        }
        set {
            shared.set((newValue ?? ""), forKey: "refreshToken")
            shared.synchronize()
        }
    }
}
