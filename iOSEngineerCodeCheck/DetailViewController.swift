//
//  DetailViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var ImageView: UIImageView!

    @IBOutlet var TitleLabel: UILabel!

    @IBOutlet var Language: UILabel!

    @IBOutlet var StarCount: UILabel!
    @IBOutlet var WatchCount: UILabel!
    @IBOutlet var ForkCount: UILabel!
    @IBOutlet var IssueCount: UILabel!

    var searchViewController: SearchViewController!
    private var repository: Repository?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let selectedRowIndex = searchViewController.selectedRowIndex else {
            preconditionFailure("selectedRowIndex nil")
        }
        repository = searchViewController.repositories[selectedRowIndex]

        guard let repository else { return }
        Language.text = "Written in \(repository.language ?? "")" // api can return null for language
        StarCount.text = "\(repository.stargazersCount) stars"
        WatchCount.text = "\(repository.watchersCount) watchers"
        ForkCount.text = "\(repository.forksCount) forks"
        IssueCount.text = "\(repository.openIssuesCount) open issues"
        getImage()
    }

    private func getImage() {
        guard let repository else { return }
        TitleLabel.text = repository.fullName
        guard let url = URL(string: repository.owner.avatarUrl) else {
            assertionFailure("invalid image URL")
            return
        }
        URLSession.shared.dataTask(with:  url) { data, _, _ in
            let image = UIImage(data: data!)!
            DispatchQueue.main.async {
                self.ImageView.image = image
            }
        }.resume()
    }
}
