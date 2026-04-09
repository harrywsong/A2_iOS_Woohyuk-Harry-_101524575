//
//  ProductListView.swift
//  A2_iOS_Woohyuk(Harry)_101524575
//
//  Created by Woohyuk Song on 2026-04-09.
//

import SwiftUI
import CoreData

struct ProductListView: View {
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)])
    private var products: FetchedResults<Product>

    var body: some View {
        NavigationStack {
            // loop through each product one by one and display the name and description of the products
            List(products, id: \.id) { product in
                VStack(alignment: .leading, spacing: 4) {
                    Text(product.name ?? "")
                        .font(.headline)
                    Text(product.productDescription ?? "")
                        .font(.subheadline)
                        .lineLimit(3)
                }
                .padding(4)
            }
            .navigationTitle("All Products")
        }
    }
}

#Preview {
    ProductListView()
}
