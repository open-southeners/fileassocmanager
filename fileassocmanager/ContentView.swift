//
//  ContentView.swift
//  fileassocmanager
//
//  Created by Rubén Robles on 23/06/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var apps: InstalledApps
    @State private var animationAmount = 1.0
    
    var body: some View {
        NavigationView {
            NavigationSidebar().environmentObject(apps)
            AppAssociationsView().environmentObject(apps)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
