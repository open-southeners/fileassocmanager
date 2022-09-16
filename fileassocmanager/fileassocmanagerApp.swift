//
//  fileassocmanagerApp.swift
//  fileassocmanager
//
//  Created by Rubén Robles on 23/06/2022.
//

import SwiftUI

@main
struct fileassocmanagerApp: App {
    @StateObject var apps = InstalledApps()

    var body: some Scene {
        WindowGroup {
            ContentView().navigationTitle("File Associations Manager").environmentObject(apps)
        }
    }
}
