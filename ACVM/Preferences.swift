//
//  Preferences.swift
//  ACVM
//
//  Created by Ben Mackin on 12/15/20.
//

import Foundation
import Cocoa

class Preferences {
    
    var vmLiveImageUpdateFreq: Double {
        get {
            let updateFreqVal = UserDefaults.standard.double(forKey: "vmLiveImageUpdateFreq")
            if updateFreqVal > 0 {
                return updateFreqVal
            }
            
            return 2
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "vmLiveImageUpdateFreq")
        }
    }
    
}
