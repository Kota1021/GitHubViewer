//
//  SearchViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet var SearchBar: UISearchBar!

    public var repositories: [[String: Any]] = []

    private var task: URLSessionTask?
    private var query: String?
    public var selectedRowIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        SearchBar.text = "GitHubのリポジトリを検索できるよー"
        SearchBar.delegate = self
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // delete placeholder text
        searchBar.text = ""
        return true
    }

    // on query changed
    func searchBar(_: UISearchBar, textDidChange _: String) {
        task?.cancel()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        query = searchBar.text
        guard let query, !query.isEmpty else {
            assertionFailure("query nil or empty, query: \(String(describing: query))")
            return
        }
        guard let url = URL(string: "https://api.github.com/search/repositories?q=\(query)") else {
            assertionFailure("URL nil")
            return
        }

        // prepare network request
        task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let object = try! JSONSerialization.jsonObject(with: data!) as? [String: Any] else { return }
            guard let items = object["items"] as? [[String: Any]] else { return }
            self.repositories = items
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        // practice network request
        task?.resume()
    }

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "Detail" {
            let detail = segue.destination as! DetailViewController
            detail.searchViewController = self
        }
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return repositories.count
    }

    override func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let repository = repositories[indexPath.row]
        cell.textLabel?.text = repository["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = repository["language"] as? String ?? ""
        cell.tag = indexPath.row
        return cell
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        selectedRowIndex = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }
}
