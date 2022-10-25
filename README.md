# zoomrx
Solutions for ZoomRx DevSecOps Challenge

#1 Ansible playbook
Solution is in playbook-mysql.yaml.
The playbook serves the requirements asked in question and suffices to both digital ocean links.

Playbook once run, prompts for admin and db user password to be used for setup.
The password can alternatively be configured to be provided from a var file or with ansible vaults as well in prod like environment.

Tested a run on newly created ubuntu 20.0.4 VMs.

#2
The script accepts log directory path, rotate by size or not, rotate by time or not arguments and zips the file accordingly with the timestamp appended.


#3
The complete chapter is very detailed, below is my understanding of the chapter until i could cover in the given time frame.

Solution

The chapter provides an introduction to mysql db replication, and further discusses about how to configure different replication configuraiton.
It further explains Replication formats, channels and threads. The section also provides notes on using replication for specific solution types.

Database replication in general is process of copying data from a primary database to one or more replica databases.
Few  of the advantages being -
* Scale-out solutions - Spreading the load among multiple replicas to improve performance. 
* Data security - Source data will stay secluded and backups etc can run on replicas
* Analytics - Replicas can serve for data analysis without affecting Primary server
* Long-distance data distribution - Can help with reducing latency for end ysers across locations



3.1 **Configuring different type of replications:

3.1.1 **Binary Log File Position Based Replication Configuration
 - The source and replicas must be configured with a unique ID (using the server_id system variable). Each replica must be configured with information about the source's host name, log file name, and position within that file.
 - Source writes updates and changes as “events” to the binary log 
 - Replicas are configured to read the binary log from the source and to execute the events in the binary log on the replica's local database.
 - You cannot configure the source to log only certain events. Each replica receives a copy of the entire contents of the binary log. It is the responsibility of the replica to decide which statements in the binary log should be executed
 - Each replica keeps a record of the binary log coordinates.

3.1.2 **To setup Binary log file position based replication configuration
  - Setup Unique server ID and Enable binary logging
  - Create a user for replication
  - Obtain Replication Source's Binary Log Coordinates
  - Choosing a Method for Data Snapshots - If your database is stored in binary portable files, you can copy the raw data files to a replica or Use the mysqldump tool to create a dump 
  - Set up replica - Set unique server id, Set source config (master hostanme, user, passwd etc), start replication thread


3.1.3 **3 Replication with Global Transaction Identifiers

Transaction-based replication using global transaction identifiers.When using GTIDs, each transaction can be identified and tracked as it is committed on the originating server and applied by any replicas.
