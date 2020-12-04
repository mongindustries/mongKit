//
//  Component-Modifier.swift
//  
//
//  Created by Michael Ong on 11/11/20.
//
public protocol ComponentModifier: Component {
  func apply(_ stack: [Component])
}
