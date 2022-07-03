//
//  TodoTaskModel.swift
//  HeeTothedo
//
//  Created by 곽희상 on 2022/06/27.
//

import Foundation
import RealmSwift

class todoTask: Object{
    
    @Persisted dynamic var title: String
    @Persisted dynamic var done: Bool = false
    
    convenience init(title: String, done: Bool = false) {
          self.init()
          self.title = title
          self.done = done
      }
}

