//
//  CollectionLayoutItem.swift
//  mongKit.view
//
//  Created by Michael Ong on 11/2/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//
import Foundation
import UIKit

public protocol CollectionLayoutItem {
  var width   : CollectionLayout.Span
    { get }
  var height  : CollectionLayout.Span
    { get }

  var inset   : UIEdgeInsets
    { get }
}

public struct Item: CollectionLayoutItem {
  public init(width: CollectionLayout.Span, height: CollectionLayout.Span, inset: UIEdgeInsets = .zero) {
    self.width  = width
    self.height = height
    self.inset  = inset
  }
  
  public let width  : CollectionLayout.Span
  public let height : CollectionLayout.Span
  public let inset  : UIEdgeInsets
}
