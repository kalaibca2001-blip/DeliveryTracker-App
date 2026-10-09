//
//  Delivery.swift
//  DeliveryTracker-App
//
//  Created by VC on 08/10/26.
//
import Foundation

struct Delivery: Identifiable, Codable {
    let id: String
    let orderNumber: String
    let customerName: String
    let status: DeliveryStatus
    let deliveryDate: String
    let address: String
    let items: [DeliveryItem]
    let totalAmount: Double
    let deliveryNotes: String
}
