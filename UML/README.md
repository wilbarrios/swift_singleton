# Code basic diagrams, UML

Communication tool for ourselves and other developers in the team, and documentation, and makes easy to see dependency between modules and visual identification of potential memory leaks.

## CodeDiagrams project

Single class was created on this proyect called `FeedViewController`. This is represented like this:

![diagram_1](diagrams/diagram_1.png)

This class is destinated to make a screen representation for iOS platform, so, we added the inheritance from `UIViewController`:

![diagram_2](diagrams/diagram_2.png)

The dependency of an interface (`protocol` in swift) like FeedLoadable on this example, should be like this.

![diagram_3](diagrams/driagram_3.png)

A `FeedLoadable` implementation were added, as `RemoteFeedLoader` to fetch data. (i.e. Url session to make a HTTP request). In this example, `RemoteFeedLoader` conforms to `FeedLoadable` protocol.

![diagram_4](diagrams/driagram_4.png)

`LocalFeedLoader` implementation added, to conform `FeedLoadable`, thats the advantage of usign protocol, so the view controller, does not have to know where the data is from.

![diagram_5](diagrams/driagram_5.png)
