//
//  UIStackView+Style.swift
//  mongKit
//
//  Created by Michael Ong on 9/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public struct SpacerStack<Target: UIView>: StyleConfiguration {
  public typealias Comp = Target

  public let value: Float = 1
  public let axis: Set<NSLayoutConstraint.Axis>

  public init(axis: Set<NSLayoutConstraint.Axis> = [.horizontal, .vertical]) {
    self.axis = axis
  }

  public func apply(_ target: Comp) {
    for axis in self.axis {
      target.setContentHuggingPriority(.init(value), for: axis)
    }
  }
}

public struct VerticalStack: StyleConfiguration {
  public typealias Comp = UIStackView

  public let value: CGFloat

  public let alignment: UIStackView.Alignment

  public let distribution: UIStackView.Distribution

  public init(spacing: CGFloat, alignment: UIStackView.Alignment = .leading, distribution: UIStackView.Distribution = .fill) {
    value = spacing
    self.alignment = alignment
    self.distribution = distribution
  }

  public func apply(_ target: UIStackView) {
    target.axis = .vertical

    target.spacing = value
    target.alignment = alignment
    target.distribution = distribution
  }
}

public struct HorizontalStack: StyleConfiguration {
  public typealias Comp = UIStackView

  public let value: CGFloat

  public let alignment: UIStackView.Alignment

  public let distribution: UIStackView.Distribution

  public init(spacing: CGFloat, alignment: UIStackView.Alignment = .leading, distribution: UIStackView.Distribution = .fill) {
    value = spacing
    self.alignment = alignment
    self.distribution = distribution
  }

  public func apply(_ target: UIStackView) {
    target.axis = .horizontal

    target.spacing = value
    target.alignment = alignment
    target.distribution = distribution
  }
}

public struct LayoutMarginStack: StyleConfiguration {
  public typealias Comp = UIStackView

  public let value: UIEdgeInsets

  public init(value: UIEdgeInsets) {
    self.value = value
  }

  public func apply(_ target: UIStackView) {
    target.layoutMargins = value
    target.isLayoutMarginsRelativeArrangement = true
  }
}
