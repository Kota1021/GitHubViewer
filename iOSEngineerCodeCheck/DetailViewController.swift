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
        TitleLabel.text = repository.fullName
        Language.text = "Written in \(repository.language ?? "")" // api can return null for language
        StarCount.text = "\(repository.stargazersCount) stars"
        WatchCount.text = "\(repository.watchersCount) watchers"
        ForkCount.text = "\(repository.forksCount) forks"
        IssueCount.text = "\(repository.openIssuesCount) open issues"
        Task {
            ImageView.image = await fetchImage() ?? UIImage(systemName: "person.crop.circle.badge.questionmark")
        }
    }

    private func fetchImage() async -> UIImage? {
        guard let repository else {
            assertionFailure("repository nil")
            return nil
        }
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
