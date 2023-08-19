//
//  GitHubAPI.swift
//  iOSEngineerCodeCheck
//
//  Created by 松本幸太郎 on 2023/08/19.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//
import Foundation
import UIKit

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

    public func fetchOwnerAvater(of repository: Repository) async -> UIImage? {
        guard let url = URL(string: repository.owner.avatarUrl) else {
            assertionFailure("invalid image URL")
            return nil
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
        } catch {
            return nil
        }
    }
}

enum GitHubAPIError: Error {
    case invalidURL
}
