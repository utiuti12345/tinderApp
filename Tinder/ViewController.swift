//
//  ViewController.swift
//  Tinder
//
//  Created by saotome on 2020/04/19.
//  Copyright © 2020 saotome. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var basicCard: UIView!
    @IBOutlet weak var likeImageView: UIImageView!
    
    @IBOutlet weak var person1: UIView!
    @IBOutlet weak var person2: UIView!
    @IBOutlet weak var person3: UIView!
    @IBOutlet weak var person4: UIView!
    
    var centerOfCard:CGPoint!
    var people = [UIView]()
    var selectedCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerOfCard = basicCard.center
        people.append(person1)
        people.append(person2)
        people.append(person3)
        people.append(person4)
    }
    
    func resetCard(){
        likeImageView.image = nil
        likeImageView.alpha = 0
        
        basicCard.center = self.centerOfCard
        basicCard.transform = .identity
    }
    
    @IBAction func swipeCard(_ sender: Any) {
        let card = (sender as! UIPanGestureRecognizer).view!
        let point = (sender as! UIPanGestureRecognizer).translation(in: view)
        card.center = CGPoint(x: card.center.x + point.x, y: card.center.y + point.y)
        people[selectedCount].center = CGPoint(x: card.center.x + point.x, y: card.center.y + point.y)
        
        // 角度を変える
        let xFromCenter = card.center.x - view.center.x
        card.transform = CGAffineTransform(rotationAngle: xFromCenter / (view.frame.width / 2) * -0.785)
        people[selectedCount].transform = CGAffineTransform(rotationAngle: xFromCenter / (view.frame.width / 2) * -0.785)
        
        if xFromCenter > 0 {
            likeImageView.image = UIImage(named: "good")
            likeImageView.alpha = 1
            likeImageView.tintColor = UIColor.red
        } else if xFromCenter < 0 {
            likeImageView.image = UIImage(named: "bad")
            likeImageView.alpha = 1
            likeImageView.tintColor = UIColor.blue
        }
        
        
        if (sender as! UIPanGestureRecognizer).state == UIGestureRecognizer.State.ended {
            
            if card.center.x < 75 {
                // 左に大きくスワイプ
                UIView.animate(withDuration: 0.02) {
                    self.resetCard()
                    self.people[self.selectedCount].center = CGPoint(x:self.people[self.selectedCount].center.x - 300,y:self.people[self.selectedCount].center.y)
                }
                selectedCount += 1
                return
            }else if card.center.x > self.view.frame.width - 75 {
                // 右に大きくスワイプ
                UIView.animate(withDuration: 0.02) {
                    self.resetCard()
                    self.people[self.selectedCount].center = CGPoint(x:self.people[self.selectedCount].center.x + 300,y:self.people[self.selectedCount].center.y)
                }
                selectedCount += 1
                return
            }
            
            // 元に戻る処理
            UIView.animate(withDuration: 0.2, animations: {
                self.resetCard()
                self.people[self.selectedCount].center = self.centerOfCard
                self.people[self.selectedCount].transform = .identity
            })
            self.likeImageView.alpha = 0
        }
    }
    

}

