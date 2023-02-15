//
//  MyTabView.swift
//  TAP IN
//
//  Created by Preshous Austin on 2/10/23.
//

import SwiftUI

struct MyTabView: View {
    var body: some View {
        TabView{
            ContentView()
                .tabItem{
                    Label("Map", systemImage: "map")
                }
            CreateEventView()
                .tabItem{
                    Label("Pin", systemImage: "mappin")
                    CreateEventView()
                        .tabItem{
                            Label("Home", systemImage: "house.circle")
                        }
                }
        }
    }
}
