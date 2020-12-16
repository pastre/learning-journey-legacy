//
//  Learning_JourneyApp.swift
//  Learning Journey
//
//  Created by Bruno Pastre on 04/12/20.
//

import SwiftUI

@main
struct Learning_JourneyApp: App {
    private let environment = AppEnvironment.bootstrap()

    var body: some Scene {
        WindowGroup {
            ContentView(container: environment.container)
        }
    }
}
