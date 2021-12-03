//
//  CopperApp.swift
//  Copper
//
//  Created by user.admin on 30/11/2021.
//

import SwiftUI

@main
struct CopperApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TransactionsView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
