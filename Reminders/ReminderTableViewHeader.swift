//
//  ReminderTableViewHeader.swift
//  Reminders
//
//  Created by Justin Rose on 7/3/17.
//  Copyright © 2017 justncode. All rights reserved.
//

import UIKit

extension UIButton {
    func rotate(to angle: CGFloat) {
        UIView.animate(withDuration: 0.5) {
            self.transform = CGAffineTransform(rotationAngle: angle)
        }
    }
}

extension UIView {
    func addBottomBorder(with color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
}

protocol ReminderTableViewHeaderDelegate {
    func returnPressed(_ sender: ReminderTableViewHeader, reminderName: String)
}

class ReminderTableViewHeader: UIView, UITextFieldDelegate {
    
    @IBOutlet var reminderTextField: UITextField!
    @IBOutlet var addReminderButton: UIButton!
    
    var tapped = false
    var delegate: ReminderTableViewHeaderDelegate?
    
    override func awakeFromNib() {
        self.addBottomBorder(with: UIColor(red: 129.0/255.0, green: 67.0/255.0, blue: 116.0/255.0, alpha: 0.5), width: 0.5)
        
        reminderTextField?.delegate = self
    }
    
    @IBAction func addReminder(_ sender: UIButton) {
        if tapped {
            sender.rotate(to: 0)
            reminderTextField?.resignFirstResponder()
            tapped = false
        } else {
            sender.rotate(to: CGFloat.pi / 4)
            reminderTextField?.becomeFirstResponder()
            tapped = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, !text.isEmpty else { return false }
        
        delegate?.returnPressed(self, reminderName: text)
        
        textField.text = ""
        textField.resignFirstResponder()
        addReminderButton.rotate(to: 0)
        
        tapped = false
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        addReminderButton.rotate(to: CGFloat.pi / 4)
        tapped = true
    }
    
}
