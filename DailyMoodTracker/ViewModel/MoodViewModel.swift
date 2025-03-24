//
//  MoodViewModel.swift
//  DailyMoodTracker
//
//  Created by Theresia Saputri on 22/03/25.
//

import Foundation

class MoodViewModel: ObservableObject {
    @Published var mood: String = ""
    @Published var note: String = ""

    @Published var moodEntries: [MoodEntry] = []

    let moods = ["😊 Happy", "😐 Neutral", "😢 Sad"]
    
    init() {
        loadSampleData()
    }

    func submitMood() {
        guard !mood.isEmpty else { return }

        let entry = MoodEntry(mood: mood, note: note)
        moodEntries.insert(entry, at: 0) // newest first

        mood = ""
        note = ""
    }

    func isFormValid() -> Bool {
        return !mood.isEmpty
    }
    
    /*
    enum ViewMode {
        case daily, monthly
    }*/
    
    
    var groupedMoodEntriesByDay: [Date: [MoodEntry]] {
        let calendar = Calendar.current

        var grouped = Dictionary(grouping: moodEntries) { entry in
            calendar.startOfDay(for: entry.date)
        }

        for key in grouped.keys {
            grouped[key]?.sort(by: { $0.date > $1.date })
        }

        return grouped
    }


    var groupedMoodEntriesByMonth: [Date: [MoodEntry]] {
        let calendar = Calendar.current

        let grouped = Dictionary(grouping: moodEntries) { entry in
            let components = calendar.dateComponents([.year, .month], from: entry.date)
            return calendar.date(from: components) ?? entry.date
        }
        
        var sortedGrouped: [Date: [MoodEntry]] = [:]
        for (month, entries) in grouped {
            sortedGrouped[month] = entries.sorted(by: { $0.date > $1.date })
        }

        return sortedGrouped
    }

    
    func loadSampleData() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"

        let samples: [MoodEntry] = [
                        MoodEntry(mood: "😊 Happy", note: "Great walk outside!", date: formatter.date(from: "2025-03-21 08:00")!),
                        MoodEntry(mood: "😐 Neutral", note: "Just an okay day.", date: formatter.date(from: "2025-03-20 12:00")!),
                        MoodEntry(mood: "😊 Happy", note: "Finished a big task!", date: formatter.date(from: "2025-02-28 17:00")!),
                        MoodEntry(mood: "😐 Neutral", note: "Bit tired.", date: formatter.date(from: "2025-02-15 20:00")!),
                        MoodEntry(mood: "😢 Sad", note: "Rough morning.", date: formatter.date(from: "2025-01-15 10:00")!)
                ]

                moodEntries = samples

        }
    
}
