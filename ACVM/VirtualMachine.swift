//
//  VirtualMachine.swift
//  ACVM
//
//  Created by Ben Mackin on 12/9/20.
//

import Foundation
import Cocoa

struct VmConfiguration: Codable {
    var vmname:String = ""
    var cores:Int = 4
    var ram:Int = 4096
    var mainImage:String = ""
    var cdImage:String = ""
    var cdImage2:String = ""
    var unhideMousePointer:Bool = false
    var startFullScreen:Bool = false
    var graphicOptions:String = ""
    var nicOptions:String = ""
    var nvram:String = ""
    var mainImageUseVirtIO:Bool = false
    var mainImageUseWTCache:Bool = true
    var mountCDImage:Bool = false
    var mountCDImage2:Bool = false
    var sshPortForward:Bool = false
    var rdpPortForward:Bool = false
    var architecture:String = "aarch64"
    
    enum CodingKeys: String, CodingKey {
        case vmname = "vmname"
        case cores = "cores"
        case ram = "ram"
        case mainImage = "mainImage"
        case cdImage = "cdImage"
        case cdImage2 = "cdImage2"
        case unhideMousePointer = "unhideMousePointer"
        case startFullScreen = "startFullScreen"
        case graphicOptions = "graphicOptions"
        case nicOptions = "nicOptions"
        case nvram = "nvram"
        case mainImageUseVirtIO = "mainImageUseVirtIO"
        case mainImageUseWTCache = "mainImageUseWTCache"
        case mountCDImage = "mountCDImage"
        case mountCDImage2 = "mountCDImage2"
        case sshPortForward = "sshPortForward"
        case rdpPortForward = "rdpPortForward"
        case architecture = "architecture"
    }
    
    init() {
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        vmname = try values.decodeIfPresent(String.self, forKey: .vmname) ?? ""
        cores = try values.decodeIfPresent(Int.self, forKey: .cores) ?? 4
        ram = try values.decodeIfPresent(Int.self, forKey: .ram) ?? 4096
        mainImage = try values.decodeIfPresent(String.self, forKey: .mainImage) ?? ""
        cdImage = try values.decodeIfPresent(String.self, forKey: .cdImage) ?? ""
        cdImage2 = try values.decodeIfPresent(String.self, forKey: .cdImage2) ?? ""
        unhideMousePointer = try values.decodeIfPresent(Bool.self, forKey: .unhideMousePointer) ?? false
        startFullScreen = try values.decodeIfPresent(Bool.self, forKey: .startFullScreen) ?? false
        graphicOptions = try values.decodeIfPresent(String.self, forKey: .graphicOptions) ?? ""
        nicOptions = try values.decodeIfPresent(String.self, forKey: .nicOptions) ?? ""
        nvram = try values.decodeIfPresent(String.self, forKey: .nvram) ?? ""
        mainImageUseVirtIO = try values.decodeIfPresent(Bool.self, forKey: .mainImageUseVirtIO) ?? false
        mainImageUseWTCache = try values.decodeIfPresent(Bool.self, forKey: .mainImageUseWTCache) ?? true
        mountCDImage = try values.decodeIfPresent(Bool.self, forKey: .mountCDImage) ?? false
        mountCDImage2 = try values.decodeIfPresent(Bool.self, forKey: .mountCDImage2) ?? false
        sshPortForward = try values.decodeIfPresent(Bool.self, forKey: .sshPortForward) ?? false
        rdpPortForward = try values.decodeIfPresent(Bool.self, forKey: .rdpPortForward) ?? false
        architecture = try values.decodeIfPresent(String.self, forKey: .architecture) ?? "aarch64"
    }
}

class VirtualMachine {
        
    var config:VmConfiguration = VmConfiguration()
    
    var process:Process?
    var client:TCPClient?
    var state:Int = 0
    var liveImage:NSImage?
}
