//
//  wordViewModel.swift
//  Ortho-Graphos
//
//  Created by David Perez on 1/24/19.
//  Copyright © 2019 David Perez P. All rights reserved.
//

import UIKit

class wordViewModel: UIView {
    
    let label: UILabel = {
        let l = UILabel()
        l.font = UIFont(name: "Helvetica", size: 40)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let backButton: UIButton = {
        let b = UIButton(type: UIButton.ButtonType.system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Back", for: UIControl.State.normal)
       
        return b
    }()
    
    let falseButton: UIButton = {
        let b = UIButton(type: UIButton.ButtonType.system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("False", for: UIControl.State.normal)
        
        return b
    }()
    
    let trueButton: UIButton = {
        let b = UIButton(type: UIButton.ButtonType.system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("True", for: UIControl.State.normal)
        
        return b
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightGray
        layer.borderWidth = 4
        layer.cornerRadius = 5
        layer.borderColor = UIColor.black.cgColor
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

   fileprivate func setupViews(){
        self.addSubview(label)
        self.addSubview(backButton)
        self.addSubview(falseButton)
        self.addSubview(trueButton)

        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        label.widthAnchor.constraint(equalToConstant: self.frame.height/5).isActive = true
        
        backButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        backButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        falseButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20 ).isActive = true
        falseButton.widthAnchor.constraint(equalToConstant: self.bounds.width/2).isActive = true
        falseButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        falseButton.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        
        trueButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20 ).isActive = true
        trueButton.widthAnchor.constraint(equalToConstant: self.bounds.width/2).isActive = true
        trueButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        trueButton.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
    }
}
