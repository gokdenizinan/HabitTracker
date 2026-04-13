//
//  HabitsViewModel.swift
//  HabitTracker
//
//  View model for habit list and progress state.
//
import Combine
import Foundation

class HabitsViewModel: ObservableObject{
    @Published var habitsArray : [Habit] = []

    func createHabit(newHabitName: String, isComplete: Bool,newHabitPoint: String){
        guard var newHabitPointInt = Int(newHabitPoint) else{
            return
        }
        habitsArray.append(Habit(id: UUID(), name: newHabitName, isComplete: false, point: newHabitPointInt))
    }

    func deleteHabit(){
        
    }

    func updateHabit(){
        
    }

}

