//
//  SearchResult.swift
//  iOSEngineerCodeCheck
//
//  Created by 松本幸太郎 on 2023/08/18.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

struct SearchResult: Decodable {
    var totalCount: Int
    var incompleteResults: Bool
    var items: [Repository]
}
