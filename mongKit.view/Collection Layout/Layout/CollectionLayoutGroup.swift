//
//  CollectionLayoutGroup.swift
//  mongKit.view
//
//  Created by Michael Ong on 11/2/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//
import Foundation
import UIKit

public protocol CollectionLayoutGroup: CollectionLayoutItem {
  
  var spacing   : CGFloat
    { get }

  var direction : CollectionLayout.SpanDirection
    { get }
  var items     : [CollectionLayoutItem]
    { get }
}

public struct HGroup: CollectionLayoutGroup {
  public init(
    width   : CollectionLayout.Span,
    height  : CollectionLayout.Span,
    spacing : CGFloat = 0,
    inset   : UIEdgeInsets = .zero,
    items   : [CollectionLayoutItem]) {
    self.width    = width
    self.height   = height
    self.spacing  = spacing
    self.items    = items
    self.inset    = inset
  }

  public let width      : CollectionLayout.Span
  public let height     : CollectionLayout.Span

  public let spacing    : CGFloat
  public let inset      : UIEdgeInsets

  public let direction  : CollectionLayout.SpanDirection = .horizontal

  public let items      : [CollectionLayoutItem]
}

public struct VGroup: CollectionLayoutGroup {
  public init(
    width   : CollectionLayout.Span,
    height  : CollectionLayout.Span,
    spacing : CGFloat = 0,
    inset   : UIEdgeInsets = .zero,
    items   : [CollectionLayoutItem]) {
    self.width    = width
    self.height   = height
    self.spacing  = spacing
    self.items    = items
    self.inset    = inset
  }

  public let width      : CollectionLayout.Span
  public let height     : CollectionLayout.Span
  
  public let spacing    : CGFloat
  public let inset      : UIEdgeInsets

  public let direction  : CollectionLayout.SpanDirection = .vertical

  public let items      : [CollectionLayoutItem]
}
