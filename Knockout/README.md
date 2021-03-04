Design pattern :
Singleton

Architechture :
MVVM

Database : 
CoreData

Unit Test :
FixtureManager (Logic for random Teams selection and elimination)
KnockoutTests.swift

App Feature :

`Static content` : - It would display the static contents thats inside ViewModel

`Database content` : It would display the content which is stored inside the CoreData

`Add Team` : Add team to CoreData  and app can display that content inside `DataBase content`, after adding content swipe to dismiss the screen.


Notes : Clearing DB data when app is terminated or it gets in the background

How it works :

e.g. ["First", "Second", "Third", "Fourth", "Fifth", "Sixth", "Seventh", "Eighth"] that would make 4 Team Pairs
After first elimination 2 Teams would get eliminated (Half of total Paired Teams)
After second elimination 1 Team would get elimniated (Half of total Paired Teams)
In the last only 1 Team will win.
