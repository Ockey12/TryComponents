//
//  TryComponentsApp.swift
//  TryComponents
//
//  Created by オナガ・ハルキ on 2022/08/05.
//

import SwiftUI

@main
struct TryComponentsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
