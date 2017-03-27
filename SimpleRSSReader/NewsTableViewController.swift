//
//  NewsTableViewController.swift
//  SimpleRSSReader
//
//  Created by Pablo Mateo Fernández on 02/02/2017.
//  Copyright © 2017 355 Berry Street S.L. All rights reserved.
//

import UIKit

//XMLParser, XMLParserDelegate
    //Event-Reader
class NewsTableViewController: UITableViewController {

    
    private var rssItems: [(title: String, description: String, pubDate: String)]?
    override func viewDidLoad() {
        
        super.viewDidLoad()

        tableView.estimatedRowHeight = 155.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let feedParser = FeedParser()
        
        feedParser.parseFeed(feedUrl: "https://www.apple.com/main/rss/hotnews/hotnews.rss") { (rssItems: [(title: String, description: String, pubDate: String)]) in
            self.rssItems = rssItems
            OperationQueue.main.addOperation {
                self.tableView.reloadSections(IndexSet(integer: 0), with: .none)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows
        guard let rssItems = rssItems else {
        return 0
        }
        return rssItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as!
        NewsTableViewCell
        
        if let item = rssItems?[indexPath.row] {
            cell.titleLabel = item.title
            cell.descriptionLabel.text = item.description
            cell.dateLabel.text = item.pubdate
        }
        return cell
    }

}
