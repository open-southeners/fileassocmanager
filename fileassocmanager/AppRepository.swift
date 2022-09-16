//
//  AppRepository.swift
//  fileassocmanager
//
//  Created by Rubén Robles on 16/09/2022.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers

@_silgen_name("_LSCopySchemesAndHandlerURLs") func LSCopySchemesAndHandlerURLs(_: UnsafeMutablePointer<NSArray?>, _: UnsafeMutablePointer<NSMutableArray?>) -> OSStatus
@_silgen_name("_LSCopyAllApplicationURLs") func LSCopyAllApplicationURLs(_: UnsafeMutablePointer<NSMutableArray?>) -> OSStatus;
@_silgen_name("_UTCopyDeclaredTypeIdentifiers") func UTCopyDeclaredTypeIdentifiers() -> NSArray

class InstalledApps: ObservableObject {
    @Published var list: Array<InstalledApp> = []
    @Published var old: Array<InstalledApp> = []
    
    init() {
        AppRepository.fetch(source: self)
    }
}

class AppRepository {
    static func fetch(source: InstalledApps) {
        var schemesArray: NSArray?
        var appsArray: NSMutableArray?
        
        if (LSCopySchemesAndHandlerURLs(&schemesArray, &appsArray) == 0) {
            
            appsArray?.forEach { app in
                var appName: Unmanaged<CFString>?
                var appUrl: NSURL = app as! NSURL
                LSCopyDisplayNameForURL((app as! CFURL), &appName)
                
                var appNameString: String? = appName?.takeUnretainedValue() as? String
                var appFancyName: String = appNameString?.replacingOccurrences(of: ".app", with: "") ?? ""
                
                let appUrlPath: String? = appUrl.path
                var appIcon: NSImage?
                
                if (appUrlPath != nil) {
                    appIcon = NSWorkspace.shared.icon(forFile: appUrl.path!)
                }
                
                var appAssociations: Array<AppAssociation> = []
                schemesArray?.forEach { scheme in
                    appAssociations.append(AppAssociation(title: scheme as! String, icon: NSWorkspace.shared.icon(forFileType: scheme as! String), enabled: false))
                }
                
                source.list.append(InstalledApp(name: appNameString!, appIcon: appIcon, appName: appFancyName, bundlePath: appUrl, associations: appAssociations))
            }
        }
    }
}
