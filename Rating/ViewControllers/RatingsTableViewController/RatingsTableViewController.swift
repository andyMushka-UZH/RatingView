//
//  RatingsTableViewController.swift
//  Rating
//

import UIKit

class RatingsTableViewController: UITableViewController {
    
    var dataSource = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()

        for _ in 0...200 {
            dataSource.append(Int.random(in: 0...100))
        }
        
        tableView.reloadData()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RatingTableViewCell", for: indexPath) as! RatingTableViewCell
        cell.value = dataSource[indexPath.row]
        return cell
    }




}
