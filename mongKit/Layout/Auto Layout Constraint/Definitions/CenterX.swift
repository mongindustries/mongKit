//
//  CenterX.swift
//  mongKit
//
//  Created by Michael Ong on 23/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public struct CenterX: Constraint, HorizontalConstraintConstructible {
  
  public let constraint: (UIView) -> [NSLayoutConstraint]
  
  public init(@ConstraintModifierBuilder _ builder : () -> ConstraintModifier = { EmptyConstraintModifier() }) {
    
    let modifiers = builder()
    
    constraint = { target in
      [ tell(target.centerXAnchor.constraint(equalTo: target.superview!.centerXAnchor)) {
          modifiers.apply(target: CenterX.self, $0) } ] }
  }
  
  public init(equalTo      anchor                  : @autoclosure @escaping () -> HorizontalConstraint,
              @ConstraintModifierBuilder _ builder : () -> ConstraintModifier = { EmptyConstraintModifier() }) {
    
    let modifiers = builder()
    
    constraint = { target in
      [ tell(generateEqualConstraint(for: target, \.centerXAnchor, \.centerXAnchor, to: anchor())) {
          modifiers.apply(target: CenterX.self, $0) } ] }
  }
  
  public init(greaterThan  anchor                  : @autoclosure @escaping () -> HorizontalConstraint,
              multiplier                           : CGFloat,
              @ConstraintModifierBuilder _ builder : () -> ConstraintModifier = { EmptyConstraintModifier() }) {
    
    let modifiers = builder()
    
    constraint = { target in
      [ tell(generateGreaterConstraint(for: target, \.centerXAnchor, \.centerXAnchor, to: anchor(), multiplier: multiplier)) {
          modifiers.apply(target: CenterX.self, $0) } ] }
  }
  
  public init(lessThan     anchor                  : @autoclosure @escaping () -> HorizontalConstraint,
              multiplier                           : CGFloat,
              @ConstraintModifierBuilder _ builder : () -> ConstraintModifier = { EmptyConstraintModifier() }) {
    
    let modifiers = builder()
    
    constraint = { target in
      [ tell(generateLesserConstraint(for: target, \.centerXAnchor, \.centerXAnchor, to: anchor(), multiplier: multiplier)) {
          modifiers.apply(target: CenterX.self, $0) } ]
    }
  }
}
