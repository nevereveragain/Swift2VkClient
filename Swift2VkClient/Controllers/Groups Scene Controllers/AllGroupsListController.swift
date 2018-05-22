//
//  AllGroupsListController.swift
//  Swift2VkClient
//
//  Created by yosh on 20.05.2018.
//  Copyright © 2018 yosh. All rights reserved.
//

import UIKit

class AllGroupsListController: UITableViewController, UISearchBarDelegate {

    struct Group {
        var name = String()
        var groupSize = String()
    }
    var filteredData: [Group] = []
    
    var allGroupsList = [
        Group(name: "Star Wars", groupSize: "1000"),
        Group(name: "Dodo Pizza", groupSize: "5000"),
        Group(name: "Firefly", groupSize: "1000"),
        Group(name: "Den Simons", groupSize: "100"),
        Group(name: "God is an Astronaut", groupSize: "1000"),
        Group(name: "Kalmah", groupSize: "1000"),
    ]

    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchBar()
        filteredData = allGroupsList
        alterLayout()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func setUpSearchBar() {
        searchBar.delegate = self
    }
    
    func alterLayout() {
        tableView.tableHeaderView = UIView()
        // search bar in section header
        tableView.estimatedSectionHeaderHeight = 50
        // search bar in navigation bar
        //navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchBar)
        navigationItem.titleView = searchBar
        searchBar.showsScopeBar = false // you can show/hide this dependant on your layout
        searchBar.placeholder = "Search Group by Name"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                        return filteredData.count
                    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            // получаем ячейку из пула
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? AllGroupsCellController else {
                return UITableViewCell()
            }
            cell.groupToAddName.text = filteredData[indexPath.row].name
            // Я слишком много времени потратил на SearchBar, поэтому групп сайз у меня стринговый, хотя должен быть интовым. Потом передалю нормально
            cell.groupToAddUsersCounter.text = filteredData[indexPath.row].groupSize
            cell.groupToAddImage.image = UIImage(named: "grouptoadd")
            return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = allGroupsList.filter({ name -> Bool in
            switch searchBar.selectedScopeButtonIndex {
            case 0:
                if searchText.isEmpty { return true }
                return name.name.lowercased().contains(searchText.lowercased())
            default:
                return false
            }
        })
        tableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            filteredData = allGroupsList
        default:
            break
        }
        tableView.reloadData()
    }
}
