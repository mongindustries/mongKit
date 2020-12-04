//
//  UIStackView+Style.swift
//  mongKit
//
//  Created by Michael Ong on 9/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//
import UIKit
 

public struct StackMargin: StyleConfiguration {
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

public struct StackFiller<Target: UIView>: StyleConfiguration {
  public typealias Comp = Target

  public let value: Float = 1
  public let axis: Set<NSLayoutConstraint.Axis>

  public init(axis: Set<NSLayoutConstraint.Axis> = [ .horizontal, .vertical ]) {
    self.axis = axis
  }

  public func apply(_ target: Comp) {
    for axis in self.axis {
      target.setContentHuggingPriority(.init(value), for: axis)
    }
  }
}

public struct StackVertical: StyleConfiguration {
  public typealias Comp = UIStackView

  public let value: CGFloat

  public let alignment: UIStackView.Alignment

  public let distribution: UIStackView.Distribution

  public init(
    spacing: CGFloat,
    alignment: UIStackView.Alignment = .leading,
    distribution: UIStackView.Distribution = .fill) {

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

public struct StackHorizontal: StyleConfiguration {
  public typealias Comp = UIStackView

  public let value: CGFloat

  public let alignment: UIStackView.Alignment

  public let distribution: UIStackView.Distribution

  public init(
    spacing: CGFloat,
    alignment: UIStackView.Alignment = .leading,
    distribution: UIStackView.Distribution = .fill) {

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

public struct StackSpacing: ComponentModifier {
    public let value: CGFloat
    
    public init(value: CGFloat) {
        self.value = value
    }
    
    public func apply(_ stack: [Component]) {
        guard let target = stack.compactMap({ $0 as? UIStackView }).last,
              let last = target.arrangedSubviews.last else {
            return
        }

        target.setCustomSpacing(value, after: last)
    }
}
