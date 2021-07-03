//
//  SearchGroupsTableViewController.swift
//  vkApp
//
//  Created by Anna Delova on 4/14/21.
//

import UIKit
import RealmSwift

class SearchGroupsTableViewController: UITableViewController, UISearchBarDelegate {
    
    private let networkService = NetworkRequests()
    var searchedGroups = try? RealmService.load(typeOf: SearchGroups.self) 
    private var token: NotificationToken?

    private var search: Results<SearchGroups>?
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "GroupCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "GroupCell")
        
        searchBar.delegate = self
        searchBar.backgroundColor = .clear
        observeRealm()
        networkService.searchGroups(search: "Music", completion: { vkSearchGroups in
            guard let groupsSearch = vkSearchGroups else { return }
            do {
                try RealmService.save(items: groupsSearch)
                print(groupsSearch)
            } catch {
                print(error)
            }
        }
        )
 
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        token?.invalidate()
    }
    private func observeRealm() {
        token = searchedGroups?.observe({ changes in
            switch changes {
            case .initial(let results):
                self.tableView.reloadData()
            case let .update(results, deletions, insertions, modifications):
                print(results, deletions, insertions, modifications)
                self.tableView.reloadData()
            case .error(let error):
                print(error)
            }
        })
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedGroups?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? GroupCell,
            let currentGroup = searchedGroups?[indexPath.row]
        else { return UITableViewCell() }
        
        cell.configure(
            name: currentGroup.name,
            imageURL: currentGroup.photo )
        return cell
    }


    // MARK: - Table view delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.addGroup,
                     sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    // MARK SEARCH BAR
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            search = searchedGroups
//        } else {
//            for group in search {
//                if group.groupName.lowercased().contains(searchText.lowercased()) {
//                    searchGroup.append(group)
//                }
//        }
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        tableView.reloadData()
    }


}
