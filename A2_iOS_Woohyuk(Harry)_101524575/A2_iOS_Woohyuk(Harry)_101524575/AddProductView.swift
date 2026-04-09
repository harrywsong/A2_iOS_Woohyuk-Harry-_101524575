//
//  AddProductView.swift
//  A2_iOS_Woohyuk(Harry)_101524575
//
//  Created by Woohyuk Song on 2026-04-09.
//

import SwiftUI
import CoreData

struct AddProductView: View {
    @Environment(\.managedObjectContext) private var viewContext

    // declare the variables
    @State private var name = ""
    @State private var productDescription = ""
    @State private var price = ""
    @State private var provider = ""
    @State private var showAlert = false

    var body: some View {
        NavigationStack {
            // form for inputting the necessary product information
            Form {
                Section("Product Info") {
                    TextField("Product Name", text: $name)
                    TextField("Description", text: $productDescription)
                    TextField("Provider", text: $provider)
                }
                Section("Pricing") {
                    TextField("Price (e.g. 19.99)", text: $price)
                    // for number keyboard
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("Add Product")
            .toolbar {
                // disables the save button if either the name or provider is empty.
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveProduct()
                    }
                    .disabled(name.isEmpty || provider.isEmpty)
                }
            }
            // shows an alert to confirm that the product was successfully saved
            .alert("Product saved!", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            }
        }
    }

    // the function that actually creates a new Product object within Core Data
    private func saveProduct() {
        let product = Product(context: viewContext)
        // random UUID (unique identifier) is generated for the product
        product.id = UUID()
        product.name = name
        product.productDescription = productDescription
        // price is converted to double, defaults to 0.0 if fails
        product.price = Double(price) ?? 0.0
        product.provider = provider

        // tries to save the new product
        try? viewContext.save()

        name = ""
        productDescription = ""
        price = ""
        provider = ""
        showAlert = true
    }
}

#Preview {
    AddProductView()
}
