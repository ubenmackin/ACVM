//
//  InterfacePrefsVC.swift
//  ACVM
//
//  Created by Ben Mackin on 12/15/20.
//

import Cocoa

class InterfacePrefsVC: NSViewController {
    
    @IBOutlet weak var liveUpdateSlider: NSSlider!
    @IBOutlet weak var liveUpdateValueTextField: NSTextField!
    
    var prefs = Preferences()
     
     @IBAction func cpuUpdateFreqAction(_ sender: NSSlider) {
        prefs.vmLiveImageUpdateFreq = liveUpdateSlider.doubleValue
        liveUpdateValueTextField.stringValue = String(liveUpdateSlider.doubleValue)
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showExistingPrefs()
    }
    
    func showExistingPrefs() {
        liveUpdateValueTextField.stringValue = String(prefs.vmLiveImageUpdateFreq)
        liveUpdateSlider.doubleValue = prefs.vmLiveImageUpdateFreq
    }
    
}
