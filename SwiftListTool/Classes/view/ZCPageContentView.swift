//
//  ZCPageContentView.swift
//  SwiftListTool
//
//  Created by 张闯闯 on 2019/7/24.
//  Copyright © 2019 张闯闯. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate:NSObjectProtocol {
    func pageContentdelegate(contentView:ZCPageContentView, progress:CGFloat,scourIndex:Int,targetIndex:Int)
}
private let contentCellID = "contentCellID"
class ZCPageContentView: UIView {

    
    private var childVcs :[UIViewController] = [UIViewController]()
    private weak var parentViewController :UIViewController?
    private var starOffsetX : CGFloat = 0.0
    weak var delegate:PageContentViewDelegate?
    private var isForbidScrollDelegate : Bool = false
    
    private lazy var collectionView : UICollectionView = {[weak self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
       return collectionView
    }()
     init(frame: CGRect,childVcs:[UIViewController],parentVc:UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentVc
        super.init(frame:frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ZCPageContentView{
    private func setUpUI(){
        
    }
}

//MARK: UICollectionViewDataSource 协议
extension ZCPageContentView :UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellID, for: indexPath)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.row]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
         return childVcs.count
    }
}
//MARK: UICollectionViewDelegate 协议
extension ZCPageContentView :UICollectionViewDelegate{
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false
        
        starOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //0. 判断是否是点击事件
        if isForbidScrollDelegate { return }
        
        //1. 定义获取需要的数据
        var progress : CGFloat = 0.0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        //2. 判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.frame.width
        if currentOffsetX > starOffsetX { // 左滑
            
            //2.1 计算 progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            //2.2 计算 sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            //2.3 计算 targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            //2.4 如果完全滑过去
            if currentOffsetX - starOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
            
        } else { // 右滑
            
            //2.1 计算 progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            //2.2 计算 targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            //2.3 计算 sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
            
        }
        
        //3. 将 progress/sourceIndex/targetIndex 传递给 titleView
        delegate?.pageContentdelegate(contentView: self, progress: progress, scourIndex: sourceIndex, targetIndex: targetIndex)
        
    }
}
// MARK: 对外暴露的方法
extension ZCPageContentView {
    
    func setContentIndex(currentIndex: Int) {
        
        //1. 记录需要禁止进行代理方法
        isForbidScrollDelegate = true
        
        //2. 滚动到正确的位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
    
}
