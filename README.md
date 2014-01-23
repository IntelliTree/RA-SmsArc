## SMS Archive

This is a simple web application for importing and archiving SMS messages backed up from Android phones using the popular SMS Backup & Restore App (XML backup files).

Messages can be uploaded, viewed and searched from the Messages Grid.

### Built with RapidApp

This app was built as a demo for RapidApp after a friend of mine asked me to help him access old SMS messages in an XML backup file in a human-friendly manner. Rather than do this in a one-off script, I decided to write it as a reusable web app to show off some of RapidApp's features and speed of development.

I recorded the total time it took me to build the app with a simple breakdown of the tasks involved, which included the work to figure out and parse the XML format, create an SQL data model to store the message data, as well as a simple multi-user access and permissions model:


#### Time spent building this app (v1.0): ~ 8 hours

1. Model Design (50 mins)
    - prelim DDL: 27 min
    - create db + catalyst model: 3 min
    - DDL tweaks: 20 min

2. Biz Logic (192 mins)
    - RA::SmsArc::Parser: 32 mins
    - Import Model: 60 mins
    - Permissions: 100 mins

3. RapidApp configs (55 mins)
    - Base app setup: 10 mins
    - TableSpec config: 10 mins
    - CSS/design tweaks: 35 mins

4. Custom Interfaces (125 mins)
    - Import View (grid button): 35 mins
    - Import Controller: 90 mins
    - Custom icons: 5 mins