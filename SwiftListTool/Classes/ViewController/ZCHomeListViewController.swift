//
//  ZCHomeListViewController.swift
//  SwiftListTool
//
//  Created by 张闯闯 on 2019/7/23.
//  Copyright © 2019 张闯闯. All rights reserved.
//

import UIKit
class ZCHomeListViewController: UIViewController {

//    @IBOutlet var bg_collec: ZCTableHeardView!
    
    private lazy var pageTitleView :ZCTableHeardView = {[weak self] in
        
        let titles = ["我不好","你好","嫁给我","娶我"]
        let titeView = ZCTableHeardView(frame:CGRect(x: 0, y: 60, width: Screen_width, height: 60), titles: titles)
        titeView.delegate = self
        return titeView
    }()
    private lazy var pageContentView : ZCPageContentView = {[weak self]in
        let contentH = Screen_Height-120
        let contentFrame = CGRect(x: 0, y: 120, width: Screen_width, height: contentH)
        
        var childVcs = [UIViewController]()
        childVcs.append(ZCFirstViewController())
        childVcs.append(ZCSencondViewController())
        childVcs.append(ZCthiirdViewController())
        childVcs.append(ZCFourViewController())
        
        let pageView = ZCPageContentView(frame: contentFrame, childVcs: childVcs, parentVc: self)
        pageView.delegate = self
        return pageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

}
extension ZCHomeListViewController{
    private func setUpUI(){
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
    }
 
}
extension ZCHomeListViewController :HeardTitleViewDelegate{
    func heardTitleDelegate(titleView: ZCTableHeardView, selecTedIndex index: Int) {
        pageContentView.setContentIndex(currentIndex: index)
    }
    
    
}
extension ZCHomeListViewController:PageContentViewDelegate{
    func pageContentdelegate(contentView: ZCPageContentView, progress: CGFloat, scourIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: scourIndex, targetIndex: targetIndex)
    }
    
}
