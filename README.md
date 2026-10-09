# DeliveryTracker-App
iOS Delivery Tracker App using SwiftU
# Delivery Tracker App

A native iOS application developed using **Swift and SwiftUI** as part of an iOS development machine test. The application retrieves delivery records from a REST API and displays them in a clean, user-friendly interface.

## Project Overview

The Delivery Tracker App helps users browse delivery records, view delivery statuses, search for specific orders, and navigate to individual delivery details.

## Features

- **Delivery Listing:** Retrieves delivery records using a REST API.
- **Delivery Status Indicators:** Displays Pending, Out for Delivery, Delivered, and Cancelled statuses.
- **Search Functionality:** Search by order number, customer name, or delivery address.
- **Status Filtering:** Filter deliveries based on their current status.
- **Delivery Details:** View order, customer, address, date, and item information.
- **Navigation:** Navigate from the delivery list to the details screen.
- **Loading State:** Displays a loading indicator while retrieving data.
- **Error Handling:** Displays an error message when a request fails.
- **Retry Option:** Allows the user to attempt the request again.
- **Pull to Refresh:** Refresh the delivery list.

## Technologies Used

- Swift
- SwiftUI
- URLSession
- REST API
- Codable
- Swift Concurrency (`async/await`)
- ObservableObject and `@Published`
- Git and GitHub

## API Integration

**Base URL:**  
`https://mpaa426253ab38186d19.free.beeceptor.com`

| Method | Endpoint | Purpose |
|---|---|---|
| GET | `/deliveries` | Retrieves the delivery list |
| GET | `/deliveries/DLV-1001` | Retrieves details for a specific delivery |
| GET | `/deliveries-error` | Simulates an API failure |

The application uses URLSession to make HTTP requests and Codable to decode JSON responses into Swift models.

## Architecture

The project follows an **MVVM-inspired architecture**, separating the user interface, presentation logic, and data access responsibilities.

- **Model:** Represents delivery information and delivery items.
- **View:** Displays the delivery list and details using SwiftUI.
- **ViewModel:** Manages delivery data, search, filtering, loading, and error states.
- **Repository:** Provides an abstraction for accessing delivery data.
- **API Service:** Handles network requests and JSON decoding.

## Project Structure

| File | Description |
|---|---|
| `Delivery.swift` | Main delivery data model |
| `DeliveryItem.swift` | Delivery item model |
| `DeliveryStatus.swift` | Delivery status definitions |
| `DeliveryAPIService.swift` | API communication and response decoding |
| `DeliveryRepository.swift` | Data access abstraction |
| `DeliveryViewModel.swift` | Presentation state, search, filtering, and


## Limitations and Incomplete Work

Due to API request failures during testing and the limited time available, some requirements could not be fully completed or verified.

- The API failure scenario using `/deliveries-error` requires further testing.
- The Retry functionality requires additional verification under actual API failure conditions.
- The individual delivery endpoint needs to be verified in the submitted build.
- Persistent Important flags and an Important-only screen have not been implemented.
- Unit tests have not been added.
- A dedicated welcome screen and further UI/UX refinements remain incomplete.

## Future Enhancements

- Improve API failure handling and retry behavior.
- Test all provided endpoints under success and failure scenarios.
- Implement persistent storage for Important delivery flags.
- Add a dedicated screen for Important deliveries.
- Add unit tests for ViewModel logic and API handling.
- Introduce a welcome screen for an improved first impression.
- Further enhance the UI/UX, accessibility, and overall user experience.
- Add verified application screenshots and detailed setup instructions.
