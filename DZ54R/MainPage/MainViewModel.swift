//
//  MainViewModel.swift
//  DZ54R
//
//  Created by merim kasenova on 27/5/23.
//

import Foundation

class MainViewModel {
    private let networkLayer = NetworkManager.shared
    
    var products: [Product] = []
    
    func fetchProducts() async {
        do {
            self.products = try await networkLayer.fetchProducts().products
        } catch {
            print(error.localizedDescription)
        }
    }
}
