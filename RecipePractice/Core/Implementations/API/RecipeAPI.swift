//
//  RecipeAPI.swift
//  RecipePractice
//
//  Created by Sofia Krakova on 11.07.2024.
//

import Foundation
import Moya

enum RecipeAPI {
    case getRecipes
}

extension RecipeAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://www.themealdb.com/api/json/v1/1/search.php?s=")!
    }
    
    var path: String {
        switch self {
        case .getRecipes:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getRecipes:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getRecipes:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
