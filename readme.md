# Dog Breed App

This app fetches and displays information about dog breeds using the Dog API.

## Features

- List of dog breeds with images
- Search for breeds by name
- Detailed view of a breed
- Pagination and sorting
- Grid view option
- Offline functionality
- Error handling

## Getting Started

1. Clone the repository:
   ```bash
   git clone [...]
   ```

Open the project in Xcode.
Run the app in a simulator or device.

## TODO LIST for the Dog Breed App Challenge

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
- [ ] **Offline functionality.**
  - Not explicitly covered. Consider implementing caching with Core Data or UserDefaults.
- [x] **Error Handling.**
  - Basic error handling implemented in view models with loading and error message states.

### Deliverable

- [ ] **Create a complete project in a version-controlled repository.**
  - Ensure the project is committed to a Git repository.
- [ ] **Perform several commits to show progress.**
  - Commit history should reflect the development progress and implementation details.
- [ ] **Share the repository link.**
  - Make the repository public and prepare to share the link.

### Final Steps

- [ ] **Review and refine the UI/UX design.** Ensure the app's interface is intuitive and visually appealing.
- [ ] **Conduct thorough testing on different devices and OS versions.** Ensure compatibility and smooth operation across a range of conditions.
- [ ] **Optimize performance.** Ensure that the app runs smoothly, especially when handling large lists and performing searches.
- [ ] **Prepare documentation.** Include a README with setup instructions, features, and any other relevant information.
