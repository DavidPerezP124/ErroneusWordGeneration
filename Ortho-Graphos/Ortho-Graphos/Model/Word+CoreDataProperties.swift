//
//  Word+CoreDataProperties.swift
//  Ortho-Graphos
//
//  Created by David Perez on 1/12/19.
//  Copyright © 2019 David Perez P. All rights reserved.
//
//

import Foundation
import CoreData


extension Word {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Word> {
        return NSFetchRequest<Word>(entityName: "Word")
    }

    @NSManaged public var word: String

}
