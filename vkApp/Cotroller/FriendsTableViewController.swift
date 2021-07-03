
import UIKit
import RealmSwift

class FriendsTableViewController: UITableViewController, UISearchBarDelegate {
    
    private let networkService = NetworkRequests()
    
    private let users = try? RealmService.load(typeOf: Friend.self).filter("firstName != 'DELETED' AND userAvatarURL != 'https://vk.com/images/deactivated_200.png'").sorted(byKeyPath: "firstName")
    
    
    private var token: NotificationToken?

    let cellID = "UserCell"

    @IBOutlet weak var searchBar: UISearchBar!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeRealm()
        // UserCell Register
        let nib = UINib(nibName: cellID, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellID)
        
        networkService.getFriends { vkFriends in
            guard let friends = vkFriends else { return }
            do {
                try RealmService.save(items: friends)
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
        token = users?.observe({ changes in
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let
            destination = segue.destination as? PhotoCollectionViewController,
           let index = tableView.indexPathForSelectedRow?.row {
            destination.userID = users?[index].id
            print(users?[index].id ?? 0)

        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? UserCell,
            let currentFriend = users?[indexPath.row]
        else { return UITableViewCell() }
        
        cell.configure(
            name: currentFriend.fullName,
            imageURL: currentFriend.userAvatarURL
            )

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: true) }
        performSegue(
            withIdentifier: "showPhoto",
            sender: nil)
        
//        guard let friendPhotosVC = UIStoryboard(
//                name: "Main",
//                bundle: nil)
//            .instantiateViewController(identifier: "PhotoCollectionViewController")
//                as? PhotoCollectionViewController
//        else { return }
//        if let user = users?[indexPath.row] {
//            print(user)
////            friendPhotosVC.photos = [user.userPhotos]
//        }
//        navigationController?.pushViewController(friendPhotosVC, animated: true)

    }
    
}


