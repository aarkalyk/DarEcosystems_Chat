//
//  Message+CoreDataClass.swift
//  Dar_Assignment
//
//  Created by ARKALYK AKASH on 7/22/17.
//  Copyright © 2017 ARKALYK AKASH. All rights reserved.
//

import Foundation
import CoreData

@objc(Message)
public class Message: NSManagedObject {
    convenience init(text : String?, imageData : NSData?, context : NSManagedObjectContext) {
        if let ent = NSEntityDescription.entity(forEntityName: Message.entityName, in: context){
            self.init(entity: ent, insertInto: context)
            self.text = text
            self.imageData = imageData
            self.createdAt = NSDate()
        }else{
            fatalError("Unable to find entity \(Message.entityName)")
        }
    }
}
