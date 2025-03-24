//
//  MoodReportView.swift
//  DailyMoodTracker
//
//  Created by Theresia Saputri on 24/03/25.
//

import SwiftUI
import Charts

struct MoodReportView: View {
    @EnvironmentObject var viewModel: MoodViewModel

    let monthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
    
    var sortedMonths: [Date] {
        viewModel.groupedMoodEntriesByMonth.keys.sorted(by: >)
    }


    var body: some View {
        NavigationView {
            
            ScrollView{
                ForEach(sortedMonths, id: \.self) { month in
                    if let entries = viewModel.groupedMoodEntriesByMonth[month] {
                        Section(header: Text(monthFormatter.string(from: month))) {
                            ForEach(entries) { entry in
                                MoodEntryCardView(entry: entry)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Monthly Mood Log")
        }
    }
}



#Preview {
    MoodReportView().environmentObject(MoodViewModel())
}
