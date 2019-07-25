//
//  ViewController.swift
//  SwiftListTool
//
//  Created by 张闯闯 on 2019/7/23.
//  Copyright © 2019 张闯闯. All rights reserved.
//

import UIKit
private let Screen_Widht :CGFloat = UIScreen.main.bounds.width
private let Screen_Hieht :CGFloat = UIScreen.main.bounds.height
class ViewController: UIViewController {
    lazy var popButton : UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: Screen_Widht/2, y: Screen_Hieht/2, width: 100, height: 40)
        button.backgroundColor = UIColor.yellow
        button.setTitle("点击跳转", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(UIColor.red, for: .normal)
        
        button.addTarget(self, action: #selector(popActionClick(button:)), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setUpUI()
    }


}
extension ViewController{
    func setUpUI(){
      view.addSubview(popButton)
    }
    @objc func popActionClick(button:UIButton){
        print("点击跳转")
        let VC = ZCHomeListViewController()
//        let navi = UINavigationController(rootViewController: VC)
//        self.navigationController?.pushViewController(navi, animated:true)
        self.present(VC, animated: true, completion: nil)
    }
}
