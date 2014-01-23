## SMS Archive

This is a simple web application for importing and archiving SMS messages backed up from phones using the popular <a target="_blank" href="http://android.riteshsahu.com/apps/sms-backup-restore">SMS Backup & Restore</a> Android App.

Messages can be imported, viewed and searched from the <img src="/assets/local/icons/current/emails.png"> <a href="#!/main/db/db_message">Messages Grid</a>.

### Usage

#### Importing Messages

1. Open the <img src="/assets/local/icons/current/emails.png"> <a href="#!/main/db/db_message">Messages Grid</a>.
2. Click the <i>"Import Messages (XML)"</i> button.
3. Enter the unique number of the phone/device (i.e. <i>555-123-4567</i>).
4. Select the XML backup file created by <a target="_blank" href="http://android.riteshsahu.com/apps/sms-backup-restore">SMS Backup & Restore</a>.
5. Click the <i>Save</i> button. The import my take a few moments depending on size of the file and number of messages.

* You can import multiple times using multiple backup files and the system will automatically skip existing messages (for the same device phone number). 

* You can also import messages for as many different devices as you like by supplying different device phone numbers. The first time you import using new device phone number, you <i>"claim"</i> that number and no other users will be able to access it. If you attempt to import using a device phone number already in use by another user, you will receive a permission denied error and will have to pick a different number. The number can actually be any unique combination of numbers or letters.


#### Viewing Messages, Phones & Contacts

1. You can access all your imported messages from the <img src="/assets/local/icons/current/emails.png"> <a href="#!/main/db/db_message">Messages Grid</a>
2. You can access a listing of all the unique contacts from the <img src="/assets/local/icons/current/vcards.png"><a href="#!/main/db/db_contact">Contacts Grid</a> and view messages specific to an individual contact by following the Messages (<img src="/assets/rapidapp/icons/current/magnify-tiny.gif">) link associated with each contact row.
3. You can view all the different devices/phones you've imported messages for from the <img src="/assets/local/icons/current/phones.png"><a href="#!/main/db/db_phone">Phones Grid</a> and access messages for specific phones by following the Messages (<img src="/assets/rapidapp/icons/current/magnify-tiny.gif">) link of each phone. You can also view contacts specific to individual phones by following the Contacts (<img src="/assets/rapidapp/icons/current/magnify-tiny.gif">) link.
4. In any grid you can type to search in the Quick Search (top-right) box or setup specific Filters (bottom-right).
5. You can customize other properties of grid views (columns, widths, etc) along with Filters and save the view to be able to access again later by clicking <img src="/assets/rapidapp/icons/current/save_as.png"><i>Save Search</i> from the <img src="/assets/rapidapp/icons/current/gears.png"><i>Options</i> menu (top-left). The saved search will show up under <img src="/assets/rapidapp/icons/current/folder_view.png"><i>My Views</i> in the navigation tree on the left.
6. You can also export the data in any grid to an Excel file (*.xlsx) by clicking <img src="/assets/rapidapp/icons/current/page_excel.png"><i>Excel Export</i>, also in the <img src="/assets/rapidapp/icons/current/gears.png"><i>Options</i> menu.

### Built using RapidApp

This app was built as a demo for RapidApp after a friend asked me to help him access old SMS messages in an XML backup file in a human-friendly manner. Rather than do this in a one-off script, I decided to write it as a reusable web app to show off some of RapidApp's features and speed of development.

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


### Source Code

The full source of this application is available <a target="_blank" href="https://github.com/IntelliTree/RA-SmsArc">on Github</a>.

Also see <a target="_blank" href="http://www.rapidapp.info">www.rapidapp.info</a> for more information.

### Author

Henry Van Styn <br>
<vanstyn@intellitree.com>