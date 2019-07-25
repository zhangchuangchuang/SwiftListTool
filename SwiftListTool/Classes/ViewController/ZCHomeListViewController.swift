//
//  ZCHomeListViewController.swift
//  SwiftListTool
//
//  Created by 张闯闯 on 2019/7/23.
//  Copyright © 2019 张闯闯. All rights reserved.
//

import UIKit
class ZCHomeListViewController: UIViewController {

    @IBOutlet var bg_collec: ZCTableHeardView!
    
    private lazy var pageTitleView :ZCTableHeardView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60)
        
        let titles = ["我不好","你好","嫁给我","娶我"]
        let titeView = ZCTableHeardView(frame:titleFrame, titles: titles)
        titeView.delegate = self
        return titeView
    }()
//    private lazy var pageContentView : ZCPageContentView = {[weak self]in
//        let <#name#> = <#value#>
//        
//        
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

}
extension ZCHomeListViewController{
    private func setUpUI(){
        view.addSubview(pageTitleView)
    }
 
}
extension ZCHomeListViewController :HeardTitleViewDelegate{
    func heardTitleDelegate(titleView: ZCTableHeardView, selecTedIndex index: Int) {
        <#code#>
    }
    
    
}
