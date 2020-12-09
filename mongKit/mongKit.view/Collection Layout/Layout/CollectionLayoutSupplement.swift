//
//  CollectionLayoutSupplement.swift
//  mongKit.view
//
//  Created by Michael Ong on 11/29/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//

import Foundation
import UIKit

public struct CollectionLayoutSupplement {
  
  public static var floating: CGFloat = .nan
  
  public init(identifier: String,
              frame: UIEdgeInsets = .init(top: 0, sides: 0, bottom: CollectionLayoutSupplement.floating),
              fixedToSectionBounds: Bool = true) {
    self.identifier = identifier
    self.frame = frame
    self.fixedToSectionBounds = fixedToSectionBounds
  }

  public let identifier           : String
  /// The frame that is relative to the overall section bounds
  /// Specify CollectionLayoutSupplement.floating on an edge to mark it as floating.
  public let frame                : UIEdgeInsets
  /// Fix the frame along the section bounds when scrolling around the root scroll direction.
  public let fixedToSectionBounds : Bool
}
