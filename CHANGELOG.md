## 2.2.5
- fix: Correct handling of nullable types in `Memoized`.

## 2.2.4
- fix(example/async): ensure intended delay by correcting Future.delayed() usage.
## 2.2.3

## 2.2.2
### Adding Notes on `Memoized`:
- Explain the issue of ineffective caching when creating `Memoized` instances as function variables.
- Present the correct approach of creating and storing a `Memoized` instance.
- Provide code examples to illustrate both approaches.

## 2.2.1
  - Fix bug in expire() method: set _status to expired instead of comparing

## 2.2.0
  - Add new methods to Memoized.
    - `isExpired`, `isNotComputedYet`, `isComputed`

## 2.1.0
  - Removed the `to_string_pretty` package from the dependencies.
  - Follows Dart file conventions
  - Improves the document.

## 2.0.0
  ### Breaking Changes
  1. **Updated the Dart SDK to version '>=3.0.0 <4.0.0'**
  2. **Migration to Dart 3.0's Record Feature**: Transitioned the data structures to cache arguments from the `tuples` package to the new Record feature introduced in Dart 3.0.

## 1.5.0
  - Breaking: remove the deprecated methods `Memoized.update` and `Memoized.requestUpdate`.


## 1.4.7
  - Replace LRUCache with quiver.collection.LruMap

## 1.4.2
  - Update package description.

## 1.4.0

- Remove: MemoizedAsync
- Add
  1. Memoized 2, 3, 4, 5
  2. MemoizedN.expireAll()

## 1.0.0

- Initial version.

