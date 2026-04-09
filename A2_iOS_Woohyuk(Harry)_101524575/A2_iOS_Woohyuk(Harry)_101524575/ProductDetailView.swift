//
//  ProductDetailView.swift
//  A2_iOS_Woohyuk(Harry)_101524575
//
//  Created by Woohyuk Song on 2026-04-09.
//

import SwiftUI
import CoreData

struct ProductDetailView: View {
    // gives this view access to Core Data
    @Environment(\.managedObjectContext) private var viewContext
    
    // fetches all Product records from Core Data, sorted alphabetically by name
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)])
    private var products: FetchedResults<Product>

    // tracks which Product is being displayed - 0 (first item) by default
    @State private var currentIndex = 0

    var body: some View {
        NavigationStack {
            // in case there are no products
            if products.isEmpty {
                Text("No products found.")
                // if there are products, set the current product to the product at the current index
            } else {
                let product = products[currentIndex]

                VStack(alignment: .leading, spacing: 16) {
                    Text(product.name ?? "")
                        .bold()
                    Text(product.productDescription ?? "")
                    Divider()
                    Text(String(format: "Price: $%.2f", product.price))
                    Text("Provider: \(product.provider ?? "")")
                    Text("ID: \(String(product.id?.uuidString.prefix(8) ?? ""))")
                        .font(.caption)
                    Spacer()

                    HStack {
                        // go to previous index
                        Button("Previous") { currentIndex -= 1 }.disabled(currentIndex == 0)
                        
                        Spacer()
                        
                        Text("\(currentIndex + 1) of \(products.count)")
                        
                        Spacer()
                        
                        // go to next index
                        Button("Next") { currentIndex += 1 }.disabled(currentIndex == products.count - 1)
                    }
                }
                .padding()
                .navigationTitle("Browse")
            }
        }
    }
}

#Preview {
    ProductDetailView()
}
