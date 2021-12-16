//
//  UnityUISampleView.swift
//  UnitySwift
//
//  Created by derrick on 2021/12/16.
//

import UIKit

class UnityUISampleView: UIView {
    
    private var delegate: AppDelegate?
    
    let nativeTitleLable:  UILabel = {
        
        let label = UILabel()
        label.frame = CGRect(x: 300, y: 0, width: 300, height: 60)
        label.text = "Native UI Components"
        return label
    }()
    
    let unloadButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 300, y: 50, width: 100, height: 60)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitle("Unload", for: .normal)
        button.addTarget(self, action: #selector(unloadButtonTouched), for: .primaryActionTriggered)
        return button
    }()
    
    let quitButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 400, y: 50, width: 100, height: 60)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitle("Quit", for: .normal)
        button.addTarget(self, action: #selector(quitButtonTouched), for: .primaryActionTriggered)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        
        if let temDelegate =  UIApplication.shared.delegate as? AppDelegate {
            self.delegate = temDelegate
        } else {
            
        }
        
        self.addSubview(nativeTitleLable)
        self.addSubview(unloadButton)
        self.addSubview(quitButton)
        
    }
    
    @objc func unloadButtonTouched(sender: UIButton) {
        if let delegate = self.delegate {
            delegate.unloadButtonTouched(sender)
        } else {
            
        }
        
    }
    
    @objc func quitButtonTouched(sender: UIButton) {
        if let delegate = self.delegate {
            delegate.quitButtonTouched(sender)
        } else {
            
        }
    }
    
    
}
