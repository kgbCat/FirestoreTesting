//
//  PhotoCollectionViewController.swift
//  vkApp
//
//  Created by Anna Delova on 4/18/21.
//
import RealmSwift
import UIKit


 var cellId = "FriendPhoto"
 var header = "header"

class PhotoCollectionViewController: UICollectionViewController {
    private let networkService = NetworkRequests()

    var photos = try? RealmService.load(typeOf: Photos.self)
    private var token: NotificationToken?
    
    var userID: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
    
       // "FriendPhoto" Register
        let cellNib = UINib(
            nibName: cellId,
            bundle: nil)
        collectionView.register(cellNib,forCellWithReuseIdentifier: cellId)
     
        // header register
        let nib = UINib(
            nibName: header,
            bundle: nil)
        collectionView.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: header)
        
        observeRealm()
        
        if let userID = userID {
            networkService.getPhotos(userID: userID, completion: { vkPhotos in
                guard let photos = vkPhotos else { return }
                do {
                    try RealmService.save(items: photos)
                    print(photos)
                } catch {
                    print(error)
                }
            }
            )
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
    token = photos?.observe({ changes in
        switch changes {
        case .initial(let results):
            self.collectionView.reloadData()
        case let .update(results, deletions, insertions, modifications):
            print(results, deletions, insertions, modifications)
            self.collectionView.reloadData()
        case .error(let error):
            print(error)
        }
    })
}
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? FriendPhoto,
            let currentPhoto = photos?[indexPath.row]
        else { return UICollectionViewCell() }
        cell.configure(imageURL: currentPhoto.photoSizes.first(where: { ("y").contains($0.type) })?.url ?? "")
        cell.animation3()
        cell.animatePhoto()
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedItem = sender as? UIImage? else { return }
        if segue.identifier == "showPhoto"{
            guard let destinationVC = segue.destination as? PhotoViewController else { return }
            destinationVC.selectedData = selectedItem
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let selectedData = photos?[indexPath.item]
        self.performSegue(withIdentifier: "showPhoto", sender: selectedData)
                
    }
//Header
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
           if kind == UICollectionView.elementKindSectionHeader {
               let view = collectionView
                   .dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                     withReuseIdentifier: header,
                                                     for: indexPath)
               return view
           } else {
               let view = collectionView
                   .dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                     withReuseIdentifier: header,
                                                     for: indexPath)
               return view
           }
       }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: view.frame.size.width/2)
    }

}

extension PhotoCollectionViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

