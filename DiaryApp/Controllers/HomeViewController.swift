//
//  HomeViewController.swift
//  DiaryApp
//
//  Created by Evgenii Kolgin on 16.11.2020.
//

import UIKit
import FirebaseAuth
import RealmSwift

class HomeViewController: UIViewController {
    
    let realm = try! Realm()
    
    var notes: Results<UserNotes>?
        
    private var collectionView: UICollectionView?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        handleNotAuthenticated()
        loadObjects()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(didTapLogOutButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        navigationController?.view.backgroundColor = .systemIndigo
//        view.backgroundColor = .systemBackground
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.width - 50, height: view.height * 0.6)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        layout.minimumLineSpacing = 50
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        collectionView?.backgroundColor = .systemBackground
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        guard let myCollection = collectionView else { return }
        
        view.addSubview(myCollection)
    }
    
    @objc private func didTapAddButton() {
        let vc = addNoteViewController()
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc private func didTapLogOutButton() {
        
        let actionSheet = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            
            AuthManager.shared.logOut { (success) in
                DispatchQueue.main.async {
                    if success {
                        // present log in
                        let loginVC = LoginViewController()
                        loginVC.modalPresentationStyle = .fullScreen
                        self.present(loginVC, animated: true)
                    } else {
                        // error occured
                        fatalError("Could not log out user")
                    }
                }
            }
        }))
        present(actionSheet, animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView?.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
    }
    
    private func handleNotAuthenticated() {
        
        if Auth.auth().currentUser == nil {
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false, completion: nil)
        }
    }
    
    private func configureCell(with cell: UICollectionViewCell) {
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 5, height: 5)
        cell.layer.shadowOpacity = 0.5
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    private func loadObjects() {
        notes = realm.objects(UserNotes.self)
        collectionView?.reloadData()
    }
}

//MARK: - CollectionView

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if realm.isEmpty {
            return 1
        }
        return notes?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as! HomeCollectionViewCell
        if !realm.isEmpty {
            cell.configure(with: notes?[indexPath.row].imageName ?? "1", text: notes?[indexPath.row].text ?? "")
        } else if realm.isEmpty {
            cell.configure(with: "1", text: "There is no notes added yet. You can click the plus button or this page to add some.")
        }
        configureCell(with: cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if realm.isEmpty {
            let vc = addNoteViewController()
            navigationController?.pushViewController(vc, animated: false)
        } else if !realm.isEmpty {
        let vc = EditNoteViewController()
        vc.index = indexPath.row
        navigationController?.pushViewController(vc, animated: false)
        }
    }
}

