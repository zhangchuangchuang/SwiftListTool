//
//  ZCTableHeardView.swift
//  SwiftListTool
//
//  Created by 张闯闯 on 2019/7/24.
//  Copyright © 2019 张闯闯. All rights reserved.
//

import UIKit

private let KscrollLineH : CGFloat = 2.0
private let kNormalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255,128,0)

// MARK: 定义协议代理
@objc protocol HeardTitleViewDelegate : NSObjectProtocol{
    func heardTitleDelegate(titleView:ZCTableHeardView,selecTedIndex index :Int)
}
// MARK: 定义 类
class ZCTableHeardView: UIView {
    private var currentIndex : Int = 0
    private var titles : [String] = []
    weak var delegate :HeardTitleViewDelegate?
  //懒加载
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    private lazy var titleLabels :[UILabel] = [UILabel]()
    
    private lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    
     init(frame: CGRect,titles:[String]) {
        self.titles = titles

        super.init(frame: frame)
        setUpUI()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: 创建类方法
//extension ZCTableHeardView {
//    
//    class func roomShowHeadView() -> ZCTableHeardView {
//        return Bundle.main.loadNibNamed("ZCTableHeardView", owner: nil, options: nil)?.first as! ZCTableHeardView
//    }
//    
//}

// MARK: 设置类 扩展
extension ZCTableHeardView{
    private func setUpUI(){
        addSubview(scrollView)
        scrollView.frame = bounds

        setUpTitleLables()
        setUpBottomMenuAndScrollerLine()
    }
    //添加title对应的名称
    private func setUpTitleLables(){
        let labelW : CGFloat = frame.width/CGFloat(titles.count)
        let labelH : CGFloat = frame.height - KscrollLineH
        let labelY : CGFloat = 0
        for (index,title) in titles.enumerated() {
            let  label = UILabel()
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(r:kNormalColor.0,g:kNormalColor.1,b:kNormalColor.2)
            label.textAlignment = .center
            
            let labelX :CGFloat = labelW * CGFloat(index)
            
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            scrollView.addSubview(label)
            titleLabels.append(label)
            //添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(tag:)))
            label.addGestureRecognizer(tapGes)
        }
        
        
    }
    //设置底线滚动
    private func setUpBottomMenuAndScrollerLine(){
        //1. 添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = .lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //2. 添加 scrollLine
        //2.1 获取第一个 Label
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
        //2.2 设置 scrollLine 的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - KscrollLineH, width: firstLabel.frame.width, height: KscrollLineH)
    }
    
}
// MARK: 监听 label 点击
extension ZCTableHeardView{
    @objc private func titleLabelClick(tag:UITapGestureRecognizer){
        //处理内部逻辑
        guard let currentLabel = tag.view as?UILabel else {return}
        if currentLabel.tag == currentIndex {return}
        let oldLabel = titleLabels[currentIndex]
        //3. 切换文字的颜色
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        //4. 保存最新 Label 的下标值
        currentIndex = currentLabel.tag
        
        //5. 滚动条位置修改
        let scrollLinePosition = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLinePosition
        }

        // 处理外部逻辑
        //6. 通知代理
//        if self.delegate != nil && (self.delegate?.responds(to: Selector.init(("heardTitleDelegate:"))))!{
              delegate?.heardTitleDelegate(titleView: self, selecTedIndex: currentIndex)
//        }

    }
    
    
}
// MARK: 滑动视图 切换
extension ZCTableHeardView{
    func setTitleWithProgress(progress:CGFloat, sourceIndex:Int,targetIndex:Int){
        //1. 取出 sourceLabel/targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        //2. 处理滑块逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //3. 颜色渐变(复杂)
        //3.1 取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        
        //3.2 变化 sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
        //3.3 变化 targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        //4. 记录最新的 index
        currentIndex = targetIndex
        
        
    }
}
