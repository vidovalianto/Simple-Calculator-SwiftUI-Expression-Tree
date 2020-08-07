//
//  CalculatorViewModel.swift
//  Calculator
//
//  Created by Vido Valianto on 7/11/20.
//  Copyright © 2020 Vido Valianto. All rights reserved.
//

import Foundation
import Combine

public final class CalculatorViewModel: ObservableObject {
    public static let shared = CalculatorViewModel()

    //  MARK:- TODO make it an enum
    public let toolButtons: [String] = ["AC", "+/-", "%"]
    public let operationButtons: [Character] = ["+", "-", ":", "x", "="]

    public let numberButtons: [String] = Array(1...9).map({ return String($0) }) + ["0"]

    @Published public var text = ""

    private var operationStack = [String]()
    private var root: ExpressionTree?

    private init() {}

    public func numberButtonClicked(_ num: String) {
        if text == numberButtons.last ?? "0" {
            text = ""
        }

        self.text.append(num)
    }

    public func operationButtonClicked(_ operation: Character) {
        if self.operationStack.isEmpty && self.text.isEmpty { return }

        /// Change previous math operation
        if let lastElement = self.operationStack.last?.first , !lastElement.isNumber, text.isEmpty {
            self.operationStack.removeLast()
            self.operationStack.append(String(operation))
            return
        }

        /// Build expression tree and calculate the inputted math operation
        if operation == self.operationButtons.last ?? "=" {
            self.operationStack.append(text)
            self.root = ExpressionTree(self.operationStack)
            self.root?.flatten()

            self.operationStack = [String]()
            
            text = self.root?.val ?? "Error Getting Result"
            return
        }

        self.operationStack.append(text)
        self.operationStack.append(String(operation))

        text = ""
    }

    public func toolButtonClicked(_ tool: String) {
        switch tool {
        case toolButtons[0]:
            self.text.removeAll()
            self.operationStack.removeAll()
        case toolButtons[1]:
            guard let firstElement = self.text.first else { return }

            if firstElement == "-" {
                self.text.removeFirst()
                return
            }

            if firstElement != "-" && self.text != "0" {
                self.text = "-" + self.text
            }
        default:
            guard let val = Double(self.text) else { return }
            self.text = String(val/Double(100))
        }
    }
}
