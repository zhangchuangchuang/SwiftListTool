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

class ZCPageContentView: UIView {

    
    private var childVcs :[UIViewController] = [UIViewController]()
    private weak var parentViewController :UIViewController?
    
    weak var delegate:PageContentViewDelegate?
    

}
