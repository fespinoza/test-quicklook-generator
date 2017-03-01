//
//  Document.swift
//  LinkedIdeas
//
//  Created by Felipe Espinoza Castillo on 02/11/15.
//  Copyright © 2015 Felipe Espinoza Dev. All rights reserved.
//

import Cocoa

public class Document: NSDocument {
  var documentData = DocumentData()

  var concepts: [Concept] = [Concept]()
  var links: [Link] = [Link]()

  private var KVOContext: Int = 0

  override public class func autosavesInPlace() -> Bool {
    return true
  }


  override public var description: String {
    return "concepts: \(concepts.count) - links: \(links.count)"
  }

  override public func data(ofType typeName: String) throws -> Data {
    documentData.writeConcepts = concepts
    documentData.writeLinks = links
    Swift.print("write data!")
    return NSKeyedArchiver.archivedData(withRootObject: documentData)
  }

  override public func read(from data: Data, ofType typeName: String) throws {
    Swift.print("Document: -read")
    guard let documentData = NSKeyedUnarchiver.unarchiveObject(with: data) as? DocumentData else {
      return
    }
    self.documentData = documentData
    if let readConcepts = documentData.readConcepts {
      concepts = readConcepts
    }
    if let readLinks = documentData.readLinks {
      links = readLinks
    }
  }
}
