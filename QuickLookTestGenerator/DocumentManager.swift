//
//  DocumentManager.swift
//  QuickLookTestGenerator
//
//  Created by Felipe Espinoza Castillo on 27/02/2017.
//  Copyright © 2017 Felipe Espinoza Castillo. All rights reserved.
//

import Cocoa

extension Document: CanvasViewDataSource {
  var drawableElements: [DrawableElement] {
    var elements: [DrawableElement] = []

    elements += concepts.map {
      DrawableConcept(concept: $0 as GraphConcept) as DrawableElement
    }

    elements += links.map {
      DrawableLink(link: $0 as GraphLink) as DrawableElement
    }

    return elements
  }
}


public class DocumentManager: NSObject {
  public var url: URL?
  public var contentTypeUTI: String?

  override public var description: String { return "DocumentManager: url=\(url) uti=\(contentTypeUTI)" }

  public func processDocument(canvasSize: NSSize, context: NSGraphicsContext) {
    guard let url = url, let contentTypeUTI = contentTypeUTI else {
      Swift.print("processDocument bad params :(")
      return
    }

    Swift.print("processDocument \(self.description)")


    do {
      let document: Document = try Document(contentsOf: url, ofType: contentTypeUTI)

      Swift.print("document processed \(document.description)")

      let frame = NSRect(origin: NSPoint(x: 0, y: 0), size: canvasSize)

      let canvasView = CanvasView(frame: frame)

      canvasView.dataSource = document

      canvasView.displayIgnoringOpacity(frame, in: context)
    } catch {
      Swift.print("error :(")
    }
  }
}
