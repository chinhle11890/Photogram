//
//  HomeTableViewController.swift
//  Photogram
//
//  Created by Bao Nguyen on 9/20/16.
//  Copyright © 2016 Chinh Le. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    private let homeCell = "homeCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 597
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: homeCell, for: indexPath) as! HomeTableViewCell

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 10
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }

}
