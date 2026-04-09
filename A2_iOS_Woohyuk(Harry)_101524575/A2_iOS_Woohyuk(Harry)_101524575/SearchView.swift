//
//  SearchView.swift
//  A2_iOS_Woohyuk(Harry)_101524575
//
//  Created by Woohyuk Song on 2026-04-09.
//

import SwiftUI
import CoreData

struct SearchView: View {
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)])
    private var products: FetchedResults<Product>

    // store the user input as this variable. empty string by default
    @State private var searchText = ""

    var filtered: [Product] {
        // if the search field is empty, return all products
        if searchText.isEmpty { return Array(products) }
        // otherwise, make sure the search is case insensitive and return the products that match the filter (name/description)
        return products.filter {
            ($0.name ?? "").localizedCaseInsensitiveContains(searchText) ||
            ($0.productDescription ?? "").localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        NavigationStack {
            List(filtered, id: \.id) { product in
                VStack(alignment: .leading, spacing: 4) {
                    Text(product.name ?? "")
                        .font(.headline)
                    Text(product.productDescription ?? "")
                        .font(.subheadline)
                        .lineLimit(3)
                }
                .padding(4)
            }
            // default text in the search box prior to user interaction
            .searchable(text: $searchText, prompt: "Search by name or description")
            .navigationTitle("Search")
        }
    }
}

#Preview {
    SearchView()
}
