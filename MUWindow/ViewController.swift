//
//  ViewController.swift
//  MUWindow
//
//  Created by 潘元荣(外包) on 16/6/16.
//  Copyright © 2016年 潘元荣(外包). All rights reserved.
//huhu
//amimal

import UIKit

class ViewController: UIViewController {

    @IBAction func clickAddAlertView(sender: UIButton) {
        let vc = MUPromtViewController()
        var rect =  CGRectZero
        var type_ = windowType.alertWindow
        let view_type = viewType.alertView
        switch sender.titleLabel!.text {
            case "中间"?:
            rect = CGRectMake(kWidth * 0.5 - 140, 150, 280, kHeight*0.6)
           // view_type = viewType.rightView
            case "底部"?:
            rect = CGRectMake(kWidth * 0.5 - 140, 150, 280, kHeight*0.6)
            type_ = windowType.sheetWindow
            case "上面"?:
            rect = CGRectMake(0, 0, kWidth, kHeight*0.6)
            type_ = windowType.curtainWindow
            case "右侧"?:
            type_ = windowType.drawerWindow
            rect = CGRectMake(20, 0, kWidth-20, kHeight)
            default:
            rect = CGRectMake(kWidth * 0.5 - 140, 150, 280, kHeight*0.6)
            
        }
        let _contentView = MUAlertView.init(frame: rect)
        _contentView._ViewType = view_type
        vc.contentView = _contentView
        setWindowType(type_, rect:rect, controller: vc)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

