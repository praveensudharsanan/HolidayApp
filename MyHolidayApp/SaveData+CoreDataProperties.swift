//
//  SaveData+CoreDataProperties.swift
//  MyHolidayApp
//
//  Created by user199544 on 12/13/21.
//
//

import Foundation
import CoreData


extension SaveData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SaveData> {
        return NSFetchRequest<SaveData>(entityName: "SaveData")
    }

    @NSManaged public var date: String?
    @NSManaged public var holiday: String?

}

extension SaveData : Identifiable {

}
