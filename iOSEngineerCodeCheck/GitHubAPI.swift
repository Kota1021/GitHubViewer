//
//  GitHubAPI.swift
//  iOSEngineerCodeCheck
//
//  Created by 松本幸太郎 on 2023/08/19.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//
import Foundation

struct GitHubAPI {
    public func searchForRepositories(with query: String) async throws -> [Repository] {
        guard let url = URL(string: "https://api.github.com/search/repositories?q=\(query)") else {
            assertionFailure("URL nil")
            throw GitHubAPIError.invalidURL
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let (data, _) = try await URLSession.shared.data(from: url)
        let searchResult = try decoder.decode(SearchResult.self, from: data)
        return searchResult.items
    }
}

enum GitHubAPIError: Error {
    case invalidURL
}
