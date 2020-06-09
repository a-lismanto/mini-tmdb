# mini-tmdb

![](./assets/demo.gif)

## Prepare Project
You'll need XCode (Obviously) that support UISwift, prefered v11.5.

## Run Project
Open Project using `.xcworkspace` file and simply Run it in iOS simulator.
If you want to run it in device, you need to have provisioning profile for that and use it in this project. Visit [here for detailed explanation](https://developer.apple.com/documentation/xcode/running_your_app_in_the_simulator_or_on_a_device).


## Using
### Movie List Screen
Once you successfully run the project, you'll see Movie List Screen.
From here you can select which movie list you want to see. Currently app can show you Popular, Top Rated, and Now Playing, with Popular being the default).
Tapping on one of the movie list will take you to Movie Detail Screen.
There's also `My Favorite` button on top right that will tak you to Favorite Movie List Screen.

### Movie Detail Screen
You can see full overview of the movie and reviews of this movie if any.
The heart button on topt right of movie overview will allow you to favorite / unfavorite this movie.
White heart indicates this movie is not in your favorite list, Filled heart (black heart) indicates otherwise.

### Favorite Movie List Screen
Here you will see list of movie that you added to favorite from Movie Detail Screen.
Tapping on one of the movie list will take you to Favorite Movie Detail Screen.
You can unfavorite a movie by swiping left on that movie row and press delete.

### Favorite Movie Detail Screen
Basically like Movie Detail Screen, but once you unfavorite a movie, you'll be taken back to Favorite Movie List Screen

*IMPORTANT NOTE: You need working internet connection for loading  Popular list, Top Rated list, Now Playing list, loading Movie poster, and movie reviews.*
