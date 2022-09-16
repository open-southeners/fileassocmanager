//
//  NavigationSidebar.swift
//  fileassocmanager
//
//  Created by Rubén Robles on 16/09/2022.
//

import SwiftUI

struct NavigationSidebar: View {
    @EnvironmentObject var apps: InstalledApps
    @State private var animationAmount = 1.0
    @State private var searchText = ""
    
    var body: some View {
        if #available(macOS 12.0, *) {
            List(apps.list) { app in
                NavigationLink(destination: AppAssociationsView(appId: app.id)) {
                    HStack(alignment: .center) {
                        Image(nsImage: app.appIcon!)
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text(app.appName)
                    }
                }
            }.listStyle(.automatic)
            .navigationTitle("Applications")
            .searchable(text: $searchText, placement: .sidebar) {
                ForEach (apps.list.filter({ $0.appName.contains(searchText) })) { suggestedApp in
                    Label {
                        Text(suggestedApp.appName)
                    } icon: {
                        Image(nsImage: suggestedApp.appIcon!).resizable().frame(width: 24, height: 24)
                    }.labelStyle(.titleAndIcon).searchCompletion(suggestedApp.appName)
                }
            }
            .onSubmit(of: .search) {
                if (searchText == "") {
                    apps.list = apps.old
                    
                    apps.old = []
                    
                    return
                }
                
                if (apps.old.isEmpty) {
                    apps.old = apps.list
                }
                
                apps.list = apps.list.filter({ $0.appName.contains(searchText) })
            }
        } else {
            List(apps.list) { app in
                NavigationLink(destination: AppAssociationsView(appId: app.id)) {
                    HStack(alignment: .center) {
                        Image(nsImage: app.appIcon!)
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text(app.appName)
                    }
                }
            }.listStyle(.automatic)
            .navigationTitle("Applications")
        }
    }
}

struct NavigationSidebar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationSidebar()
    }
}
