//
//  ViewController.swift
//  shakeDemo
//
//  Created by 卢良潇 on 16/3/23.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    //上图
    @IBOutlet weak var rockupImage: UIImageView!
    //下图
    @IBOutlet weak var rockdownImage: UIImageView!
    
    var player: AVAudioPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
        
        /**
        开启摇动感应
        */
        UIApplication.sharedApplication().applicationSupportsShakeToEdit = true
        becomeFirstResponder()
        
        
    }

 

    /**
     开始摇动
     */
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
        
        print("开始摇动")
        
        //开始动画
        UIView.animateKeyframesWithDuration(0.5, delay: 0, options: UIViewKeyframeAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
            
            self.rockupImage.frame.origin.y -= 80
            self.rockdownImage.frame.origin.y += 80
            
            }, completion: nil)
        /// 设置音效
        let path1 = NSBundle.mainBundle().pathForResource("rock", ofType:"mp3")
        let data1 = NSData(contentsOfFile: path1!)
        self.player = try? AVAudioPlayer(data: data1!)
        self.player?.delegate = self
        self.player?.updateMeters()//更新数据
        self.player?.prepareToPlay()//准备数据
        self.player?.play()
        
        //结束动画
        UIView.animateKeyframesWithDuration(0.5, delay: 1.0, options: UIViewKeyframeAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
            
            self.rockupImage.frame.origin.y += 80
            self.rockdownImage.frame.origin.y -= 80
            
            }, completion: nil)
        
    }
    
    /**
     取消摇动
     */
    override func motionCancelled(motion: UIEventSubtype, withEvent event: UIEvent?) {
        
        print("取消摇动")
     
    }
    
    
    /**
     摇动结束
     
     */
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        
        print("摇动结束")
        ///此处设置摇一摇需要实现的功能
       
        
        /// 设置音效
        let path = NSBundle.mainBundle().pathForResource("rock_end", ofType:"mp3")
        let data = NSData(contentsOfFile: path!)
        self.player = try? AVAudioPlayer(data: data!)
        self.player?.delegate = self
        self.player?.updateMeters()//更新数据
        self.player?.prepareToPlay()//准备数据
        self.player?.play()
    }
}

