//
//  Repository.swift
//  iOSEngineerCodeCheck
//
//  Created by 松本幸太郎 on 2023/08/18.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.

struct Repository: Decodable {
    var fullName: String
    var language: String?
    var stargazersCount: Int
    var watchersCount: Int
    var forksCount: Int
    var openIssuesCount: Int
    var owner: Owner
}
