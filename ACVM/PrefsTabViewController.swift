//
//  PrefsTabViewController.swift
//  ACVM
//
//  Created by Ben Mackin on 12/15/20.
//

import Foundation
import AppKit

class PreferencesTabViewController: NSTabViewController {
    
    private lazy var tabViewSizes: [String: NSSize] = [:]
    
    override func tabView(_ tabView: NSTabView, didSelect tabViewItem: NSTabViewItem?) {
        super.tabView(tabView, didSelect: tabViewItem)
        
        if let tabViewItem = tabViewItem {
            view.window?.title = tabViewItem.label
            resizeWindowToFit(tabViewItem: tabViewItem)
        }
    }
    
    override func tabView(_ tabView: NSTabView, willSelect tabViewItem: NSTabViewItem?) {
        super.tabView(tabView, willSelect: tabViewItem)
        
        // Cache the size of the tab view.
        if let tabViewItem = tabViewItem, let size = tabViewItem.view?.frame.size {
            tabViewSizes[tabViewItem.label] = size
        }
    }
    
    /// Resizes the window so that it fits the content of the tab.
    private func resizeWindowToFit(tabViewItem: NSTabViewItem) {
        guard var size = tabViewSizes[tabViewItem.label], let window = view.window else {
            return
        }
        
        if tabViewItem.label == "Interface" {
            size = NSSize.init(width: 500, height: 108)
        } else if tabViewItem.label == "Update" {
            size = NSSize.init(width: 500, height: 95)
        } else {
            size = NSSize.init(width: 500, height: 140)
        }
        
        let contentRect = NSRect(x: 0, y: 0, width: size.width, height: size.height)
        
        let contentFrame = window.frameRect(forContentRect: contentRect)
        let toolbarHeight = window.frame.size.height - contentFrame.size.height
        let newOrigin = NSPoint(x: window.frame.origin.x, y: window.frame.origin.y + toolbarHeight)
        let newFrame = NSRect(origin: newOrigin, size: contentFrame.size)
        
        window.setFrame(newFrame, display: false, animate: false)
    }
    
}

