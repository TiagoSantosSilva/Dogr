# Dogr

### What was done

For the purpose of the test, everything was done.

But there were still some improvements that were done and others that would eventually be done if this was a ready for production app.

However, since this is a test where the most important thing is to verify the candidate's knowledge I think it's fair to assume that this should be more than enough material.

**Note:** You will notice that the app's screenshots are in dark mode. The app does however support light mode too. Just change the appearance of the device and the app will follow.

### Screens

#### 1 - List of Breeds 📄

- The app loads the list of breeds and displays it.
- Has error handling — one of the improvements to the app would be to have a screen to display when the list of breeds comes as empty and another screen to display when the request fails to retrieve data.

<img src="https://user-images.githubusercontent.com/23014633/209751463-04ca3ec8-adb2-4ad0-a9bb-f390a55dfc85.png" width="320">

### 2 - Breed Pictures 📸

- The app displays a collection view with the pictures available for this breed.
- Each cell contains an image view that has the picture and the like button.
- Tapping the like button marks the image as *favorite*. Tapping it again makes it no longer a *favorite*.
- Once again, this screen should handle errors better — it should have a default image that the cell will display to signal that said picture was not able to be loaded and also a screen to be displayed when there isn't a picture list to fetch images from.

<img src="https://user-images.githubusercontent.com/23014633/209751768-4466b3fe-0c88-4f5d-94b5-2b165470fc6e.png" width="320" >

### 3 - Favorite Pictures ✨

- Displays the pictures marked as favorite.
- The pictures are separated by breed.
- The breeds are ordered alphabetically in an ascendent order.
- When there are no favorites selected a view informing that there are no favorite pictures yet is displayed.
- Has a navigation bar button to open the **Filter** screen.
- This button indicates whether or not a filter is currently being applied.

Empty State | With Items | Filter applied
:-----:|:-----:|:-----:
<img src="https://user-images.githubusercontent.com/23014633/209752608-95b909a8-f864-4d20-aa84-cb9135af7865.png" width="320"> | <img src="https://user-images.githubusercontent.com/23014633/209752650-8cfe9469-b5b6-44c5-b509-eb9b88dd5371.png" width="320"> | <img src="https://user-images.githubusercontent.com/23014633/209752689-10989ae2-af67-445f-9d4a-256e60d8f05e.png" width="320">

### 4 - Favorite Filter 🛍️

- Lists the current breeds that are favorited and listed.
- Allows the user to select one breed to be displayed only.
- Once the user taps the **Done** button the Favorite Pictures screen filters the breeds in order to display only the one that the user chose.
- Has a **Reset** button that removes the currently applied filter.

Selected Filter | Unselected Filter
:-----:|:-----:
<img src="https://user-images.githubusercontent.com/23014633/209753071-d2fbd399-094d-46b4-93c5-acb6b5d5f524.png" width="320"> | <img src="https://user-images.githubusercontent.com/23014633/209753065-ac687c59-4df3-47b5-9b23-35ad314aa839.png" width="320">


## Tests

In order to showcase my knowledge in tests I added some Unit Tests to the app.

These tests cover the following classes:

- `BreedListCoordinator`
- `BreedListLoader`
- `BreedListViewModel`
- `FavoritesRepository

Once again, these are not the only tests that would have been done in a real-life app but due to time constraints I deem that's enough. 

With enough time UI/Snapshot tests would have been added too.

<img width="421" alt="Tests" src="https://user-images.githubusercontent.com/23014633/209753297-a06d8262-6013-4c16-a401-aeae86418817.png">
