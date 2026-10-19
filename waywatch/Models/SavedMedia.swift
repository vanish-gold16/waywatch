//
//  SavedMedia.swift
//  waywatch
//
//  Created by Vanya on 19.10.2026.
//
import Foundation
import SwiftData

@Model
final class SavedMedia {
    var name: String
    var chipNumber: Int
    var addedAt: Date
    
    init(name: String, chipNumber: Int, addedAt: Date) {
        self.name = name
        self.chipNumber = chipNumber
        self.addedAt = addedAt
    }
}
