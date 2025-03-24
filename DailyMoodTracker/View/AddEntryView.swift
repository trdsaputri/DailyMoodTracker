//
//  AddEntryView.swift
//  DailyMoodTracker
//
//  Created by Theresia Saputri on 22/03/25.
//

import SwiftUI

struct AddEntryView: View {
    @EnvironmentObject var viewModel: MoodViewModel
    @Binding var isAddEntry: Bool
    
    var body: some View {
        VStack(){
            Text("Daily Mood Entry")
                .font(.largeTitle)
                .bold()

            Text("Select your mood:")
                .font(.headline)

            HStack {
                ForEach(viewModel.moods, id: \.self) { moodOption in
                    Button(action: {
                        viewModel.mood = moodOption
                    }) {
                        Text(moodOption)
                            .padding(10)
                            .background(viewModel.mood == moodOption ? Color.blue.opacity(0.7) : Color.gray.opacity(0.2))
                            .cornerRadius(8)
                    }
                }
            }

            TextEditor(text: $viewModel.note)
                .frame(height: 100)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                .padding(.bottom)

            Button("Submit") {
                viewModel.submitMood()
                isAddEntry = false
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(viewModel.isFormValid() ? Color.blue : Color.gray)
            .foregroundColor(.white)
            .cornerRadius(10)
            .disabled(!viewModel.isFormValid())
            
            Button("Cancel") {
                isAddEntry = false
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.red)
            .foregroundColor(.white)
            .cornerRadius(10)

            Divider().padding(.vertical)
            
            Spacer()
        }.padding()
    }
}

#Preview {
    NavigationStack{
        AddEntryView(isAddEntry: .constant(true)).environmentObject(MoodViewModel())
    }
}
    
