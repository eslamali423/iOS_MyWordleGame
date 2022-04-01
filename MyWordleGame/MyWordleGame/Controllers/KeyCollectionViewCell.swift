//
//  KeyCollectionViewCell.swift
//  MyWordleGame
//
//  Created by Eslam Ali  on 01/04/2022.
//

import UIKit

class KeyCollectionViewCell: UICollectionViewCell {
    
    
    static let identifier = "KeyCollectionViewCell"
    
    let label : UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints =  false
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .medium)
        return label
    }()
    
    
    
    override init(frame: CGRect ) {
        super.init(frame: frame)
        
        backgroundColor = .systemGray5
        
        contentView.addSubview(label)
        contentView.layer.cornerRadius = 40
        addLabelConstaraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
    
    
    func addLabelConstaraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        
        ])
    }
    
    
    
    func configure (letter : Character) {
        label.text = String(letter).uppercased()
    }
    
    
    
}
