//
//  NewsResponseModel.swift
//  vision-plus-test-newsapp
//
//  Created by Erwindo Sianipar on 03/10/22.
//

struct NewsResponseModel: Decodable, Encodable {
    let id: String
    let createdAt: String
    let contributorName: String
    let contributorAvatar: String
    let title: String
    let content: String
    let contentThumbnail: String
    let slideshow: [String]
}
