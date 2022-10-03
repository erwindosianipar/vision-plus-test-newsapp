//
//  NewsEndpoint.swift
//  vision-plus-test-newsapp
//
//  Created by Erwindo Sianipar on 03/10/22.
//

enum NewsEndpoint {
    case articles
}

extension NewsEndpoint: Endpoint {
    
    var base: String {
        return "https://60a4954bfbd48100179dc49d.mockapi.io/api/innocent/newsapp"
    }
    
    var method: String {
        switch self {
        case .articles:
            return "GET"
        }
    }
    
    var path: String {
        switch self {
        case .articles:
            return "/articles"
        }
    }
}
