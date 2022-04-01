//
//  KeyboardViewController.swift
//  MyWordleGame
//
//  Created by Eslam Ali  on 01/04/2022.
//

import UIKit


protocol KeyboardViewControllerDelegate : AnyObject {
    func keyboardViewController ( _ vc  : KeyboardViewController, didTapKey letter: Character)
}

class KeyboardViewController: UIViewController {

    //MARK:- Vars
    
    weak var delegate : KeyboardViewControllerDelegate?
    
    let letters = ["qwertyuiop","asdfghjkl","zxcvbnm"]
    private var keys : [[Character]] = []
    
    let collectionView : UICollectionView  = {
        let layout =  UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 2
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
        fillKeys()
    }
    
    func fillKeys()  {
        for row in letters {
            let chars =  Array(row)
            keys.append(chars)
        }
    }
    
    func addCollectionViewConstraints(){
        NSLayoutConstraint.activate([
        
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor,constant: 30),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
        ])
    }
    
    
  

}

extension KeyboardViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
   
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        keys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        keys[section].count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyCollectionViewCell.identifier, for: indexPath) as! KeyCollectionViewCell
        let letters = keys[indexPath.section][indexPath.row]
        cell.configure(letter: letters )
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     
        let margin : CGFloat = 20
        let size : CGFloat = (collectionView.frame.size.width - margin ) / 10
        
        return  CGSize(width: size, height: size*1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      
//        var left  : CGFloat = 1
//        var right  : CGFloat = 1
        
        let margin : CGFloat = 20
        let size : CGFloat = (collectionView.frame.size.width - margin ) / 10
        
        let count : CGFloat = CGFloat( collectionView.numberOfItems(inSection: section))
        
        let inset : CGFloat = (collectionView.frame.size.width - ( size * count ) - (2 * count)) / 2
        
        let left  : CGFloat = inset
        let right  : CGFloat = inset
        
        return UIEdgeInsets(top:  2, left: left, bottom: 2, right: right)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let letter = keys[indexPath.section][indexPath.row]
        delegate?.keyboardViewController(self, didTapKey: letter)
        
        
    }
    
}
