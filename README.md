# HelloRecipe 

Simple tableview scroller for cooking receipts loaded dynamically from static/recipts.json 

### Some implementation notes follow.


## Implementation Details

* Favoriting and Ranking recipts is only possible after login (even if fictious)
* After logging out, data structures containing User data get deallocated

## In-Memory Storage

* Data coming from the JSON file (recipts.json) gets deserialized and populated into Recipt objects at the time of app launch (Invoked on AppDelegate didFinishLaunchingWithOptions)
* Data is maintained throughout app usage with the use of static variables inside class definitions (Recipt, User)
* This is the best approach I could think of, not having any persistent storage (I though about using CoreData, but too little time)

## Design Methodologies / Patterns

### Singleton Pattern (Modified)

* User instance (upon login, and while logged). Useful to invoke nullable instance method upon attempts to change ratings/favorite status -> User gets redirected to the login page in case we don't have the user object.

* Receipt Dictionary (inside Receipt class, statically defined)

### Observer Pattern

* Through the use of Swift vocabulary "didSet" on variable definitions, inside these closures, for data corresponding to multiple UI parts in real time (e.g static Dictionaries in the User class), I invoked delegate references.

### Delegation Pattern

* All delegates defined statically in the User Class, as this is the class with object (singleton) responsible for UI changes (in different tabs of the app)

* Delegates invoked as response to attribution events on vars: favorites, ratings (Dictionaries with user data)
* Delegates also invoked upon tabBarController(:,:didSelect viewController) to sort tableViewCells in case of controller's change (more info on  HelloTabBarController implementation)

## UI Notes

* ISSUE - Orienation Landscape and Keyboard showing overlaps login UITextFields
* Super simple login interface. Error messages are presented on a UIAlertController by lack of useful time.
* Details such as ingredients list an so on could be presented further modally like in the HelloFresh App, but I guess that was not the idea of the assignment (accounting for the 4 hours planned to implement)
* I'm very acquainted (and creative) with developing smooth interfaces - when I have the time. Check my AlbumFolks project for a simple yet functional interface [here](https://github.com/carloscorreia94/AlbumFolks)

## Pods Used

* FloatRatingView - Easy as 1 2 3 Rating Control view (was already to late to implement my own)
* ObjectMapper - I used this Pod at all times (before I was fond of SwiftyJSON), saves me hours of work deserializing JSON contents.
* Kingfisher - Don't have to worry about imageDownload/caching -> Simple as providing user URL

### Notes on ObjectMapper

* I do fallback validation on the init method, so I'm certified I don't get nil values on the map function. Super handy, as I don't have to worry after I get results from MapArray (only adds elements to the Array if they pass through failable Mappable initializer)
 [See more here](https://github.com/Hearst-DD/ObjectMapper#the-basics)

## Testing

* UI Testing not covered
* Unit testing only tests behavior on the developed domain logic (in memory data)
* Unit Testing could have included sorting tests for different rating scenarios (I'm pretty sure I have some bug here, but my head is about to explode without sleep! :-) )
* I didn't test devices and orientation exaustively - I notice some handicap on the bottom insets of the tableView when changing orientations

## Too much time? (I took about 6-7 hours total)

I considered necessary the time I took to complete this task. Firstly (to excuse me  ((: ) , I'm still suffering from my current work situation at the time of this implementation. Furthermore, I wanted to make sure, despite the poor interface developed, that I matched the description of the problem presented, **testing my code skills, going on the detail with a good overall architecture**.
