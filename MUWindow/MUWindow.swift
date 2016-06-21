//
//  MUWindow.swift
//  MUWindow
//
//  Created by 潘元荣(外包) on 16/6/16.
//  Copyright © 2016年 潘元荣(外包). All rights reserved.
//

import UIKit


public let kWidth = UIScreen.mainScreen().bounds.size.width
public let kHeight = UIScreen.mainScreen().bounds.size.height

public enum windowType {case alertWindow,sheetWindow,curtainWindow,drawerWindow}
public func setWindowType(type : windowType ,rect :CGRect, controller :UIViewController){
    MUWindow.WindowManger._type = type
    MUWindow.WindowManger.rect = rect
    MUWindow.WindowManger.vc = controller
    MUWindow.WindowManger.bottomView.backgroundColor = UIColor.blackColor()
    MUWindow.WindowManger.bottomView.alpha = 0.66
    UIApplication.sharedApplication().keyWindow?.addSubview(MUWindow.WindowManger.bottomView)
    switch type {
    case .alertWindow:
        MUWindow.WindowManger.creatAlertWindow(controller)
    case .curtainWindow:
        MUWindow.WindowManger.creatTopAlertWindow(controller)
    case .drawerWindow:
        MUWindow.WindowManger.creatDrawerWindow(controller)
    case .sheetWindow:
        MUWindow.WindowManger.creatBottomWindow(controller)
    }
}

class MUWindow: NSObject {
   
    static let WindowManger = MUWindow()
    
    var _type = windowType?()
   private var window = UIWindow()
   private var rect = CGRect()
   private  var vc = UIViewController()
   private let bottomView = UIView.init(frame: UIScreen.mainScreen().bounds)
    private override init() {
        
    }
    
    private func creatAlertWindow(controller :UIViewController){
        window.frame = rect
        vc.view.frame = rect
        animateWindow(0.0)
    }
    private func creatTopAlertWindow(controller:UIViewController){
        window.frame = CGRectMake(rect.origin.x, -rect.size.height, rect.size.width, rect.size.height)
        vc.view.frame = window.bounds
        animateWindow(1.2)
    }
    private func creatBottomWindow(controller:UIViewController){
       window.frame = CGRectMake(rect.origin.x, rect.size.height + kHeight, rect.size.width, rect.size.height)
        vc.view.frame = window.frame
        animateWindow(1.2)
    }
    private func creatDrawerWindow(controller :UIViewController){
       window.frame = CGRectMake(kWidth + rect.size.width, rect.origin.y, rect.size.width, rect.size.height)
       vc.view.frame = window.frame
       animateWindow(1.2)
    }
    private func animateWindow(time :CGFloat){
        window.rootViewController = vc
        window.hidden = false
        window.clipsToBounds = true
        window.alpha = 0.95
        window.layer.cornerRadius = 10
        window.backgroundColor = UIColor.whiteColor()
       UIView.animateWithDuration(NSTimeInterval.init(time)) { () -> Void in
            self.window.frame = self.rect
        }
    }
   
  
    private static func destroy(){
      MUWindow.WindowManger.window.rootViewController?.view.removeFromSuperview()
      MUWindow.WindowManger.window.removeFromSuperview()
      MUWindow.WindowManger.window.hidden = true
      MUWindow.WindowManger.bottomView.removeFromSuperview()
    }
  static  func setWindowFinishBlock(block:() -> Void){
        block()
      let type = MUWindow.WindowManger._type!
      var frame = MUWindow.WindowManger.window.frame
    switch type{
    case .alertWindow:
        UIView.animateWithDuration(NSTimeInterval.init(1.5), animations: { () -> Void in
            frame.size.width = 0
            frame.size.height = 0
            frame.origin.x = kWidth * 0.5
            frame.origin.y = kHeight * 0.5
            MUWindow.WindowManger.window.frame = frame
            }, completion: { (bool :Bool) -> Void in
              destroy()
        })
    case .curtainWindow:
        UIView.animateWithDuration(NSTimeInterval.init(1.5), animations: { () -> Void in
            frame.origin.y = -MUWindow.WindowManger.rect.size.height
            MUWindow.WindowManger.window.frame = frame
            }, completion: { (bool :Bool) -> Void in
                destroy()
        })
    case .drawerWindow:
        UIView.animateWithDuration(NSTimeInterval.init(1.5), animations: { () -> Void in
            frame.origin.x = kWidth
            MUWindow.WindowManger.window.frame = frame
            }, completion: { (bool :Bool) -> Void in
                destroy()
        })
    case .sheetWindow:
        UIView.animateWithDuration(NSTimeInterval.init(1.5), animations: { () -> Void in
            frame.origin.y = kHeight
            MUWindow.WindowManger.window.frame = frame
            }, completion: { (bool:Bool) -> Void in
                destroy()
        })
    }
}
}

