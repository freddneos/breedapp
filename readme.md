# Dog Breed App

This app fetches and displays information about dog breeds using the Dog API.

## Getting Started

1. Clone the repository:
   ```bash
   git clone [...]
   ```

Open the project in Xcode.
Run the app in a simulator or device.

# BreedApp Project Overview

## Project Structure

The app's codebase is organized into distinct sections, each serving a specific purpose:

- **Utils/**: Utilities like `CacheManager.swift` for caching, aiming to improve performance and support offline usage.

- **Models/**: Defines `DogBreed` and other models, central to our app's data handling.

- **ViewModels/**: Implements the MVVM pattern with classes such as `DogBreedListViewModel`, ensuring a clear separation between our app's logic and its presentation.

- **Views/**: SwiftUI views (`DogBreedListView`, etc.) that render the user interface, designed to be both functional and intuitive.

- **Services/**: The `DogBreedService` class and others encapsulate all networking logic, keeping it separate from UI code.

- **BreedAppTests/**: Contains unit tests, including mocks and test cases for ViewModels and Services, to verify the app's reliability and behavior.

## Key Features and Decisions

- **Caching**: We opted for `UserDefaults` with a simple cache invalidation strategy to enhance data retrieval speed and offer basic offline functionality.

- **Concurrency**: Embraced Swift's async/await for network communication, aiming for cleaner and more readable asynchronous code.

- **Architecture**: Chose the MVVM design pattern to promote a clean separation of concerns across our app's structure.

### Our Approach to Quality

We've strived to maintain high code quality by:

- Prioritizing essential features and robust implementations.
- Adhering to Swift and SwiftUI best practices.
- Designing with future extensibility in mind.

### Core Functionality

- [x] **Show a screen with a list of dog breeds images.**
  - Implemented in `DogBreedListView`.
- [x] **Show a screen with a list of dog breeds when you search by breed name.**
  - Implemented in `DogBreedSearchView` with live search functionality.
- [x] **Show a screen with the detailed view of a breed.**
  - Implemented in `DogBreedDetailView`.

### UI/UX Requirements

- [x] **Use a Tab Bar to switch between the list of dog breeds and the search screen.**
  - Implemented with a `TabView` at the root level.
- [x] **Ability to move from a list view into a grid view and take use of pagination.**
  - Implemented in `DogBreedListView` with a toggle for list/grid view and pagination.
- [x] **Ability to order alphabetically.**
  - Implemented in `DogBreedListView` with a sort button.
- [x] **Show only the dog breed image and the name in the list/grid view.**
  - Implemented in `DogBreedView`.
- [x] **Pressing on one of the list elements goes to the details view.**
  - Implemented with `NavigationLink` in `DogBreedListView` and `DogBreedSearchView`.

### Additional Features

- [x] **Search Bar to search by breed name.**
  - Implemented in `DogBreedSearchView` with debouncing.
- [x] **List of results in search shows Breed Name, Group, Origin.**
  - Assuming implementation based on available data. Display customization might be needed based on the actual model and UI design.
- [x] **Details view contains Breed Name, Category (assuming 'group' or 'designation'), Origin, and Temperament.**
  - Implemented in `DogBreedDetailView`.

### Bonus Points

- [x] **Unit tests coverage.**
  - Provided examples for testing view models: `DogBreedListViewModelTests`, `DogBreedDetailViewModelTests`, and `DogBreedSearchViewModelTests`.
- [x] **Offline functionality.**
  - Covered with a cache strategy. Consider implementing caching with Core Data or UserDefaults.
- [x] **Error Handling.**
  - Basic error handling implemented in view models with loading and error message states.

### Deliverable

- [x] **Create a complete project in a version-controlled repository.**
  - Ensure the project is committed to a Git repository.
- [x] **Perform several commits to show progress.**
  - Commit history should reflect the development progress and implementation details.
- [x] **Share the repository link.**
  - Make the repository public and prepare to share the link.

### Final Steps

- [x] **Review and refine the UI/UX design.** Ensure the app's interface is intuitive and visually appealing.
- [x] **Conduct thorough testing on different devices and OS versions.** Ensure compatibility and smooth operation across a range of conditions.
- [x] **Optimize performance.** Ensure that the app runs smoothly, especially when handling large lists and performing searches.
- [x] **Prepare documentation.** Include a README with setup instructions, features, and any other relevant information.

linkedin.com/in/fredericobezerra
fredd@neosdev.io
freddneos
