//
//  PersistenceLayer.swift
//  Habitual
//
//  Created by Claudia Munoz on 3/27/23.
//

import Foundation

struct PersistenceLayer {
    private(set) var habits: [Habit] = []
    private static let userDefaultsHabitsKeyValue = "HABITS_ARRAY"

    init() {
        self.loadHabits()
    }
    private mutating func loadHabits() {

       let userDefaults = UserDefaults.standard

       guard let habitData = userDefaults.data(forKey: PersistenceLayer.userDefaultsHabitsKeyValue),
           let habits = try? JSONDecoder().decode([Habit].self, from: habitData) else {
           return
       }

       self.habits = habits
    }
    @discardableResult
    
    mutating func createNewHabit(name: String, image: Habit.Images) -> Habit {
       let newHabit = Habit(title: name, image: image)
       self.habits.insert(newHabit, at: 0) // Prepend the habits to the array
       self.saveHabits()

       return newHabit
        
    }
    
    private func saveHabits() {
       // Step 9
       guard let habitsData = try? JSONEncoder().encode(self.habits) else {
           fatalError("could not encode list of habits")
       }

       // Step 10
       let userDefaults = UserDefaults.standard
       userDefaults.set(habitsData, forKey: PersistenceLayer.userDefaultsHabitsKeyValue)
       userDefaults.synchronize()
    }
    
    mutating func delete(_ habitIndex: Int) {
        // Remove habit at the given index
        self.habits.remove(at: habitIndex)

        // Persist on the changes we made to our habits array
        self.saveHabits()
    }
    
    mutating func markHabitAsCompleted(_ habitIndex: Int) -> Habit {
        // Step 12
        var updatedHabit = self.habits[habitIndex]

        // Step 13
        guard updatedHabit.completedToday == false else { return updatedHabit }

        updatedHabit.numberOfCompletions += 1

        // Step 14
        if let lastCompletionDate = updatedHabit.lastCompletionDate, lastCompletionDate.isYesterday {
            updatedHabit.currentStreak += 1
        } else {
            updatedHabit.currentStreak = 1
        }

        // Step 15
        if updatedHabit.currentStreak > updatedHabit.bestStreak {
            updatedHabit.bestStreak = updatedHabit.currentStreak
        }

        // Step 16
        let now = Date()
        updatedHabit.lastCompletionDate = now

        // Step 17
        self.habits[habitIndex] = updatedHabit

        // Step 18
        self.saveHabits()
        return updatedHabit
    }
    
    // Step 19
    mutating func swapHabits(habitIndex: Int, destinationIndex: Int) {
        let habitToSwap = self.habits[habitIndex]
        self.habits.remove(at: habitIndex)
        self.habits.insert(habitToSwap, at: destinationIndex)
        self.saveHabits()
    }

    // Step 20
    mutating func setNeedsToReloadHabits() {
        self.loadHabits()
    }
    
}
