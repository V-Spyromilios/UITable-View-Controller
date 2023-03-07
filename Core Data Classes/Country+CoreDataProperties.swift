//
//  Country+CoreDataProperties.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 06.03.23.
//
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged public var countryDescription: String
    @NSManaged public var euMember: Bool
    @NSManaged public var flagPath: String
    @NSManaged public var gdp: Int64
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var name: String

}

extension Country : Identifiable {

}
