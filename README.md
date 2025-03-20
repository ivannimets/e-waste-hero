
# E-Waste Hero

**E-Waste Hero** is a mobile application designed to help individuals manage and recycle their electronic waste (e-waste). The app allows users to:
- Search for nearby locations to dispose of their e-waste.
- Estimate the approximate price of their e-waste bin (with future plans to integrate AI for more accurate pricing).
- Create shared bins with other users to collectively manage and recycle e-waste.

### Features
- **Find Nearby Locations**: Users can search for nearby e-waste recycling centers where they can drop off their items.
- **Add items to the bin**: Users can add new items to their recycling bin, specify the quantity, and track them.
- **Manage item quantity**: Items can be incremented or decremented in quantity.
- **Delete items**: Users can remove items from the bin when no longer needed.
- **Estimate Bin Value**: The app provides an approximate value for the e-waste in the bin. Future updates will incorporate AI for more accurate price estimations.
- **Create Shared Bins**: Users can collaborate by creating shared bins, allowing multiple users to add items and manage the recycling process together.
- **User-friendly interface**: The app features a simple, intuitive UI for seamless interaction.
- **Supabase Integration**: The app uses Supabase to store user data and manage item lists securely.

### Tech Stack
- **Flutter**: Used to build the cross-platform app (Web & Android).
- **Dart**: Programming language used for building the Flutter application.
- **Supabase**: Used as the backend for managing user data and item lists.
- **Provider**: For managing app-wide state (if added in future versions).

### Getting Started

1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/e-waste-hero.git
   cd e-waste-hero
   ```

2. **Install dependencies**:
   Make sure you have Flutter installed on your machine. Then run:
   ```bash
   flutter pub get
   ```

3. **Run the app**:
   Run the following command to launch the app:
   ```bash
   flutter run
   ```

### Features Implementation

- **BinScreen**:
  - Displays the current list of items in the user's bin, stored in Supabase.
  - Items can be added, removed, or quantity adjusted. Changes are reflected in the Supabase database.
  
- **Adding Items**:
  - Users can add items by pressing the "Add to Bin" button, which opens a dialog for entering the item name and quantity. The new item is stored in Supabase.

- **Item Management**:
  - Items are added to the bin as `Item` objects and displayed in a list with options to increase or decrease the quantity.
  - All changes to the bin are synced with Supabase.

- **Item Removal**:
  - Items can be deleted from the bin, and the deletion is reflected in Supabase.

- **Find Nearby Locations**:
  - The app allows users to search for nearby e-waste recycling centers, helping them easily find locations to drop off their items.
  
- **Bin Value Estimation**:
  - The app provides an approximate value for the contents of the bin. In the future, AI will be integrated to provide more accurate price estimations based on the type and quantity of e-waste.

- **Create Shared Bins**:
  - Users can create shared bins, allowing multiple people to add items to a collective recycling effort.

### Supabase Integration

To manage items and user data, Supabase is used as the backend service. It provides:
- **Authentication**: Secure user login and registration.
- **Database**: Storing items in the e-waste bin.
- **Realtime**: Syncing item changes in real-time across devices.

### Future Improvements
- **AI Integration**: For more accurate price estimation based on the type of e-waste in the bin.
- **User Authentication**: Add email/password or social media authentication using Supabase's auth features.
- **Data Persistence**: Currently, the app uses Supabase for data storage, ensuring persistence across sessions.
- **Advanced Filtering**: Implement filtering and sorting for bin items based on categories, dates, or quantity.

### Contributing

We welcome contributions! If you'd like to contribute to the development of **E-Waste Hero**, please fork the repository and submit a pull request with your changes.
