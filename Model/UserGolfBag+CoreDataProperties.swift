//
//  UserGolfBag+CoreDataProperties.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/28/21.
//
//

import Foundation
import CoreData


extension UserGolfBag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserGolfBag> {
        return NSFetchRequest<UserGolfBag>(entityName: "UserGolfBag")
    }

    @NSManaged public var clubTypes: [String]?
    @NSManaged public var numberOfClubs: Int64
    @NSManaged public var woodsArr: NSSet?
    @NSManaged public var hybridsArr: NSSet?
    @NSManaged public var ironsArr: NSSet?
    @NSManaged public var wedgesArr: NSSet?

}

// MARK: Generated accessors for woodsArr
extension UserGolfBag {

    @objc(addWoodsArrObject:)
    @NSManaged public func addToWoodsArr(_ value: SingleClub)

    @objc(removeWoodsArrObject:)
    @NSManaged public func removeFromWoodsArr(_ value: SingleClub)

    @objc(addWoodsArr:)
    @NSManaged public func addToWoodsArr(_ values: NSSet)

    @objc(removeWoodsArr:)
    @NSManaged public func removeFromWoodsArr(_ values: NSSet)

}

// MARK: Generated accessors for hybridsArr
extension UserGolfBag {

    @objc(addHybridsArrObject:)
    @NSManaged public func addToHybridsArr(_ value: SingleClub)

    @objc(removeHybridsArrObject:)
    @NSManaged public func removeFromHybridsArr(_ value: SingleClub)

    @objc(addHybridsArr:)
    @NSManaged public func addToHybridsArr(_ values: NSSet)

    @objc(removeHybridsArr:)
    @NSManaged public func removeFromHybridsArr(_ values: NSSet)

}

// MARK: Generated accessors for ironsArr
extension UserGolfBag {

    @objc(addIronsArrObject:)
    @NSManaged public func addToIronsArr(_ value: SingleClub)

    @objc(removeIronsArrObject:)
    @NSManaged public func removeFromIronsArr(_ value: SingleClub)

    @objc(addIronsArr:)
    @NSManaged public func addToIronsArr(_ values: NSSet)

    @objc(removeIronsArr:)
    @NSManaged public func removeFromIronsArr(_ values: NSSet)

}

// MARK: Generated accessors for wedgesArr
extension UserGolfBag {

    @objc(addWedgesArrObject:)
    @NSManaged public func addToWedgesArr(_ value: SingleClub)

    @objc(removeWedgesArrObject:)
    @NSManaged public func removeFromWedgesArr(_ value: SingleClub)

    @objc(addWedgesArr:)
    @NSManaged public func addToWedgesArr(_ values: NSSet)

    @objc(removeWedgesArr:)
    @NSManaged public func removeFromWedgesArr(_ values: NSSet)

}

extension UserGolfBag : Identifiable {

}
