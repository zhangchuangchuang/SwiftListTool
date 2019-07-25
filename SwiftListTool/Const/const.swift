//
//  const.swift
//  SwiftListTool
//
//  Created by 张闯闯 on 2019/7/25.
//  Copyright © 2019 张闯闯. All rights reserved.
//

import UIKit

//屏幕的宽高
let Screen_width = UIScreen.main.bounds.width
let Screen_Height = UIScreen.main.bounds.height

//RGB 十六进制转换
func UIColorFromRGB(rgbValue:UInt) -> UIColor{
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
