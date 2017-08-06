//
//  ReminderStore.swift
//  Reminders
//
//  Created by Justin Rose on 6/2/17.
//  Copyright © 2017 justncode. All rights reserved.
//

class ReminderStore {
    
    var allReminders = [Reminder]()
    
    var reminderCount: Int {
        return allReminders.count
    }
    
    func append(_ reminder: Reminder) {
        allReminders.append(reminder)
    }
    
    func insert(_ reminder: Reminder, at: Int) {
        allReminders.insert(reminder, at: at)
    }
}
