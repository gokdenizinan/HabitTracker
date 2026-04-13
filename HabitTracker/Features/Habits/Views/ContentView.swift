//
//  ContentView.swift
//  HabitTracker
//
//  Created by Gökdeniz İnan on 6.04.2026.
//

import SwiftUI

struct ContentView: View {
    
    // Storage
    @State var  newHabitName: String = ""
    @State var newHabitPoint: String = ""
    @StateObject var viewModel = HabitsViewModel()
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 20){
                Text("My Habits").font(Font.custom("Geist-Regular", size: 50)).padding(.top,100)
                List{
                    ForEach($viewModel.habitsArray) { $habit in
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
                                viewModel.deleteHabit(habit: habit)
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
                                    viewModel.createHabit(newHabitName: newHabitName, isComplete: false, newHabitPoint: points)
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

