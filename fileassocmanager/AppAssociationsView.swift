//
//  AppAssociationsView.swift
//  fileassocmanager
//
//  Created by Rubén Robles on 16/09/2022.
//

import SwiftUI

struct AppAssociationsView: View {
    @EnvironmentObject var apps: InstalledApps
    var appId: UUID?
    
    var selectedApp: Binding<InstalledApp>? {
        get {
            return $apps.list.first(where: {$0.wrappedValue.id == appId})
        }
    }
    
    var body: some View {
        if (selectedApp != nil) {
            List {
                Text(selectedApp!.wrappedValue.name)
                ForEach(selectedApp!.associations) { association in
                    HStack {
                        Toggle(isOn: association.enabled) {
                            Image(nsImage: association.wrappedValue.icon)
                            Text(association.wrappedValue.title)
                        }
                    }
                }
            }
        } else {
            Text("No results found!").font(.largeTitle)
        }
    }
}

struct AppAssociationsView_Previews: PreviewProvider {
    static var previews: some View {
        AppAssociationsView()
    }
}
