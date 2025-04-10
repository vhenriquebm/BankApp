//
//  BankAppTests.swift
//  BankAppTests
//
//  Created by Vitor Henrique Barreiro Marinho on 09/04/25.
//

import Testing

import XCTest

final class TransferModuleTests: XCTestCase {
    
    func testExample() async throws {
        // Exemplo básico: soma simples
        let result = try await performAsyncAddition(a: 2, b: 3)
        XCTAssertEqual(result, 5, "A soma de 2 + 3 deveria ser 5")
    }

    // Simula uma função async só pra ilustrar
    private func performAsyncAddition(a: Int, b: Int) async throws -> Int {
        try await Task.sleep(nanoseconds: 100_000_000) // 0.1s só pra parecer async
        return a + b
    }
}
