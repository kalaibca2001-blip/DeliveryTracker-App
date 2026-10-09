//
//  DeliveryDetailView.swift
//  DeliveryTracker-App
//
//  Created by VC on 08/10/26.
//

import SwiftUI

struct DeliveryDetailView: View {
    
    let delivery: Delivery
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Order Information")
                        .font(.title2)
                        .bold()
                    
                    Text("Order Number: \(delivery.orderNumber)")
                    Text("Customer: \(delivery.customerName)")
                    Text("Status: \(delivery.status.rawValue)")
                    Text("Delivery Date: \(delivery.deliveryDate)")
                }
                // Delivery Progress
                VStack(alignment: .leading, spacing: 12) {
                    Text("Delivery Progress")
                        .font(.title2)
                        .bold()
                    
                    HStack(spacing: 0) {
                        ProgressStep(
                            title: "Pending",
                            isCompleted: delivery.status != .pending
                        )
                        
                        ProgressLine(
                            isCompleted: delivery.status == .outForDelivery ||
                                         delivery.status == .delivered
                        )
                        
                        ProgressStep(
                            title: "Out for Delivery",
                            isCompleted: delivery.status == .delivered
                        )
                        
                        ProgressLine(
                            isCompleted: delivery.status == .delivered
                        )
                        
                        ProgressStep(
                            title: "Delivered",
                            isCompleted: delivery.status == .delivered
                        )
                    }
                }
                Divider()
                
            
                VStack(alignment: .leading, spacing: 8) {
                    Text("Delivery Address")
                        .font(.title2)
                        .bold()
                    
                    Text(delivery.address)
                        .foregroundStyle(.secondary)
                }
                
                Divider()
                
              
                VStack(alignment: .leading, spacing: 12) {
                    Text("Order Items")
                        .font(.title2)
                        .bold()
                    
                    ForEach(delivery.items.indices, id: \.self) { index in
                        let item = delivery.items[index]
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                
                                Text("Quantity: \(item.quantity)")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            
                            Spacer()
                            
                            Text("$\(item.price, specifier: "%.2f")")
                                .font(.headline)
                        }
                    }
                }
                
                Divider()
                
               
                HStack {
                    Text("Total Amount")
                        .font(.title3)
                        .bold()
                    
                    Spacer()
                    
                    Text("$\(delivery.totalAmount, specifier: "%.2f")")
                        .font(.title3)
                        .bold()
                }
                
                Divider()
                
             
                VStack(alignment: .leading, spacing: 8) {
                    Text("Delivery Notes")
                        .font(.title2)
                        .bold()
                    
                    Text(delivery.deliveryNotes)
                        .foregroundStyle(.secondary)
                }
            }
            .padding()
        }
        .navigationTitle("Delivery Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
struct ProgressStep: View {
    
    let title: String
    let isCompleted: Bool
    
    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
                .font(.title2)
            
            Text(title)
                .font(.caption)
                .multilineTextAlignment(.center)
        }
    }
}

struct ProgressLine: View {
    
    let isCompleted: Bool
    
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .frame(maxWidth: .infinity)
            .opacity(isCompleted ? 1 : 0.3)
    }
}
#Preview {
    Text("Delivery Details Preview")
}
