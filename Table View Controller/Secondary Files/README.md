#  Table View Controller
---
CoreData Model 'Country' :

    @NSManaged public var countryDescription: String
    @NSManaged public var euMember: Bool
    @NSManaged public var flagPath: String
    @NSManaged public var gdp: Int64
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var name: String


## if new installation:

`CoreDataAssistant.userDefaults.value(forKey: "CountriesAreInitialised")` is false, and 
`initCoreData(context: CoreDataAssistant.context)` is called from `didFinishLaunchingWithOptions`

`for image in imageNames` loops through the Assets' images (the flags) and :
1. load image as UIImage
2. create a path .../imageName.png
3. turn image to Data (png)
4. creates a file at the path with the contents of imageData

Then calling the `saveFlagPath(for: imageName <String>, imagePath: imagePath <URL>)`

> This func assigns the imagePath to flagPaths[country] (is a Dictionary in the FileAssistant class),
>
>then creates a path with `flagPaths.plist`,
>then turns the flagPaths into NSDictionary,
>and then writes this NSDictionary into the `flagPaths.plist`
>
>! Overall: I got one 'working' flagPaths[String: URL]  and one flagPaths.plist for Persistance. the .plist is saved as NSDictionary ( [String: URL]) and loads as NSDictionary[String: String], and then with a for loop assigns its contents to self.flagPaths as [String: URL]...
>
>// **Why not loading directly [String: URL] ?**


So, the `for imageName in imageNames` loads the image, creates a pth for the .png of each image, turns the loaded image to png, creates a file at this imagePath with the png and then saves the path to the 'working' flagPaths and in the .plist 

Then we call the initialisers of 'Country ' within the countries Array, batch them together and try to save them in the CoreData with `try context.execute(bathInsert)`
in the same *try* we set (create) a Bool `forKey: "CountriesAreInitialised"` to the userDefaults and set it to true. This acts as a controller, in next App launch we check if this Bool is true in the AppDelegate :: `didFinishLaunchingWithOptions`
and we avoid loading again these first Countries. 
