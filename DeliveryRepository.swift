//
//  DeliveryRepository.swift
//  DeliveryTracker-App
//
//  Created by VC on 08/10/26.
//
import Foundation

struct DeliveryRepository {
    
    private let apiService = DeliveryAPIService()
    
    func fetchDeliveries(from url: URL) async throws -> [Delivery] {
        return try await apiService.fetchDeliveries(from: url)
    }
}
