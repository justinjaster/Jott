//
//  RemindersViewController.swift
//  Reminders
//
//  Created by Justin Rose on 6/2/17.
//  Copyright © 2017 justncode. All rights reserved.
//

import UIKit
import CoreData

class RemindersViewController: UIViewController, ReminderTableViewHeaderDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var header: ReminderTableViewHeader!
    
    var reminderStore: ReminderStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getReminders()
        
        tableView.tableFooterView = UIView()
        header.delegate = self
    }
    
    func returnPressed(_ sender: ReminderTableViewHeader, reminderName: String) {
        let reminder: Reminder = NSEntityDescription.insertNewObject(forEntityName: "Reminder", into: RemindersController.getContext()) as! Reminder
        reminder.name = reminderName
        
        reminderStore.insert(reminder, at: 0)
        
        RemindersController.saveContext()
        
        tableView.reloadData()
    }
    
    func getReminders() {
        let fetchRequest: NSFetchRequest<Reminder> = Reminder.fetchRequest()
        
        do {
            let searchResults = try RemindersController.getContext().fetch(fetchRequest)
            
            reminderStore.allReminders = searchResults.reversed()
        } catch {
            print("Error: \(error)")
        }
        
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate methods
extension RemindersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66.0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let reminder = reminderStore.allReminders[indexPath.row]
            RemindersController.getContext().delete(reminder)
            RemindersController.saveContext()
        }
        
        getReminders()
    }
}

// MARK: - UITableViewDataSource methods
extension RemindersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminderStore.reminderCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reminderCell", for: indexPath) as! ReminderCell
        cell.reminderLabel?.text = reminderStore.allReminders[indexPath.row].name
        
        return cell
    }
}
