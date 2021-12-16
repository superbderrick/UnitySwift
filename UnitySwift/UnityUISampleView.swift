//
//  UnityUISampleView.swift
//  UnitySwift
//
//  Created by derrick on 2021/12/16.
//

import UIKit

class UnityUISampleView: UIView {

    private var delegate: AppDelegate?
       
       let unloadButton: UIButton = {
           let button = UIButton()
           button.frame = CGRect(x: -30, y: 50, width: 100, height: 60)
           button.setTitleColor(.red, for: .normal)
           button.translatesAutoresizingMaskIntoConstraints = true
           button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
           button.addTarget(self, action: #selector(unloadButtonTouched), for: .primaryActionTriggered)
           return button
       }()
       
       let quitButton: UIButton = {
           let button = UIButton()
           button.frame = CGRect(x: 200, y: 100, width: 100, height: 60)
           button.setTitleColor(.red, for: .normal)
           button.translatesAutoresizingMaskIntoConstraints = true
           button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
           button.backgroundColor = .white
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
           self.backgroundColor = .clear
           
           if let temDelegate =  UIApplication.shared.delegate as? AppDelegate {
               self.delegate = temDelegate
           } else {
               
           }
           
           self.addSubview(unloadButton)
           self.addSubview(quitButton)
           
       }
       
       @objc func unloadButtonTouched(sender: UIButton) {
           if let tempDelegate = self.delegate {
               tempDelegate.unloadButtonTouched(sender)
           } else {
               
           }
           
       }
       
       @objc func quitButtonTouched(sender: UIButton) {
           if let tempDelegate = self.delegate {
               tempDelegate.quitButtonTouched(sender)
           } else {
               
           }
       }
       
       @objc func returnButtonTouched(sender: UIButton) {
           if let tempDelegate = self.delegate {
               tempDelegate.returnUnity()
           } else {
               
           }
       }
       

}
