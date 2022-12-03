//
//  MapAppApp.swift
//  MapApp
//
//  Created by TrungTin on 12/2/22.
//

import SwiftUI

@main
struct MapAppApp: App {
    @StateObject    private var vm = LocationViewModel()
    var body: some Scene {
        WindowGroup {
            LocationView()
                .environmentObject(vm)
        }
    }
}
