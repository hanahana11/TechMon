//
//  Character.swift
//  TechMon
//
//  Created by 末利　花 on 2018/02/17.
//  Copyright © 2018年 末利　花. All rights reserved.
//

import UIKit

class Character: UIViewController {

    var name: String = ""
    var image: UIImage!
    var attackPoint: Int = 30
    
    var currentHP: Int = 100
    var currentTP: Int = 0
    var currentMP: Int = 0
    
    var maxHP: Int = 100
    var maxTP: Int = 20
    var maxMP: Int = 20
    
    init(name: String, imageName: String, attackPoint: Int, maxHP: Int, maxMP: Int) {
        
        self.name = name
        self.image = UIImage(named: imageName)
        self.attackPoint = attackPoint
        self.maxHP = maxHP
        self.currentHP = maxHP
        self.maxTP = maxTP
        self.maxMP = maxMP
    }
    
    func resetStatus() {
        
        currentHP = maxHP
        currentTP = 0
        currentMP = 0
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
