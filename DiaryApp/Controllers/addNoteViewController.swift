//
//  EditViewController.swift
//  DiaryApp
//
//  Created by Evgenii Kolgin on 18.11.2020.
//

import UIKit
import RealmSwift

class addNoteViewController: UIViewController {
    
    let realm = try! Realm()
    
    let randomImage = String(Int.random(in: 1..<8))
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "Noteworthy", size: 20)
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add"
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
        
        imageView.image = UIImage(named: randomImage)
        
        textView.text = "Type something...How was your day?"
        textView.textColor = .lightGray
        textView.delegate = self
        
        view.addSubview(imageView)
        view.addSubview(textView)
    }
    
    @objc private func didTapSaveButton() {
        let notes = UserNotes()
        notes.text = textView.text
        notes.imageName = randomImage
        if textView.text != "" {
            do {
                try realm.write {
                    realm.add(notes)
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(x: 20, y: 20, width: view.width - 40, height: view.height / 4)
        textView.frame = CGRect(x: 20, y: imageView.bottom + 30, width: view.width - 40, height: view.height - imageView.height - 30)
    }
}

extension addNoteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
}
