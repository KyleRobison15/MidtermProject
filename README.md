# brewBuds - The thirst quenching, social beer app.

## Authors
Each author participated as co-developers on this project and worked on every single part of the code base.

Matthew Lee: Software Engineer / Scrum Master
Chris Riddle: Software Engineer / DevOps
Kyle Robison: Software Engineer / GitHub Repository Owner
Thomas Stagnaro: Software Engineer / Database Administrator

## Application Overview
brewBuds is a social web application for beer lovers. Both die-hard beer connoisseurs and casual beer drinkers alike can view and rate beers that have been posted to the site.

A key feature of the brewBuds app is the ability for users to gain reputation by adding new beers. Once a beer has been added, that beer gets assigned to the user who added it and other users can now post reviews about that beer and rate it. A user's rating is then based on the average ratings of all the beers they have posted. Users also have what we call "Merit" which is the total number of ratings all their beers have received. In other words, the higher a user's merit, the more credible their rating. Lastly, users earn better badges as their rating improves and they progress through the brewBuds ranks - Apprentice (0 - 0.99 rating), Shift Brewer (1 - 1.99 rating), Production Brewer (2 - 2.99 rating), Head Brewer (3 - 3.99 rating) and Brew Master (4 - 5 rating).

More casual beer drinkers can use the app to simply find beers to try. Each beer has a comprehensive profile that shows its description and several other details such as the beer's brewery, bitterness (IBU), color, and overall rating. When a user tries a beer, they can post a review, give it a rating and add it to their favorites list if they enjoyed it. Users can later revisit their review, and update or delete it. Breweries also gain reputation based on the average rating of the beers that have been posted by brewBuds users. This allows users to find better beers by searching for breweries with a high rating.

Each registered user has a public brewBuds profile that shows the list of beers they've added and their brewBuds ranking. Users can then view other user profiles allowing them to see the beers those users have added. This allows users to identify other profiles that have a high brewBuds ranking in order to find more delicious beers to try. Users can also customize their account by changing their profile photo and account details.

## Agile Development Framework
In order to implement effective practices for a constructive and efficient sprint and overall project, Agile methodology was used.

Before any code was created and implemented, the Team collaborated on project ideas. Once the idea for brewBuds was conceived, the Team then began planning the sprint to lay out Tasks needed to achieve a minimum viable product, who would be assigned these Tasks, and the order in which they would be done in. Lastly, Testing methods were designed - no Task can be sent into Production without passing. The documentation of these Tasks were placed on a Kanban Board - specifically Trello.

During the sprint, daily Stand-up Meetings were conducted each Morning. The Scrum Master asked each Team Member
1. What that Team member accomplished since the last meeting
2. What is currently being worked on
3. Any difficulties they are experiencing

When each Task was completed, it went from the "In Progress" section of Trello to "In Test". As stated above, Tasks had to pass testing before being placed into "Done".

When the team felt we had achieved a minimum viable product, we were then able to work on a few extra features for the app that really took it above and beyond. Lastly, the Team met for a final Sprint Review and a complete and comprehensive walkthrough was done to rehearse presentation and as a final test of site functionality. Once done, the final code base was built into a WAR File and deployed to an AWS Server for public release.

## Technologies Used
* Java
* SQL
* Spring MVC and Spring Boot
* Java Persistence API (JPA)
* MySQL and MySQL Workbench for Database Schema Design
* HTML, CSS, and Bootstrap Front End Framework
* Java Server Pages and Standard Tag Libraries (JSP and JSTL)
* GitHub
* Trello
* Slack
* Zoom
* Discord
* Google Docs

## Lessons Learned
### Agile methodology is very effective.
Using this methodology, our team was able to stay on track and build an application we are all proud of in just one week!

### Understand what minimum viable product is for this sprint.
It's great to be ambitious, but it was so important to keep in mind we only had one week to build this thing. We all worked out what core functionalities needed to be in place for a minimum viable product and derived our daily tasks from that.

### Write clean and readable code. Code is read more often than it's written!
As mentioned, every member of the team worked on every part of the code base. As a result, is was essential for productivity that everyone structure their code in a way that was easy to read and left comments often.

### Invest a lot of time in app design during early stages of development.
The design process from the start of the development process is so so important, as it serves as the foundation for the rest of the sprint. It was important for everyone on the team to have a shared vision of how we wanted the application to work from the outset. From there we worked very hard on getting the database schema and Java entities absolutely correct and thoroughly tested with JUnit before moving on to any of the next steps. This payed huge dividends during the middle and later stages of the sprint.

### Communication and Collaboration is key.
Every part of a dynamic web application has to work in sync. As a result, it was absolutely essential to communicate effectively with each other to keep continuity within the code base. In addition I think our team learned a lot about reaching out for help when needed and speaking up about things we disagreed with or ideas we had. All these things were critical in getting to the finish line with a great product.

### Take breaks and recharge the batteries.
We all worked endlessly on this application throughout the week. There were many times we would try to push through a road block but would get stumped because we were simply exhausted from the day. When those situations arose, it was helpful to step away for a bit. Whether is was 10-15 minutes or longer, it helped immensely to regroup and tackle the problem with more clarity.
