//
//  DeliveryStatus.swift
//  DeliveryTracker-App
//
//  Created by VC on 08/10/26.
//
import Foundation

enum DeliveryStatus: String, Codable, CaseIterable {
    case pending = "Pending"
    case outForDelivery = "Out for Delivery"
    case delivered = "Delivered"
    case cancelled = "Cancelled"
}
