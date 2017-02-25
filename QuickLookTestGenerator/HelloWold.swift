//
//  HelloWold.swift
//  QuickLookTestGenerator
//
//  Created by Felipe Espinoza Castillo on 25/02/2017.
//  Copyright © 2017 Felipe Espinoza Castillo. All rights reserved.
//

import Foundation

public class HelloWorld: NSObject {
  let person: String = "Felipe"

  public func sayHello() -> String {
    Swift.print("\(person): hello world!")
    return "\(person): hello world!"
  }
}
