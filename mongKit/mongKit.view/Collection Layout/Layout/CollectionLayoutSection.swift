//
//  CollectionLayoutSection.swift
//  mongKit.view
//
//  Created by Michael Ong on 11/2/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//

import UIKit

public struct CollectionLayoutSection {
  public init(
    direction             : CollectionLayout.SpanDirection,
    inset                 : UIEdgeInsets = .zero,
    scrollCharacteristic  : CollectionLayout.SpanScrollCharacteristic = .none,
    supplements           : [CollectionLayoutSupplement] = [],
    supplementInsetBias   : NSLayoutConstraint.Axis = .vertical,
    group                 : [CollectionLayoutGroup]) {

    self.direction = direction
    self.scrollCharacteristic = scrollCharacteristic
    self.supplements = supplements
    self.supplementInsetBias = supplementInsetBias
    self.inset = inset
    self.group = group
  }

  public let direction            : CollectionLayout.SpanDirection
  public let inset                : UIEdgeInsets
  public let scrollCharacteristic : CollectionLayout.SpanScrollCharacteristic

  public let supplements          : [CollectionLayoutSupplement]
  public let supplementInsetBias  : NSLayoutConstraint.Axis

  public let group                : [CollectionLayoutGroup]
}
