//
//  UIColor-Catergory.swift
//  SwiftListTool
//
//  Created by 张闯闯 on 2019/7/24.
//  Copyright © 2019 张闯闯. All rights reserved.
//

import UIKit

extension UIColor{
    convenience init(r: CGFloat,g: CGFloat,b: CGFloat){
         self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
    
}
