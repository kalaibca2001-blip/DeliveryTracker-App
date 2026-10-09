//
//  DeliveryViewModel.swift
//  DeliveryTracker-App
//
//  Created by VC on 08/10/26.
//
import Foundation
import SwiftUI
import Combine

final class DeliveryViewModel: ObservableObject {
    
    @Published var deliveries: [Delivery] = []
    @Published var searchText = ""
    @Published var selectedStatus: DeliveryStatus?
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let repository = DeliveryRepository()
    
    private let deliveriesURL = URL(
        string: "https://mpaa426253ab38186d19.free.beeceptor.com/deliveries"
    )!
    
    var filteredDeliveries: [Delivery] {
        deliveries.filter { delivery in
            
            let matchesSearch =
                searchText.isEmpty ||
                delivery.orderNumber.localizedCaseInsensitiveContains(searchText) ||
                delivery.customerName.localizedCaseInsensitiveContains(searchText) ||
                delivery.address.localizedCaseInsensitiveContains(searchText)
            
            let matchesStatus =
                selectedStatus == nil ||
                delivery.status == selectedStatus
            
            return matchesSearch && matchesStatus
        }
    }
    
    func fetchDeliveries() async {
        isLoading = true
        errorMessage = nil
        
        do {
            deliveries = try await repository.fetchDeliveries(from: deliveriesURL)
        } catch {
            errorMessage = "Unable to load deliveries. Please try again."
        }
        
        isLoading = false
    }
    
    func retry() async {
        await fetchDeliveries()
    }
}
