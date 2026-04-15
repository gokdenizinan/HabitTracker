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
    @State var editingHabitID: UUID? = nil
    @State var editedHabitName: String = ""
    @State var editedHabitPoint: String = ""
    
    @StateObject var viewModel = HabitsViewModel()
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 20){
                Text("My Habits").font(Font.custom("Geist-Regular", size: 50)).padding(.top,100)
                List{
                    ForEach($viewModel.habitsArray) { $habit in
                        
                        if editingHabitID == habit.id{
                            TextField("Edit name", text: $editedHabitName)
                            TextField("Edit point", text: $editedHabitPoint)
                            
                            Button("Save"){
                                viewModel.updateHabit(habit: habit, difHabitName: editedHabitName, difHabitPoint: editedHabitPoint)
                                editingHabitID = nil
                            }
                            Button("Cancel"){
                                editingHabitID = nil
                            }
                            
                        }
                        else{
                            HStack (alignment: .center, spacing: 20){
                                Text(habit.name)
                                    .padding(.leading)
                                Text(String(habit.point))
                                Spacer()
                                Image(systemName: habit.isComplete ? "checkmark.square.fill":"square")
                                    .font(.system(size:30))
                                    .foregroundStyle(habit.isComplete ? .green: .gray)
                                    .swipeActions(edge: .leading){
                                        Button(role: .destructive) {
                                            viewModel.deleteHabit(habit: habit)
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                        Button{
                                            editingHabitID = habit.id
                                            editedHabitName = habit.name
                                            editedHabitPoint = String(habit.point)
                                        } label: {
                                            Label("Change" ,systemImage: "square.and.pencil")
                                        }.tint(.yellow)
                                    }
                                    .swipeActions(edge: .trailing){
                                        Button {
                                            habit.isComplete.toggle()
                                        } label: {
                                            if habit.isComplete == true
                                             {
                                                 Label("Undone", systemImage: "bolt.slash")
                                             }
                                             else {
                                                 Label("Done" , systemImage: "bolt.fill")
                                             }
                                        }
                                    }
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
