//
//  MainView.swift
//  DailyMoodTracker
//
//  Created by Theresia Saputri on 22/03/25.
//

import SwiftUI

struct MainView: View {
    @State var isAddMood = false
    @EnvironmentObject var moodViewModel: MoodViewModel
    
    @State var isEntryExist: Bool = true
    
    let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter
        }()
    
    var body: some View {
        
        NavigationStack{
            VStack{
                
                ScrollView{
                    if moodViewModel.moodEntries.isEmpty {
                        Text("No entries yet.")
                            .foregroundColor(.gray)
                    } else {
                        ScrollView {
                            VStack(spacing: 12) {
                                ForEach(moodViewModel.groupedMoodEntriesByDay.keys.sorted(by: >), id: \.self) { date in Section(header: Text(dateFormatter.string(from: date))) {
                                            ForEach(moodViewModel.groupedMoodEntriesByDay[date] ?? []) { entry in
                                                    MoodEntryCardView(entry: entry)
                                                }
                                            }
                                }
                            }
                        }
                    }
                }.padding()
                
                Button("LOG MY MOOD") {
                    isAddMood = true
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                
                Spacer()
            }.padding()
            .navigationDestination(isPresented: $isAddMood,
                                    destination: {AddEntryView( isAddEntry: $isAddMood)})
            .navigationTitle("Daily Mood Tracker")
        }
    }
}



#Preview {
    MainView().environmentObject(MoodViewModel())
}
