//
//  Player+CoreDataProperties.swift
//  ProjectGame
//
//  Created by Dmitry Kononov on 3.02.22.
//
//

import Foundation
import CoreData


extension Player {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Player")
    }

    @NSManaged public var name: String?
    @NSManaged public var score: Int64

}

extension Player : Identifiable {

}
