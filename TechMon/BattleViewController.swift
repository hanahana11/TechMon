//
//  BattleViewController.swift
//  TechMon
//
//  Created by 末利　花 on 2018/02/03.
//  Copyright © 2018年 末利　花. All rights reserved.
//

import UIKit

class BattleViewController: UIViewController {

    @IBOutlet var playerNameLabel: UILabel!
    @IBOutlet var playerImageView: UIImageView!
    @IBOutlet var playerHPLabel: UILabel!
    @IBOutlet var playerMPLabel: UILabel!
    @IBOutlet var playerTPLabel: UILabel!
    
    @IBOutlet var enemyNameLabel: UILabel!
    @IBOutlet var enemyImageView: UIImageView!
    @IBOutlet var enemyHPLabel: UILabel!
    @IBOutlet var enemyMPLabel: UILabel!
    
    let techMonManager = TechMonManager.shared
    
    var player: Character!
    var enemy: Character!
    
    var playerHP = 300
    var playerMP = 0
    var enemyHP = 200
    var enemyMP = 0
    
    var gameTimer: Timer!
    var isPlayerAttackAvailable: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        player = techMonManager.player
        enemy = techMonManager.enemy
        
        playerNameLabel.text = "勇者"
        playerImageView.image = UIImage(named: "yusya.png")
        playerHPLabel.text = "\(enemyHP) / 100"
        playerMPLabel.text = "\(enemyMP) / 20"
        
        enemyNameLabel.text = "龍"
        enemyImageView.image = UIImage(named: "monster.png")
        enemyHPLabel.text = "\(enemyHP) / 200"
        enemyMPLabel.text = "\(enemyMP) / 35"
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self,
                                         selector: #selector(updateGame), userInfo: nil, repeats: true)
        gameTimer.fire()
        // Do any additional setup after loading the view.
    }

    func updateUI() {
        
        playerHPLabel.text = "\(player.currentHP) / \(player.maxHP)"
        playerMPLabel.text = "\(player.currentMP) / \(player.maxMP)"
        playerTPLabel.text = "\(player.currentTP) / \(player.maxTP)"
        
        enemyHPLabel.text = "\(enemy.currentHP) / \(enemy.maxHP)"
        enemyMPLabel.text = "\(enemy.currentMP) / \(enemy.maxMP)"
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        techMonManager.playBGM(fileName: "BGM_battle001")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        techMonManager.stopBGM()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func updateGame() {
        playerMP += 1
        if playerMP >= 20 {
            
            isPlayerAttackAvailable = true
            playerMP = 20
        }else{
            
            isPlayerAttackAvailable = false
            
        }
    
        enemyMP += 1
        if enemyMP >= 35 {
            
            enemyAttack()
            enemyMP = 0
            
        }
    
        playerMPLabel.text = "\(playerMP) / 20"
        enemyMPLabel.text = "\(enemyMP) / 35"
    
    }

    func judgeBattle() {
        
        if player.currentHP <= 0{
        
            finishBattle(vanishImageView: playerImageView, isPlayerwin: false)
        } else if enemy.currentHP <= 0{
        
            finishBattle(vanishImageView: enemyImageView, isPlayerwin: true)
        }
    }
    func enemyAttack() {
        
        techMonManager.damageAnimation(imageView: playerImageView)
        techMonManager.playSE(fileName: "SE_attack")
        
        playerHP -= 20
        
        playerHPLabel.text = "\(playerHP) / 100"
       
        if playerHP <= 0 {
            
            finishBattle(vanishImageView: playerImageView, isPlayerwin: false)
        }
    }
    
    func finishBattle(vanishImageView: UIImageView, isPlayerwin: Bool){
        
        techMonManager.vanishAnimation(imageView: vanishImageView)
        techMonManager.stopBGM()
        gameTimer.invalidate()
        isPlayerAttackAvailable = false
        
        var finishMessage: String = ""
        if isPlayerwin {
            
            techMonManager.playSE(fileName: "SE_fanfare")
            finishMessage = "勇者の勝利！！"
            
        } else {
            
            techMonManager.playSE(fileName: "SE_gameover")
            finishMessage = "勇者の敗北…"
        }
        
        let alert = UIAlertController(title: "バトル終了", message: finishMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
    
        self.dismiss(animated: true, completion: nil)
        
        }));
    present(alert, animated: true, completion: nil)
    
    }
    
    @IBAction func attackAction() {
        
        if isPlayerAttackAvailable {
            
            techMonManager.damageAnimation(imageView: enemyImageView)
            techMonManager.playSE(fileName: "SE_attack")
            
            enemy.currentHP -= player.attackPoint
            
            player.currentTP += 10
            if player.currentTP >= player.maxTP {
                
                player.currentTP = player.maxTP
                
            }
            player.currentMP = 0
            
            judgeBattle()
            
    }
 
}

    @IBAction func fireAction() {
        
        if isPlayerAttackAvailable && player.currentTP >= 40 {
            
            techMonManager.damageAnimation(imageView: enemyImageView)
            techMonManager.playSE(fileName: "SE_fire")
            
            enemy.currentHP -= 100
            
            player.currentTP -= 40
            if player.currentTP <= 0 {
                
                player.currentTP = 0
            }
            player.currentMP = 0
            
            judgeBattle()
        }
    }

    @IBAction func tameruAction() {
        
        if isPlayerAttackAvailable {
            
            techMonManager.playSE(fileName: "SE_charge")
            player.currentTP += 40
            if player.currentTP >= player.maxTP {
                
                player.currentTP = player.maxTP
            }
            player.currentMP = 0
        }
    }





}

