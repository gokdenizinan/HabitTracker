//
//  HabitsViewModel.swift
//  HabitTracker
//
//  View model for habit list and progress state.
//
import Combine
import Foundation

class HabitsViewModel: ObservableObject{
    // @Published var habitsArray : [Habit] = []
    @Published var habitsArray: [Habit] = [
        Habit(id: UUID(), name: "Read a Book", isComplete: false, point: 10),
        Habit(id: UUID(), name: "Exercise", isComplete: true, point: 10),
        Habit(id: UUID(), name: "Practice Coding", isComplete: true, point: 10)
    ]

    func createHabit(newHabitName: String, isComplete: Bool,newHabitPoint: Int){

        habitsArray.append(Habit(id: UUID(), name: newHabitName, isComplete: false, point: newHabitPoint))
    }

    func deleteHabit(habit: Habit){
        habitsArray.removeAll {$0.id == habit.id}
    }
    func updateHabit(habit: Habit, difHabitName: String, difHabitPoint: String){
        
        if let index = habitsArray.firstIndex(where: {$0.id == habit.id}){
            
            if difHabitName != ""
            {
                habitsArray[index].name = difHabitName
            }
            if let points = Int(difHabitPoint){
                habitsArray[index].point = points
            }
        }
    }
}
