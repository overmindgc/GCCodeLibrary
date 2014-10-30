//
//  SwiftViewController.swift
//  CodeLibrary
//
//  Created by 辰 宫 on 14/10/30.
//  Copyright (c) 2014年 overmindgc. All rights reserved.
//

import UIKit

class SwiftViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.grayColor()
        // Label
        var label = UILabel(frame: self.view.bounds)
        label.backgroundColor = UIColor.clearColor()
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.systemFontOfSize(36)
        label.text = "Hello, Swift"
        self.view.addSubview(label)
        
        // Button
        var button = UIButton.buttonWithType(UIButtonType.System) as? UIButton
        button!.frame = CGRectMake(110.0, 120.0, 100.0, 50.0)
        button!.backgroundColor = UIColor.blueColor()
        button?.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        button!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
        button?.setTitle("关闭", forState: UIControlState.Normal)
        button?.setTitle("关闭", forState: UIControlState.Highlighted)
        button?.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        button!.tag = 100
        self.view.addSubview(button!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // Button Action
    func buttonAction(sender: UIButton)
    {
        self.dismissViewControllerAnimated(true, completion: nil)

    }

}
