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

  let newSet = newItems
    .compactMap(transform).asSet
  let oldSet = oldItems
    .compactMap(transform).asSet

  assert(newSet.count == newItems.count)
  assert(oldSet.count == oldItems.count)

  // diff by section first

  let toDel = oldSet.subtracting(newSet)
  let toAdd = newSet.subtracting(oldSet)

  let toMov = oldSet.intersection(newSet)

  switch newSet.count - oldSet.count {
  case ...(-1): // there are less items to show than the old list
    if toMov.isEmpty { // no items to relocate, we only need to check which index paths are not needed by the new list
      var toRemove = [Int]()
      var toReload = [Int]()

      for item in toDel {
        guard let index = oldItems.firstIndex(of: item) else {
          continue
        }

        if index < newItems.count {
          toReload.append(index)
        } else {
          toRemove.append(index)
        }
      }

      return DiffingResult(toRemove: toRemove, toInsert: [], toReload: toReload, toMove: [])
    } else { // there are items to relocate, only remove the items that are removed, as the relocation will fill them up
      let toRemove = toDel.compactMap { oldItems.firstIndex(of: $0) }
      var relocate = [(f: Int, t: Int)]()

      zip(toMov.map { oldItems.firstIndex(of: $0)! },
          toMov.map { newItems.firstIndex(of: $0)! })
        .forEach { a, b in
          if a != b {
            relocate.append((f: a, t: b))
          }
        }

      return DiffingResult(toRemove: toRemove, toInsert: [], toReload: [], toMove: relocate)
    }

  case 1...: // there are more items to show than the old list
    if toMov.isEmpty {
      var toInsert = [Int]()
      var toReload = [Int]()

      for item in toAdd {
        guard let index = newItems.firstIndex(of: item) else {
          continue
        }

        if index < oldItems.count {
          toReload.append(index)
        } else {
          toInsert.append(index)
        }
      }

      return DiffingResult(toRemove: [], toInsert: toInsert, toReload: toReload, toMove: [])

    } else {
      let toInsert = toAdd.compactMap { newItems.firstIndex(of: $0) }
      var relocate = [(f: Int, t: Int)]()

      zip(toMov.map { oldItems.firstIndex(of: $0)! },
          toMov.map { newItems.firstIndex(of: $0)! })
        .forEach  { a, b in
          if a != b {
            relocate.append((f: a, t: b))
          }
        }

      return DiffingResult(toRemove: [], toInsert: toInsert, toReload: [], toMove: relocate)
    }

  default:

    var toReload = Set<Int>()
    var relocate = [(f: Int, t: Int)]()

    for item in toAdd {
      toReload.insert(newItems.firstIndex(of: item)!)
    }

    for item in toDel {
      toReload.insert(newItems.firstIndex(of: item)!)
    }

    zip(toMov.map { oldItems.firstIndex(of: $0)! },
        toMov.map { newItems.firstIndex(of: $0)! })
      .forEach  { a, b in
        if a != b {
          relocate.append((f: a, t: b))
          toReload.remove(b)
        }
      }

    return DiffingResult(toRemove: [], toInsert: [], toReload: toReload.asArray, toMove: relocate)
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
