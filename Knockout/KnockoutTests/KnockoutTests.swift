//
//  KnockoutTests.swift
//  KnockoutTests
//
//

import XCTest
@testable import Knockout

class KnockoutTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFixtureManagerTeamPairs() {
        let array = ["First", "Second", "Third", "Fourth", "Fifth", "Sixth", "Seventh", "Eighth"]
        FixtureManager.shared.setData(array)
        let pairs = FixtureManager.shared.getTeamPairs()
        XCTAssertEqual(4, pairs.count)
    }
    
    /// Function to test if the FixtureManager has no data then it would not continue the processing
    func testFixtureManagerWithNoData() {
        let array: [String] = []
        FixtureManager.shared.setData(array)
        let pairs = FixtureManager.shared.getTeamPairs()
        XCTAssertEqual(0, pairs.count)
    }
    
    /// Function to test if the FixtureManager has odd number of data then it would not continue the processing
    func testFixtureManagerOddElements() {
        let array = ["First", "Second", "Third",]
        FixtureManager.shared.setData(array)
        let pairs = FixtureManager.shared.getTeamPairs()
        XCTAssertEqual(0, pairs.count)
    }
    
    /// Function to eliminate random elements in the first round, and returns the removed pairs
    /// e.g. ["First", "Second", "Third", "Fourth", "Fifth", "Sixth", "Seventh", "Eighth"] that would make 4 Team Pairs
    /// after first elimination 2 Teams would get eliminated (Half of total Paired Teams)
    func testFixtureManagerEliminateTeamsFirstIteration() {
        let array = ["First", "Second", "Third", "Fourth", "Fifth", "Sixth", "Seventh", "Eighth"]
        FixtureManager.shared.setData(array)
        var pairs = FixtureManager.shared.getTeamPairs()
        pairs = FixtureManager.shared.eliminateTeams()
        XCTAssertEqual(2, pairs.count)
    }
    
    /// Function to eliminate random elements in the first round, and returns the removed pairs
    /// e.g. ["First", "Second", "Third", "Fourth", "Fifth", "Sixth", "Seventh", "Eighth"] that would make 4 Team Pairs
    /// after first elimination 2 Teams would get eliminated (Half of total Paired Teams)
    /// after second elimination 1 Team would get elimniated (Half of total Paired Teams)
    func testFixtureManagerEliminateTeamsSecondIteration() {
        let array = ["First", "Second", "Third", "Fourth", "Fifth", "Sixth", "Seventh", "Eighth"]
        FixtureManager.shared.setData(array)
        var pairs = FixtureManager.shared.getTeamPairs()
        pairs = FixtureManager.shared.eliminateTeams()
        pairs = FixtureManager.shared.eliminateTeams()
        XCTAssertEqual(1, pairs.count)
    }
}
