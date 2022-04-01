//
//  BoardViewController.swift
//  MyWordleGame
//
//  Created by Eslam Ali  on 01/04/2022.
//

import UIKit

protocol BoardViewControllerDataSource : AnyObject {
    var currentGuesses : [[Character?]] {get}
}

class BoardViewController: UIViewController {
    
    //MARK:- Vars
    
    weak var dataSource : BoardViewControllerDataSource?
    
   private let collectionView : UICollectionView  = {
        let layout =  UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 4
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(KeyCollectionViewCell.self, forCellWithReuseIdentifier: KeyCollectionViewCell.identifier)
          
        return collectionView
    }()
    
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

       
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        addCollectionViewConstraints()
       
    }
    
 
    
    func addCollectionViewConstraints(){
        NSLayoutConstraint.activate([
        
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  35),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor,constant: 30),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
        ])
    }
    
    public func reloadData() {
        collectionView.reloadData()
    }
    
    
  

}

extension BoardViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
   
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        dataSource?.currentGuesses.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let guesses = dataSource?.currentGuesses ?? []
        return guesses[section].count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyCollectionViewCell.identifier, for: indexPath) as? KeyCollectionViewCell else {
            fatalError()
        }
        let guesses =  dataSource?.currentGuesses ?? []
        if let letter =  guesses[indexPath.section][indexPath.row] {
            cell.configure(letter: letter)
        }
       
         
        cell.backgroundColor = nil
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.systemGray3.cgColor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     
        let margin : CGFloat = 20
        let size : CGFloat = (collectionView.frame.size.width - margin ) / 5
        
        return  CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top:  2, left: 2, bottom: 2, right: 2)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
    }
    
}
