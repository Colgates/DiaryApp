//
//  EditViewController.swift
//  DiaryApp
//
//  Created by Evgenii Kolgin on 18.11.2020.
//

import UIKit
import RealmSwift

class EditNoteViewController: UIViewController {
    
    let realm = try! Realm()
    
    var notes: Results<UserNotes>?
    
    var index: Int?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "Noteworthy", size: 20)
        return textView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        if let safeIndex = index {
            notes = realm.objects(UserNotes.self)
            imageView.image = UIImage(named: String(notes?[safeIndex].imageName ?? "1"))
            textView.text = notes?[safeIndex].text ?? "nothing"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Edit"
        view.backgroundColor = .systemBackground
        
        let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
        let deleteButton = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(didTapDeleteButton))
        navigationItem.rightBarButtonItems = [saveButton, deleteButton]
        
        textView.delegate = self
        
        view.addSubview(imageView)
        view.addSubview(textView)
    }
    
    @objc private func didTapSaveButton() {
        if textView.text != "" {
            do {
                try realm.write {
                    if let safeIndex = index {
                        self.notes?[safeIndex].text = textView.text
                    }
                }
            } catch {
                print("error")
            }
        } else {
            textView.endEditing(true)
            textView.text = "Type something...I can't save an empty list"
            textView.textColor = .lightGray
            return
        }
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func didTapDeleteButton() {
        
        if let safeIndex = index {
            do {
                try realm.write {
                    realm.delete(notes![safeIndex])
                }
            } catch {
                print("error")
            }
        }
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(x: 20, y: 20, width: view.width - 40, height: view.height / 4)
        textView.frame = CGRect(x: 20, y: imageView.bottom + 30, width: view.width - 40, height: view.height - imageView.height - 30)
    }
}

extension EditNoteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
}
