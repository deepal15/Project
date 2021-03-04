//
//  FixtureManager.swift
//  Knockout
//
//

import Foundation

final class FixtureManager {
    
    // MARK: - Properties
    
    typealias TupleElements = (firstElement: String, secondElement: String)
    
    static let shared = FixtureManager()
    
    private var data: [String] = []
    
    private var currentActivePairs: [TupleElements] = []
    
    private init() {}
    
    // MARK: - Private functions
    
    /// Function to validate the data
    /// - Parameter data: data to be validated
    /// - Returns: Validity of the data
    private func isValidData(_ data: [String]) -> Bool {
        return data.count > 0 && (data.count % 2) == 0
    }
    
    private func getRandomElements() -> TupleElements {
        guard isValidData(data),
              let firstElement = data.randomElement(),
              var secondElement = data.randomElement() else {
            return (firstElement: "", secondElement: "")
        }
        
        while firstElement == secondElement {
            secondElement = data.randomElement() ?? ""
        }
        return (firstElement: firstElement, secondElement: secondElement)
    }
    
    /// Remove elements in the Tuple
    /// - Parameter elements: Element to be removed
    private func removeElements(_ elements: TupleElements) {
        data = data.filter { $0 != elements.firstElement && $0 != elements.secondElement }
    }
    
    @discardableResult
    private func generatePairsRandomly() -> [TupleElements] {
        var pairs = [TupleElements]()
        
        for _ in 0..<data.count / 2 {
            let elements = getRandomElements()
            pairs.append(elements)
            removeElements(elements)
        }
        currentActivePairs = pairs
        return currentActivePairs
    }
    
    /// Function to remove pairse randomly
    private func removePairsRandomly() {
        for _ in 0..<currentActivePairs.count / 2 {
            // Get random index and remove that index
            let randomIndex = Int.random(in: 0..<currentActivePairs.count)
            currentActivePairs.remove(at: randomIndex)
        }
    }
    
    /// Fill the `data` from currentActivePairs so that it can be shuffled, so that next time one team get eliminate it gets random Teams in particular Pair
    private func fillDataFromActivePairsAndShuffle() {
        for (_, activePair) in currentActivePairs.enumerated() {
            data.append(contentsOf: [activePair.firstElement, activePair.secondElement])
        }
        
        // After setting the data from `currentActivePairs` shuffle the data in order to get random team each time so that it can form random Team Pair
        data.shuffle()
    }
    
    // MARK: - Public functions
    
    /// Function to Inject the data for the first time
    /// - Parameter data: Array of data
    public func setData(_ data: [String]) {
        guard isValidData(data) else { return }
        self.data = data
    }
    
    /// Function to get the Team Pairs
    /// - Returns: Randomly generated Team pairs
    public func getTeamPairs() -> [TupleElements] {
        guard isValidData(data) else { return [] }
        return generatePairsRandomly()
    }
    
    /// Function to eliminate the Teams randomly
    /// - Returns: Remaining Teams
    public func eliminateTeams() -> [TupleElements] {
        fillDataFromActivePairsAndShuffle()
        generatePairsRandomly()
        removePairsRandomly()
        return currentActivePairs
    }
    
    public func clearData() {
        currentActivePairs.removeAll(keepingCapacity: true)
        data.removeAll(keepingCapacity: true)
    }
}
