//
//  Untitled.swift
//  DailyMoodTracker
//
//  Created by Theresia Saputri on 24/03/25.
//

import SwiftUI

struct MoodEntryCardView: View{
    let entry: MoodEntry
    
    var moodColor: Color{
        if entry.mood.contains("Happy"){
            return .green
        } else if entry.mood.contains("Neutral"){
            return.yellow
        } else{
            return .red
        }
    }
    
    var body: some View{
        VStack(alignment: .leading, spacing: 10) {
            HStack{
                Text("\(entry.mood)")
                    .font(.title2)
                    .multilineTextAlignment(.leading)
                    .bold()
                Spacer()
            }

            if !entry.note.isEmpty {
                Text("Note: \(entry.note)")
                    .italic()
                    .multilineTextAlignment(.leading)
            }

            Text("Logged on \(entry.date.formatted(date: .abbreviated, time: .shortened))")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(width: 350, height: 100)
        .padding()
        .background(moodColor.opacity(0.2))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(moodColor, lineWidth: 2))
    }
}

#Preview{
    MoodEntryCardView(entry: MoodEntry(mood: "😊 Happy", note: "Had a great day at school!"))
}
