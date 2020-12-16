//
//  PrefsWC.swift
//  ACVM
//
//  Created by Ben Mackin on 12/15/20.
//

import Foundation
import Cocoa

class PrefsWC: NSWindowController {
    
    override func windowDidLoad() {
        super.windowDidLoad()
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        
        if let tabviewController = self.window!.contentViewController as? NSTabViewController {
            tabviewController.selectedTabViewItemIndex = 1
            tabviewController.selectedTabViewItemIndex = 0
        }
    }
    
}
