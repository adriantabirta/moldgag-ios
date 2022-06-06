//
//  Realm+.swift
//  moldgag
//
//  Created by Adrian Tabirta on 27.05.2022.
//

import RealmSwift
import Foundation

/// Dummy protocol for Database Entities
public protocol Storable {}

/// Conform realm `Object` to `Storable`
extension Object: Storable {}

/// Conform realm `EmbeddedObject` to `Storable`
extension EmbeddedObject: Storable {}
