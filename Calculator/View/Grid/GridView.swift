//
//  GridView.swift
//  Calculator
//
//  Created by Vido Valianto on 7/11/20.
//  Copyright © 2020 Vido Valianto. All rights reserved.
//

import SwiftUI

struct GridLayout {
    private(set) var size: CGSize
    public var rowCount: Int = 0
    public var columnCount: Int = 0

    init(itemCount: Int, rowCount row: Int = 1, colCount col: Int = 1, frame size: CGSize) {
        self.size = size
        // if our size is zero width or height or the itemCount is not > 0
        // then we have no work to do (because our rowCount & columnCount will be zero)
        guard row > 0, col > 0, size.width != 0, size.height != 0, itemCount > 0 else { return }

        let rowCarry = rowCount*col >= itemCount ? 0 : 1
        let colCarry = rowCount*col >= itemCount ? 0 : 1

        rowCount = row > 1 ? row : (itemCount/col) + rowCarry
        columnCount = col > 1 ? col :  (itemCount/row) + colCarry
    }

    var itemSize: CGSize {
        if rowCount == 0 || columnCount == 0 {
            return CGSize.zero
        } else {
            return CGSize(
                width: size.width / CGFloat(columnCount),
                height: size.height / CGFloat(rowCount)
            )
        }
    }

    func location(ofItemAt index: Int) -> CGPoint {
        if rowCount == 0 || columnCount == 0 {
            return CGPoint.zero
        } else {
            return CGPoint(
                x: (CGFloat(index % columnCount) + 0.5) * itemSize.width,
                y: (CGFloat(index / columnCount) + 0.5) * itemSize.height
            )
        }
    }
}
