//
//  HomeViewModel.swift
//  CryptoCoins
//
//  Created by Lokesh Vyas on 21/10/24.
//

import Foundation

final class HomeViewModel: ObservableObject {
    private var allCoins: [CryptoCoinDM] = []
    
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var cryptoCoins: [CryptoCoinDM] = []
    @Published private(set) var error: NetworkError = .none
    
    private var cryptoService: CryptoServiceable
    
    @Published var activeFilters: CryptoFilterOptions = [] {
        didSet {
            let filteredCoins = applyFilters(with: filterText)
            cryptoCoins = filteredCoins
        }
    }
    
    var filterText: String = "" {
        didSet {
            guard !filterText.isEmpty else {
                self.cryptoCoins = applyFilters(with: filterText)
                return
            }
            let filteredCoins = applyFilters(with: filterText)
            self.cryptoCoins = filteredCoins
        }
    }
    
    init(cryptoService: CryptoServiceable) {
        self.cryptoService = cryptoService
    }
    
    func fetchCryptoCoins() async {
        isLoading = true
        do {
            let coins = try await cryptoService.fetchCryptoCoins()
            await MainActor.run { [weak self] in
                guard let self else { return }
                self.allCoins = coins
                self.cryptoCoins = coins
                self.isLoading = false
            }
        } catch let error {
            await MainActor.run { [weak self] in
                guard let self else { return }
                self.error = error
                self.isLoading = false
            }
        }
    }
    
    func toggleFilter(_ filter: CryptoFilterOptions) {
        if activeFilters.contains(filter) {
            activeFilters.remove(filter)
        } else {
            if filter == .coins {
                activeFilters.remove(.token)
            } else if filter == .token {
                activeFilters.remove(.coins)
            }
            
            if filter == .active {
                activeFilters.remove(.inactive)
            } else if filter == .inactive {
                activeFilters.remove(.active)
            }
            activeFilters.insert(filter)
        }
    }
    
    private func applyFilters(with text: String) -> [CryptoCoinDM] {
        return allCoins
            .filter { coin in
                guard !text.isEmpty else { return true }
                return coin.name.lowercased().contains(text) || coin.symbol.lowercased().contains(text)
            }
            .filter { coin in
            var matches = true
            
            if activeFilters.contains(.active) {
                matches = matches && coin.isActive
            }
            
            if activeFilters.contains(.inactive) {
                matches = matches && !coin.isActive
            }
            
            if activeFilters.contains(.new) {
                matches = matches && coin.isNew
            }
            
            if activeFilters.contains(.token) {
                matches = matches && coin.type == .token
            }
            
            if activeFilters.contains(.coins) {
                matches = matches && coin.type == .coin
            }
            
            return matches
        }
    }
}
