//
//  HomeCollectionViewCell.swift
//  DiaryApp
//
//  Created by Evgenii Kolgin on 18.11.2020.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HomeCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let textView: UITextView = {
       let text = UITextView()
        text.font = UIFont(name: "Noteworthy", size: 18)
        text.isSelectable = false
        text.isUserInteractionEnabled = false
        return text
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        contentView.addSubview(imageView)
        contentView.addSubview(textView)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 10, y: 10, width: contentView.width - 20, height: contentView.height / 3)
        textView.frame = CGRect(x: 20, y: imageView.bottom, width: contentView.width - 40, height: contentView.height - imageView.frame.size.height - 10)
    }
    
    public func configure(with name:String, text: String) {
        imageView.image = UIImage(named: name)
        textView.text = text
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textView.text = ""
        imageView.image = nil
    }
}
