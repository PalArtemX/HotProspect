//
//  HotProspectApp.swift
//  HotProspect
//
//  Created by Artem Paliutin on 24/05/2022.
//

import SwiftUI

@main
struct HotProspectApp: App {
    @StateObject var prospectViewModel = ProspectViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(prospectViewModel)
        }
    }
}
