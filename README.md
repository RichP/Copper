#  Copper.io

## ⚽️ Goals

Pull in a large amount of records from the network and store in CoreData without stalling the UI thread.


## 🚧 Usage
Sample uses NSBatchInsertRequest which inserts directly at the sqlite layer and avoids all CoreData processing.
Also uses the @FetchRequest wrapper in order to display all the records.

## ⚠ Warning
This sample does break MVVM by using the FetchRequest wrapper provided by Apple which makes the Fetch request a combine observable object.
This could be tidied up by using an SFetchResultsController inside the Model layer however it wouldn't be as efficient.
