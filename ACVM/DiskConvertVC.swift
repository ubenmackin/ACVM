//
//  DiskConvertVC.swift
//  ACVM
//
//  Created by Ben Mackin on 12/14/20.
//

import Cocoa

class DiskConvertVC: NSViewController {
    
    @IBOutlet weak var diskLocationTextField: NSTextField!
    @IBOutlet weak var createButton: NSButton!
    @IBOutlet weak var chooseButton: NSButton!
    
    @IBOutlet weak var progressBar: NSProgressIndicator!
    @IBOutlet weak var progressTextField: NSTextField!
    
    private let qemuimg = Process()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressBar.isHidden = true
        
        self.preferredContentSize = NSMakeSize(self.view.frame.size.width, self.view.frame.size.height);
    }
    
    @IBAction func didTapChooseButton(_ sender: Any) {
        
        let openPanel = NSOpenPanel()
        openPanel.allowedFileTypes = ["vhdx","raw", "bochs", "cloop", "cow", "dmg", "nbd", "parallels", "qcow", "qed", "vdi", "vmdk", "vvfat" ]
        openPanel.allowsOtherFileTypes = false
        openPanel.canCreateDirectories = false
        openPanel.canSelectHiddenExtension = false
        openPanel.isExtensionHidden = false
        openPanel.message = "Select disk image to convert to qcow2."
        
        openPanel.begin(completionHandler: { (result) in
                if result.rawValue == NSApplication.ModalResponse.OK.rawValue {
                    self.diskLocationTextField.stringValue = openPanel.url!.path
                    self.createButton.isEnabled = true
                }
            })
        
    }
    
    @IBAction func didTapCreateButton(_ sender: Any) {
        
        qemuimg.executableURL = Bundle.main.url(
            forResource: "qemu-img",
            withExtension: nil
        )
        
        let qi_arguments: [String] = [
            "convert",
            "-O", "qcow2",
            "-p",
            diskLocationTextField.stringValue,
            URL(fileURLWithPath: diskLocationTextField.stringValue).deletingPathExtension().path + ".qcow2"
        ]
        
        progressBar.isHidden = false
        progressBar.startAnimation(self)
        createButton.isEnabled = false
        chooseButton.isEnabled = false
        
        qemuimg.arguments = qi_arguments
        qemuimg.qualityOfService = .userInteractive

        let pipe = Pipe()
        qemuimg.standardOutput = pipe
        let outHandle = pipe.fileHandleForReading
        outHandle.waitForDataInBackgroundAndNotify()
        
        var progressObserver : NSObjectProtocol!
        progressObserver = NotificationCenter.default.addObserver(
            forName: NSNotification.Name.NSFileHandleDataAvailable,
            object: outHandle, queue: nil)
        {
            notification -> Void in
            let data = outHandle.availableData
                        
            if data.count > 0 {
                if let str = String(data: data, encoding: String.Encoding.utf8) {
                    var outputtext = str.trimEverything
                    outputtext.remove(at: outputtext.startIndex)
                    if let newValue = Double(outputtext.split(separator: "/").first!) {
                        self.progressBar.doubleValue = newValue
                        self.progressTextField.stringValue = String(newValue) + "%"
                    }
                }
                outHandle.waitForDataInBackgroundAndNotify()
            } else {
                // That means we've reached the end of the input.
                NotificationCenter.default.removeObserver(progressObserver!)
            }
        }
        
        var terminationObserver : NSObjectProtocol!
        terminationObserver = NotificationCenter.default.addObserver(
            forName: Process.didTerminateNotification,
            object: qemuimg, queue: nil)
        {
            notification -> Void in
            
            // Process was terminated. Close window
            self.progressBar.doubleValue = 100.0
            
            self.view.window?.close()
            let application = NSApplication.shared
            application.stopModal()
            
            NotificationCenter.default.removeObserver(terminationObserver!)
        }
        
        qemuimg.launch()
    }
    
    @IBAction func didTapCancelButton(_ sender: Any) {
        if qemuimg.isRunning {
            qemuimg.terminate()
        }
        
        self.view.window?.close()
        let application = NSApplication.shared
        application.stopModal()
    }
}

fileprivate extension String {
    var trimEverything: String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
