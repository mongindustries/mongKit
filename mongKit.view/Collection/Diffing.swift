//
//  Diffing.swift
//  mongKit.view
//
//  Created by Michael Ong on 10/28/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//

import Foundation

internal struct DiffingResult {
  let toRemove: [Int]
  let toInsert: [Int]

  let toReload: [Int]
  let toMove  : [(f: Int, t: Int)]
}

internal func diffData(
  newItems  : [AnyHashable],
  oldItems  : [AnyHashable],
  transform : (AnyHashable) -> AnyHashable?) -> DiffingResult {

  let newSections = newItems
    .compactMap(transform).asSet
  let oldSections = oldItems
    .compactMap(transform).asSet

  assert(newSections.count == newItems.count)
  assert(oldSections.count == oldItems.count)

  // diff by section first

  let toDel   = oldSections.subtracting(newSections)
  let toAdd   = newSections.subtracting(oldSections)

  let toMov   = oldSections.intersection(newSections)

  switch newSections.count - oldSections.count {
  case ...(-1):
    // to delete
    let toRemove = Set<Int>(((oldSections.count - abs(newSections.count - oldSections.count))..<oldSections.count).map { $0 })
    var toReload = Set<Int>()
    var relocate = [(f: Int, t: Int)]()

    zip(toMov.map { oldItems.firstIndex(of: $0)! },
        toMov.map { newItems.firstIndex(of: $0)! })
      .forEach { a, b in
        if a != b {
          toReload.insert(b)
          relocate.append((f: a, t: b))
        }
      }

    toDel
      .map      { oldItems.firstIndex(of: $0)! }
      .forEach  { i in
        if i < oldItems.count {
          toReload.insert(i)
        }
      }

    return DiffingResult(toRemove: toRemove.asArray, toInsert: [], toReload: toReload.asArray, toMove: relocate)

  case 1...:
    // to insert
    let toInsert = Set<Int>((0..<(newSections.count - oldSections.count)).map { offset in oldSections.count + offset })
    var toReload = Set<Int>()
    var relocate = [(f: Int, t: Int)]()

    zip(toMov.map { oldItems.firstIndex(of: $0)! },
        toMov.map { newItems.firstIndex(of: $0)! })
      .forEach  { a, b in
        if a != b {
          toReload.insert(a)
          relocate.append((f: a, t: b))
        }
      }

    toAdd
      .map      { newItems.firstIndex(of: $0)! }
      .forEach  { i in
        if i < oldItems.count {
          toReload.insert(i)
        }
      }

    return DiffingResult(toRemove: [], toInsert: toInsert.asArray, toReload: toReload.asArray, toMove: relocate)

  default: // TODO: Incomplete!

    var relocate = [(f: Int, t: Int)]()

    let toRemove = toDel
      .map        { oldItems.firstIndex(of: $0)! }
    let toInsert = toAdd
      .map        { newItems.firstIndex(of: $0)! }

    zip(toMov.map { oldItems.firstIndex(of: $0)! },
        toMov.map { newItems.firstIndex(of: $0)! })
      .forEach  { a, b in
        if a != b {
          relocate.append((f: a, t: b))
        }
      }

    return DiffingResult(toRemove: toRemove, toInsert: toInsert, toReload: [], toMove: relocate)
  }
}

extension Sequence where Element: Hashable {
  var asSet: Set<Element> {
    Set(self)
  }
}

extension Set {
  var asArray: Array<Element> {
    .init(self)
  }
}
