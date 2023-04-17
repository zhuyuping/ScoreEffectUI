//
//  TestIncentiveView.swift
//  AgoraLyricsScore-Unit-Tests
//
//  Created by ZYP on 2023/4/12.
//

import XCTest
@testable import ScoreEffectUI

class TestIncentiveView: XCTestCase {
    func testScoreCalculatedItem() {
        let view = IncentiveView()
        let scores = [0, 80, 60, 83, 89, 90, 83, 84, 85]
        let items = scores.map({ view.calculatedItem(score: $0) })
        let typesExp: [IncentiveView.IncentiveType] = [.none, .good, .fair, .good, .good, .excellent, .good, .good, .good]
        let numsExp = [1, 1, 1, 1, 2, 1, 1, 2, 3]
        XCTAssertEqual(items.map({ $0.type }), typesExp)
        XCTAssertEqual(items.map({ $0.num }), numsExp)
        
        view.reset()
        let items2 = scores.map({ view.calculatedItem(score: $0) })
        XCTAssertEqual(items2.map({ $0.type }), typesExp)
        XCTAssertEqual(items2.map({ $0.num }), numsExp)
    }
    
    func testScoreCalculatedItem2() {
        let view = IncentiveView()
        let scores = [0, 60, 82, 65, 71, 16, 77, 38, 0]
        let items = scores.map({ view.calculatedItem(score: $0) })
        let typesExp: [IncentiveView.IncentiveType] = [.none, .fair, .good, .fair, .fair, .none, .good, .none, .none]
        let numsExp = [1, 1, 1, 1, 2, 1, 1, 1, 1]
        XCTAssertEqual(items.map({ $0.type }), typesExp)
        XCTAssertEqual(items.map({ $0.num }), numsExp)
        
        view.reset()
        let items2 = scores.map({ view.calculatedItem(score: $0) })
        XCTAssertEqual(items2.map({ $0.type }), typesExp)
        XCTAssertEqual(items2.map({ $0.num }), numsExp)
    }
    
    func testScoreCalculatedItem3() {
        let view = IncentiveView()
        let scores = [0, 0, 6, 11, 29, 77, 84, 71, 66, 0, 0, 0]
        let items = scores.map({ view.calculatedItem(score: $0) })
        let typesExp: [IncentiveView.IncentiveType] = [.none, .none, .none, .none, .none, .good, .good, .fair, .fair, .none, .none, .none]
        let numsExp = [1, 1, 1, 1, 1, 1, 2, 1, 2, 1, 1, 1]
        XCTAssertEqual(items.map({ $0.type }), typesExp)
        XCTAssertEqual(items.map({ $0.num }), numsExp)
        
        view.reset()
        let items2 = scores.map({ view.calculatedItem(score: $0) })
        XCTAssertEqual(items2.map({ $0.type }), typesExp)
        XCTAssertEqual(items2.map({ $0.num }), numsExp)
    }
}
