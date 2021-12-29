//
//  SingleClub+CoreDataProperties.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/28/21.
//
//

import Foundation
import CoreData


extension SingleClub {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SingleClub> {
        return NSFetchRequest<SingleClub>(entityName: "SingleClub")
    }

    @NSManaged public var averageFull: Int64
    @NSManaged public var averageMax: Int64
    @NSManaged public var averageThreeFourths: Int64
    @NSManaged public var fullSwingDistance: Int64
    @NSManaged public var maxDistance: Int64
    @NSManaged public var name: String?
    @NSManaged public var prevFullSwingHits: [Int]?
    @NSManaged public var prevMaxHits: [Int]?
    @NSManaged public var prevTFHits: [Int]?
    @NSManaged public var threeFourthsDistance: Int64
    @NSManaged public var type: String?
    @NSManaged public var wedges: UserGolfBag?
    @NSManaged public var woods: UserGolfBag?
    @NSManaged public var irons: UserGolfBag?
    @NSManaged public var hybrids: UserGolfBag?

}

extension SingleClub : Identifiable {

}
