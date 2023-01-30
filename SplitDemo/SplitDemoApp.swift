//
//  SplitDemoApp.swift
//  SplitDemo
//
//  Created by 이민교 on 2023/01/30.
//

import SwiftUI

@main
struct SplitDemoApp: App {
    @State private var moims = Moim.sampleData
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MoimsView(moims: $moims)
            }
        }
    }
}
