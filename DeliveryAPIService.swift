//
//  DeliveryAPIService.swift
//  DeliveryTracker-App
//
//  Created by VC on 08/10/26.
//

import Foundation

struct DeliveryAPIService {
    
    func fetchDeliveries(from url: URL) async throws -> [Delivery] {
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200...299 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode([Delivery].self, from: data)
    }
}
