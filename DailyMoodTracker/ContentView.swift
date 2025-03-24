//
//  ContentView.swift
//  DailyMoodTracker
//
//  Created by Theresia Saputri on 22/03/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            MainView().tabItem {
                Label("Mood Log", systemImage: "book.pages.fill")
            }
            MoodReportView().tabItem{
                Label("Report", systemImage: "chart.bar.horizontal.page.fill")
            }
        }
    }
}

#Preview {
    ContentView().environmentObject(MoodViewModel())
}
