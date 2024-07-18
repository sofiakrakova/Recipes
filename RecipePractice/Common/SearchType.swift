//
//  SearchType.swift
//  RecipePractice
//
//  Created by Sofia Krakova on 17.07.2024.
//

import Foundation
//import RealmSwift

enum SearchType: String, CaseIterable, Identifiable {
    case byName = "Name"
    case byIngredients = "Ingredients"
    
    var id: String { self.rawValue }
}
