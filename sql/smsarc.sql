DROP TABLE IF EXISTS [phone];
CREATE TABLE [phone] (
  [id] varchar(32) PRIMARY KEY NOT NULL,
  [name] varchar(64) DEFAULT NULL
);

DROP TABLE IF EXISTS [contact];
CREATE TABLE [contact] (
  [number] varchar(32) PRIMARY KEY NOT NULL,
  [full_name] varchar(64) DEFAULT NULL
);

/* http://android.riteshsahu.com/apps/sms-backup-restore */
DROP TABLE IF EXISTS [message_type];
CREATE TABLE [message_type] (
  [id] INTEGER PRIMARY KEY NOT NULL,
  [name] varchar(64) DEFAULT NULL
);
INSERT INTO [message_type] VALUES ('1','Received');
INSERT INTO [message_type] VALUES ('2','Sent');
INSERT INTO [message_type] VALUES ('3','Draft');
INSERT INTO [message_type] VALUES ('4','Outbox');
INSERT INTO [message_type] VALUES ('5','Failed');
INSERT INTO [message_type] VALUES ('6','Queued');


DROP TABLE IF EXISTS [message];
CREATE TABLE [message] (
  [id] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  [phone_id] varchar(32) NOT NULL,
  [timestamp] DATETIME NOT NULL,
  [number] varchar(32) NOT NULL,
  [type_id] INTEGER NOT NULL,
  [read] INTEGER NOT NULL DEFAULT 1,
  [body] TEXT,
  FOREIGN KEY ([phone_id]) REFERENCES [phone] ([id]) 
   ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY ([number]) REFERENCES [contact] ([number]) 
   ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY ([type_id]) REFERENCES [message_type] ([id]) 
   ON DELETE NO ACTION ON UPDATE NO ACTION
);