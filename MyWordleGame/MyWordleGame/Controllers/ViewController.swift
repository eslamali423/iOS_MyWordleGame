//
//  ViewController.swift
//  MyWordleGame
//
//  Created by Eslam Ali  on 01/04/2022.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK:- Vars
    let answer = "after"
  private  var guesses : [[Character?]] = Array(repeating: Array(repeating: nil, count: 5 ), count: 6)

    
    let keyboardVC = KeyboardViewController()
    let boardVC = BoardViewController()
    
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
   
        addChildren()
        
    } 
    
    // add our two view controllers (keyboard, board) to the home view
    func addChildren() {
  
        // add keyboard
         addChild(keyboardVC)
        keyboardVC.didMove(toParent: self)
        keyboardVC.delegate = self
        keyboardVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(keyboardVC.view)
       
        // add board game
        addChild(boardVC)
        boardVC.didMove(toParent: self)
        boardVC.dataSource = self
        boardVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(boardVC.view)
       
      
        addConstrains()
        
    }
    
    // set the constrains to our two view controllers (keyboard, board)
   func addConstrains() {
    
    NSLayoutConstraint.activate([
    
        boardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        boardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        boardVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        boardVC.view.bottomAnchor.constraint(equalTo: keyboardVC.view.topAnchor),
        boardVC.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
        
        keyboardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        keyboardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        keyboardVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    
    
    ])
        
    
    
    
    }
    
}

extension ViewController : KeyboardViewControllerDelegate {
    func keyboardViewController(_ vc: KeyboardViewController, didTapKey letter: Character) {

        // update guesses
        var stop = false
        for i in 0..<guesses.count {
            for j in 0..<guesses[i].count{
                if guesses[i][j] == nil{
                    guesses[i][j] = letter
                    stop = true
                    break
                }
                
            }
            if stop {
                break
            } 
        }
        
        
        // reload data
        boardVC.reloadData()
        
        
    }
 
}

extension ViewController : BoardViewControllerDataSource {
    var currentGuesses: [[Character?]] {
        return guesses
    }
    
    func boxColor (indexpath : IndexPath) -> UIColor? {
       
        let indexedAnswer = Array(answer)

        let rowIndex = indexpath.section
        let count = guesses[rowIndex].compactMap({$0}).count
        guard count == 5  else {
            return nil
        }
      

        
        guard let letter  =  guesses[indexpath.section][indexpath.row],
              indexedAnswer.contains(letter) else {
            return nil
        }

        if indexedAnswer[indexpath.row] == letter {
            return .systemGreen
        }
        
        return .systemOrange
    }
    
 
}

