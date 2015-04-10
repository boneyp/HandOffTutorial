//
//  Contacts.swift
//  HandOffTutorial
//
//  Created by Boney Philip on 3/22/15.
//  Copyright (c) 2015 iospool. All rights reserved.
//

import UIKit

class Contacts: NSObject {
    
    var firstName:NSString?
    var lastName:NSString?
    var phoneNumber:NSString?
    var emailId: NSString?
    let documnetsDirectory: NSString?
    
    override init() {
        let pathArray = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,NSSearchPathDomainMask.UserDomainMask,true)
        documnetsDirectory = pathArray[0] as String
    }
    
    func getDictionaryFromContactData()->Dictionary <String,String>{
        var dictionary : [String:String] = ["firstName": firstName!,"lastName": lastName!,"phoneNumber":  phoneNumber!,"emailId": emailId!]
        return dictionary
    }
    
    func getContactDataFromDictionary(dictionary:Dictionary<NSObject,AnyObject>){
        firstName = dictionary["firstName"] as? String
        lastName = dictionary["lastName"] as? String
        phoneNumber = dictionary["phoneNumber"] as? String
        emailId = dictionary["emailId"] as? String
    }
    
    func saveContact(){
        let contactFilePath = documnetsDirectory?.stringByAppendingPathComponent("Contacts")
        var allContacts = loadAllContacts()
        allContacts.addObject(self)
        var allContactsCOnverted = NSMutableArray()
        let contactCount = allContacts.count
        for var i = 0; i<contactCount; ++i{
            allContactsCOnverted.addObject(allContacts.objectAtIndex(i).getDictionaryFromContactData())
        }
        allContactsCOnverted.writeToFile(contactFilePath!, atomically: false)
        
    }
    
    func loadAllContacts()->NSMutableArray{
        let ContactFilePath = documnetsDirectory?.stringByAppendingPathComponent("Contacts")
        var allContacts =  NSMutableArray()
        if NSFileManager.defaultManager().fileExistsAtPath(ContactFilePath!){
            let savedContactFile = NSMutableArray(contentsOfFile: ContactFilePath!)
            for var i = 0 ; i<savedContactFile?.count; ++i {
                let tempContact = Contacts()
                tempContact.getContactDataFromDictionary(savedContactFile?.objectAtIndex(i) as Dictionary<NSObject,AnyObject>)
                allContacts.addObject(tempContact)
                }
        }
        return allContacts
    }
    
    class func updateSavedContact(contacts:NSMutableArray) {
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as String
        let contactFilePath = documentsDirectory.stringByAppendingPathComponent("Contact")
        var contactsConverted = NSMutableArray()
        for var i = 0; i < contacts.count; ++i {
            contactsConverted.addObject(contacts.objectAtIndex(i).getDictionaryFromContactData())
        }
        contactsConverted.writeToFile(contactFilePath, atomically: true)
    }
}



