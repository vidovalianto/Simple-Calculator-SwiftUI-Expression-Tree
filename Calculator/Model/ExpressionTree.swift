//
//  ExpressionTree.swift
//  Calculator
//
//  Created by Vido Valianto on 7/12/20.
//  Copyright © 2020 Vido Valianto. All rights reserved.
//

import Foundation

public class ExpressionTree {
    public var val: String = ""
    public var left: ExpressionTree?
    public var right: ExpressionTree?

    public init(_ val: String) {
        self.val = val
    }

    public init(_ val: [String]) {
        let length = val.count-1

        let index = findRootValue(val, 0, length)
        self.val = val[index]
        self.left = self.insert(val, 0, index-1)
        self.right = self.insert(val, index+1, length)

        return
    }

    public func insert(_ val: [String], _ start: Int , _ end: Int) -> ExpressionTree? {
        let index = findRootValue(val, start, end)

        if index == -1 { return nil }

        if index == val.count {
            return ExpressionTree(val[start...end].reduce("", +))
        }

        let node = ExpressionTree(val[index])
        node.left = node.insert(val, start, index-1)
        node.right = node.insert(val, index+1, end)
        return node
    }

    /// Flatten the tree, start calculating the math formula
    public func flatten() {
        guard let lastCharacter =  self.val.last, !lastCharacter.isNumber else { return }

        left?.flatten()
        right?.flatten()

        self.val = calculate(lastCharacter, Double(left?.val ?? "0")!, Double(right?.val ?? "0")!)
        self.left = nil
        self.right = nil

        return
    }

    // MARK: - Private

    private func isChildOperation(_ char: String) -> Bool {
        return char == "x" || char == ":"
    }

    private func isRootOperation(_ char: String) -> Bool {
        return char == "-" || char == "+"
    }

    /// finding root value with math operation order
    private func findRootValue(_ val: [String], _ start: Int = 0 , _ end: Int) -> Int {
        if start > end { return -1 }
        for i in (start...end).reversed() {
            if isRootOperation(val[i]) {
                return i
            }
        }

        for i in start...end {
            if isChildOperation(val[i]) {
                return i
            }
        }

        return val.count
    }
}

extension ExpressionTree {
    private func calculate(_ op: Character, _ num1: Double, _ num2: Double = 0) -> String {
        switch op {
        case "-":
            return String(num1-num2)
        case "+":
            return String(num1+num2)
        case "x":
            return String(num1*num2)
        default:
            return String(num1/num2)
        }
    }
}
