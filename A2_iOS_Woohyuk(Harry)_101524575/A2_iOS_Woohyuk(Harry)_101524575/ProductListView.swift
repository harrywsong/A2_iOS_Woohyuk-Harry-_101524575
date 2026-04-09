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
                VStack(spacing: 4) {
                    Text(product.name ?? "")
                    Text(product.productDescription ?? "")
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
