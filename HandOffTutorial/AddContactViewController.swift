//
//  DetailViewController.swift
//  HandOffTutorial
//
//  Created by Boney Philip on 3/22/15.
//  Copyright (c) 2015 iospool. All rights reserved.
//

import UIKit

protocol AddContactViewControllerDelegate{
    func contactWasSaved(contacts:Contacts)
}

class AddContactViewController: UIViewController , UITextFieldDelegate{

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var firstNametxtField: UITextField!
    @IBOutlet weak var lastNametxtField: UITextField!
    @IBOutlet weak var phoneNumbertxtField: UITextField!
    @IBOutlet weak var emailtxtField: UITextField!

    
    var delegate: AddContactViewControllerDelegate?

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail: AnyObject = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       // self.configureView()
        firstNametxtField.delegate = self
        lastNametxtField.delegate = self
        phoneNumbertxtField.delegate = self
        emailtxtField.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        createUserActivity()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
     func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField .resignFirstResponder()
        userActivity?.needsSave = true
        return true
    }
    
    @IBAction func saveContact(sender:AnyObject){
        var contact = Contacts()
        contact.firstName = firstNametxtField.text
        contact.lastName = lastNametxtField.text
        contact.phoneNumber = phoneNumbertxtField.text
        contact.emailId = emailtxtField.text
        contact.saveContact()
        self.delegate?.contactWasSaved(contact)
        self.performSegueWithIdentifier("idUnwindSegueEditContact", sender: self)
    }
    
    func createUserActivity() {
        userActivity = NSUserActivity(activityType: "erer")
        userActivity?.title  = "Add"
        userActivity?.becomeCurrent()
    }
    override func updateUserActivityState(activity: NSUserActivity) {
        let contact = Contacts()
        contact.firstName = firstNametxtField.text
        contact.lastName = lastNametxtField.text
        contact.phoneNumber = phoneNumbertxtField.text
        contact.emailId = emailtxtField.text
        activity.addUserInfoEntriesFromDictionary(contact.getDictionaryFromContactData())
        super.updateUserActivityState(activity)
    }
    
    @IBAction func unwindToContactsListViewController(unwindSegue: UIStoryboardSegue){
        userActivity?.invalidate()
    }

    
}

