//
//  Message+CoreDataProperties.swift
//  Dar_Assignment
//
//  Created by ARKALYK AKASH on 7/22/17.
//  Copyright © 2017 ARKALYK AKASH. All rights reserved.
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message");
    }

    @NSManaged public var text: String?
    @NSManaged public var createdAt: NSDate?
    @NSManaged public var imageData: NSData?
    
    static let entityName = "Message"
    static let createdAtKey = "createdAt"
    static let textKey = "text"
    static let imageDataKey = "imageData"
}
