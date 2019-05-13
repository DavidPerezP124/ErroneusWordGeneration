//
//  NodeModel.swift
//  Ortho-Graphos
//
//  Created by David Perez on 1/24/19.
//  Copyright © 2019 David Perez P. All rights reserved.
//

import Foundation

class NodeModel {
    
    let value: String
    
    let next: NodeModel?
    
    init(value: String, next: NodeModel) {
        self.value = value
        self.next = next
    }
    
}
