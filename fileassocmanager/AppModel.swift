//
//  AppModel.swift
//  fileassocmanager
//
//  Created by Rubén Robles on 23/06/2022.
//

import Foundation
import SwiftUI

struct InstalledApp: Identifiable {
    private(set) var id: UUID = UUID()
    
    var bundle: Bundle?
    var name: String
    var appIcon: NSImage?
    var appName: String
    var bundlePath: CFURL
    var associations: Array<AppAssociation>
}

struct AppAssociation: Identifiable {
    private(set) var id: UUID = UUID()
    
    var title: String
    var icon: NSImage
    
    var enabled: Bool
}
