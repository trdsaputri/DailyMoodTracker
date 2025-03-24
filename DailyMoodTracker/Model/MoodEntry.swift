//
//  MoodEntry.swift
//  DailyMoodTracker
//
//  Created by Theresia Saputri on 22/03/25.
//

import Foundation

struct MoodEntry: Identifiable, Codable {
    let id = UUID()
    let mood: String
    let note: String
    let date: Date
    
    init(mood: String, note: String, date: Date = Date()) {
            self.mood = mood
            self.note = note
            self.date = date
    }

}
