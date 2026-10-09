//
//  DeliveryListView.swift
//  DeliveryTracker-App
//
//  Created by VC on 08/10/26.
//


import SwiftUI

struct DeliveryListView: View {
    
    @StateObject private var viewModel = DeliveryViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color.purple.opacity(0.18),
                        Color.pink.opacity(0.22),
                        Color.white
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                Group {
                    if viewModel.isLoading {
                        ProgressView("Loading deliveries...")
                            .tint(.purple)
                        
                    } else if let errorMessage = viewModel.errorMessage {
                        VStack(spacing: 16) {
                            Image(systemName: "exclamationmark.triangle")
                                .font(.largeTitle)
                                .foregroundStyle(.red)
                            
                            Text(errorMessage)
                                .multilineTextAlignment(.center)
                            
                            Button("Retry") {
                                Task {
                                    await viewModel.retry()
                                }
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        .padding()
                        
                    } else if viewModel.filteredDeliveries.isEmpty {
                        ContentUnavailableView(
                            "No Deliveries",
                            systemImage: "shippingbox",
                            description: Text(
                                "No deliveries match your search or filter."
                            )
                        )
                        
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 16) {
                                ForEach(viewModel.filteredDeliveries) { delivery in
                                    NavigationLink {
                                        DeliveryDetailView(delivery: delivery)
                                    } label: {
                                        deliveryCard(delivery)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                        }
                        .refreshable {
                            await viewModel.fetchDeliveries()
                        }
                    }
                }
            }
            .navigationTitle("Deliveries")
            .navigationBarTitleDisplayMode(.large)
            .searchable(
                text: $viewModel.searchText,
                prompt: "Search order, customer or address"
            )
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Button("All") {
                            viewModel.selectedStatus = nil
                        }
                        
                        ForEach(DeliveryStatus.allCases, id: \.self) { status in
                            Button(status.rawValue) {
                                viewModel.selectedStatus = status
                            }
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                            .font(.headline)
                    }
                }
            }
            .task {
                await viewModel.fetchDeliveries()
            }
        }
    }
    
    @ViewBuilder
    private func deliveryCard(_ delivery: Delivery) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(delivery.orderNumber)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                
                Spacer()
                
                Text(delivery.status.rawValue)
                    .font(.caption)
                    .fontWeight(.heavy)
             
                    .foregroundStyle(statusColor(for: delivery.status))
            }
            
            Text(delivery.customerName)
                .font(.body)
                .fontWeight(.medium)
                .foregroundStyle(.primary)
            
            HStack(alignment: .top, spacing: 6) {
                Image(systemName: "location")
                    .font(.caption)
                    .foregroundStyle(.black)
                
                Text(delivery.address)
                    .font(.caption)
                    .fontWeight(.bold)
               
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.leading)
                
                Spacer()
            }
            
            HStack {
                Image(systemName: "calendar")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Text(delivery.deliveryDate)
                    .font(.caption)
                    .foregroundStyle(.black)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(cardColor(for: delivery.status))
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .overlay(
            RoundedRectangle(cornerRadius: 22)
                .stroke(
                    statusColor(for: delivery.status).opacity(0.25),
                    lineWidth: 1
                )
        )
        .shadow(
            color: .black.opacity(0.28),
            radius: 8,
            x: 0,
            y: 4
        )
    }
    
    private func statusColor(for status: DeliveryStatus) -> Color {
        switch status {
        case .pending:
            return Color(red: 0.65, green: 0.30, blue: 0.00)
        case .outForDelivery:
            return Color(red: 0.00, green: 0.25, blue: 0.65)
        case .delivered:
            return Color(red: 0.00, green: 0.40, blue: 0.15)
        case .cancelled:
            return Color(red: 0.75, green: 0.05, blue: 0.15)
        }
    }
    
    private func cardColor(for status: DeliveryStatus) -> Color {
        switch status {
        case .pending:
            return Color.orange.opacity(0.20)
        case .outForDelivery:
            return Color.blue.opacity(0.20)
        case .delivered:
            return Color.green.opacity(0.20)
        case .cancelled:
            return Color.red.opacity(0.20)
        }
    }
}

#Preview {
    DeliveryListView()
}
