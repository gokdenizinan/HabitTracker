//
//  Habit.swift
//  HabitTracker
//
//  Data model for a single habit.
//

import Foundation
struct Habit: Identifiable
{
    let id: UUID
    var name: String
    var isComplete: Bool
    var point: Int
}
