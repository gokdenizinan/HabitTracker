//
//  ContentView.swift
//  HabitTracker
//
//  Created by Gökdeniz İnan on 6.04.2026.
//

import SwiftUI

struct ContentView: View {
    
    // Storage
    @State var habitsArray: [Habit] = [
        Habit(id: UUID(), name: "Read a Book", isComplete: false, point: 10),
        Habit(id: UUID(), name: "Exercise", isComplete: true, point: 10),
        Habit(id: UUID(), name: "Practice Coding", isComplete: true, point: 10)
    ]
    @State var  newHabitName: String = ""
    @State var newHabitPoint: String = ""
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 20){
                Text("My Habits").font(Font.custom("Geist-Regular", size: 50)).padding(.top,100)
                List{
                    ForEach($habitsArray) { $habit in
                        HStack (alignment: .center, spacing: 20){
                            Text(habit.name)
                                .padding(.leading)
                            Text(String(habit.point))
                            Spacer()
                            Image(systemName: habit.isComplete ? "checkmark.square.fill":"square")
                                .font(.system(size:30))
                                .foregroundStyle(habit.isComplete ? .green: .gray)
                        }
                        .swipeActions(edge: .leading){
                            Button(role: .destructive) {
                                habitsArray.removeAll {$0.id == habit.id}
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .swipeActions(edge: .trailing){
                            Button {
                                habit.isComplete.toggle()
                            } label: {
                                Label("Toggle", systemImage: "checkmark")
                            }
                        }
                    }
                    TextField("Enter new habit: ", text: $newHabitName)
                        .padding(.top)
                        .padding(.leading)
                    if newHabitName != ""
                    {
                        TextField("Enter Points: ", text: $newHabitPoint).keyboardType(.numberPad)
                            .padding(.top)
                            .padding(.leading)
                        if newHabitPoint != ""
                        {
                            Button
                            {
                                if let points = Int(newHabitPoint)
                                {
                                    habitsArray.append(Habit(id: UUID(), name: newHabitName, isComplete: false, point: points))
                                }
                                newHabitName = ""
                                newHabitPoint = ""
                            } label: {
                                Label("Add New Habit", systemImage: "star.fill")
                            }
                        }
                    }
                    
                    
                }.scrollContentBackground(.hidden)
                
            }
                    }
    }
}
#Preview() {
    ContentView()
}

