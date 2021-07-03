//
//  GroupsTableViewController.swift
//  vkApp
//
//  Created by Anna Delova on 4/13/21.
//

import UIKit
import RealmSwift

class GroupsTableViewController: UITableViewController {
    
    private let networkService = NetworkRequests()
    private let groups = try? RealmService.load(typeOf: Groups.self)
    private var token: NotificationToken?
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {

        guard
            segue.identifier == Constants.addGroup ,
            let SearchGroupsController = segue.source as? SearchGroupsTableViewController,
            let indexPath = SearchGroupsController.tableView.indexPathForSelectedRow
        else { return }
//        let group = SearchGroupsController.searchedGroups?[indexPath.row]
//        if groups.?.contains(group){
//
//        }
//        if !groups.contains(group ?? "") {
//            groups.append(group)
//            tableView.reloadData()
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "GroupCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "GroupCell")
        observeRealm()
        //fetch groups from the account
        networkService.getGroup { vkGroups in
            guard let groups = vkGroups else { return }
            do {
                try RealmService.save(items: groups)
            } catch {
                print(error)
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        token?.invalidate()
    }
    
    private func observeRealm() {
        token = groups?.observe({ changes in
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
       return groups?.count ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? GroupCell,
            let currentGroup = groups?[indexPath.row]
        else { return UITableViewCell() }
             
        cell.configure(name: currentGroup.name, imageURL: currentGroup.photo)

        return cell
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            groups.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
    }
    
    // Header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = TableSectionHeaderView()
        headerView.configure(with: "MY GROUPS")
    
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60
    }
    
    
    // Footer
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = TableSectionHeaderView()
        footer.configure(with: "--------")
        return footer
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        30
    }
}

