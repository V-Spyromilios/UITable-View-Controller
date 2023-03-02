//
//  EuCountries+CoreDataProperties.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 02.03.23.
//
//

import Foundation
import CoreData


extension EuCountries {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EuCountries> {
        return NSFetchRequest<EuCountries>(entityName: "EuCountries")
    }

    @NSManaged public var members: NSOrderedSet?

}

// MARK: Generated accessors for members
extension EuCountries {

    @objc(insertObject:inMembersAtIndex:)
    @NSManaged public func insertIntoMembers(_ value: Country, at idx: Int)

    @objc(removeObjectFromMembersAtIndex:)
    @NSManaged public func removeFromMembers(at idx: Int)

    @objc(insertMembers:atIndexes:)
    @NSManaged public func insertIntoMembers(_ values: [Country], at indexes: NSIndexSet)

    @objc(removeMembersAtIndexes:)
    @NSManaged public func removeFromMembers(at indexes: NSIndexSet)

    @objc(replaceObjectInMembersAtIndex:withObject:)
    @NSManaged public func replaceMembers(at idx: Int, with value: Country)

    @objc(replaceMembersAtIndexes:withMembers:)
    @NSManaged public func replaceMembers(at indexes: NSIndexSet, with values: [Country])

    @objc(addMembersObject:)
    @NSManaged public func addToMembers(_ value: Country)

    @objc(removeMembersObject:)
    @NSManaged public func removeFromMembers(_ value: Country)

    @objc(addMembers:)
    @NSManaged public func addToMembers(_ values: NSOrderedSet)

    @objc(removeMembers:)
    @NSManaged public func removeFromMembers(_ values: NSOrderedSet)

}

extension EuCountries : Identifiable {

}
