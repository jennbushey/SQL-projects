# Circus Database

[![Database](https://img.shields.io/badge/database-MySQL-green.svg)](https://www.mysql.com/)

The objective of this project is to apply your understanding of course concepts, database design, and SQL queries on a real-world database application.

Project from ENSF 608 Fall 2023 - narrative and prompts created by Dr. Marasco, database, queries, ER diagram, and relational model were created by Mehreen Akmal, Jenn Bushey, Eric Diep, and Hao Liu in December 2023.

## Assignment

### Conceptual Database Design:

Based on the provided requirements narrative, design and draw an [EER diagram]() for the described database application.

### Logical Database Design and Creation Code:

Map your conceptual schema into a [relational data model](), including all primary keys and referential integrity constraints (foreign keys). Then use your relational model to create a [.sql script]() that could be used by someone else to initialize and populate your database. You are free to create your own example data that aligns with the narrative.

### Query Code

Include a [.sql file]() that contains the queries listed below:

1. Show all tables and explain how they are related to one another (keys, triggers, etc.)
2. A basic retrieval query
3. A retrieval query with ordered results
4. A nested retrieval query
5. A retrieval query using joined tables
6. An update operation with any necessary triggers
7. A deletion operation with any necessary triggers

## Question Narrative

Large travelling performance companies, such as Cirque du Soleil, have a variety of performers, venues, and itineraries to consider. This information needs to be stored in a logical way that allows producers to access information quickly and effectively. For this project, you will model and implement a sample database that could be used to store and access the necessary information. Consider the elements of the functionality and how they interact with one another. Your design may be different from others- you have flexibility in how you choose to meet the requirements of the client. You may assume that only the aspects described below need to be considered.

Your client is Cirque du Soleil. Cirque du Soleil has several different travelling shows such as Alegria, Kooza, and Corteo, so they need to track information for all of them. Each show is identified by a combination of its name and its performance year (e.g. “Corteo” and “2006”). Each show has a sponsor and a producer.

Shows are hosted by venues, with a date and location assigned to each hosting. The stored venue information includes a unique numeric ID, the name of the venue, its capacity, address (street address,
city, province/state), and whether it is accessible by transit (Y/N). Since the shows move around, a show can be hosted by multiple venues, and venues may host more than one show.

Performers are assigned to a specific show. The stored performer information includes a unique numerical ID, name (first and last name), citizenship, birthdate (use SQL date object), list of medications, and any special diet information (e.g. vegan, high protein, etc.). All performers can be classified as either a musician, aerialist, or entertainer. Each musician may play multiple instruments- all of their instruments should be list in the database. The database should track the sport and equipment of each aerialist, as well as the main act of each entertainer. Performers may have another performer listed as their understudy.

Cirque du Soleil can be a dangerous show given the aerial acrobatics. All performers also have one emergency contact listed, which includes their name (first and last), phone number, and relationship to
the performer.

## Design Decisions

-   Entities: SHOW, PERFORMER, VENUE, and EMERGENCY CONTACT
-   A PERFORMER must be classified as one of the three: Aerialist, Musician, or Entertainer.
    Therefore, this is total disjoint.
-   EMERGENCY CONTACT – weak entity because it has an identifying relationship with PERFORMER
    and has no unique key attributes (Name or phone-number is not unique).
-   EMERGENCY CONTACT to PERFORMER is a total participation relationship because each
    PERFORMER must have an emergency contact.
-   To deal with the many-to-many relationship between SHOW and VENUE, HOSTS becomes a
    relationship relation with attributes Date and Location.
-   The SHOW and PERFORMER relationship is total participation. SHOW cannot exist without any
    performers and the PERFORMER cannot exist without being assigned a SHOW.
-   If an update is performed changing the venue to have a capacity of less than 300, a trigger
    displays an error message, and the update is not performed.
-   When adding a performer, a trigger is set to display a message that a certification is required

## Assumptions

-   Diet is not multi-valued- each performer only has 0 or 1 diet restriction.
-   Location attribute in HOSTED refers to room in venue so it is different than the address listed on
    the venue.
-   A show can only exist when it has at least one performer
-   Every PERFORMER has a different EMERGENCY CONTACT. An EMERGENCY CONTACT is only
    linked to one PERFORMER
-   The venue capacity cannot be less than 300 (Corresponds update operation)
-   SHOW to VENUE is total participation as a show must be hosted at a venue, while VENUE to
    SHOW is partial participation since a venue doesn't need to host a show.
