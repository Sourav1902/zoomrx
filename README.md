Solutions for ZoomRx DevSecOps Challenge

#1 Ansible playbook

The solution is in playbook-mysql.yaml The playbook serves the requirements asked in the question and suffices for both digital ocean links. Playbook once run, prompts for admin and db user password to be used for setup. The password can alternatively be configured to be provided from a var file or with ansible vaults as well in prod like environment.

I tested a run on newly created Ubuntu 20.0.4 VMs.

Execution -> ansible-playbook finaldraft -e 'ansible_python_interpreter=/usr/bin/python3'

Verified functionality by running the below commands as explained in the provided links-

sudo mysqladmin -p -u sammy version
mysql -u sammy -p
SELECT @@datadir;

#2 The script accepts the log directory path, rotate by size or not, and rotate by time or not arguments and zips the file accordingly with the timestamp appended.

sh log-rotation.sh /home/azure-user/ size time

It will zip all files older than 24 hours as well as any file larger than 5 MB. We can choose to use only one of these parameters by passing any input other than "size" or "file" at the respective places.

#3 The complete chapter is very detailed. Below is my understanding of the chapter until I could cover in the given time frame. However, I do understand the jist of DB replication as a concept now, and the configuration of Binary log file position based replication.

Solution

The chapter provides an introduction to MySQL DB replication and further discusses how to configure different replication configurations. It further explains replication formats, channels, and threads. The section also provides notes on using replication for specific solution types.

Database replication in general is process of copying data from a primary database to one or more replica databases. Few of the advantages being -

Scale-out solutions: Spreading the load among multiple replicas to improve performance.
Data security: Source data will stay secluded and backups, etc. can run on replicas.
Analytics: Replicas can be used for data analysis while not interfering with the primary server.
Long-distance data distribution: Can aid in the reduction of latency for end users across multiple locations.

3.1 **Configuring different types of replication:

3.1.1 **Binary Log File Position-Based Replication Configuration

The source and replicas must be configured with a unique ID (using the server_id system variable). Each replica must be configured with information about the source's host name, log file name, and position within that file.
The Source writes updates and changes as "events" to the binary log
Replicas are configured to read the binary log from the source and to execute the events in the binary log on the replica's local database.
You cannot configure the source to log only certain events. Each replica receives a copy of the entire contents of the binary log. It is the responsibility of the replica to decide which statements in the binary log should be executed.
Each replica keeps a record of the binary log coordinates.

3.1.2 **To setup Binary log file position based replication configuration

Setup a unique server ID and enable binary logging.
Create a user for replication.
Obtain the replication source's binary log coordinates.
Choosing a Method for Data Snapshots - If your database is stored in binary portable files, you can copy the raw data files to a replica or Use the mysqldump tool to create a dump.
Set up a replica - > Set a unique server id, Set source config (master hostanme, user, passwd etc), start replication thread


3.1.3 **Replication with Global Transaction Identifiers (GTI)

Transaction-based replication using global transaction identifiers.When using GTIDs, each transaction can be identified and tracked as it is committed on the originating server and applied by any replica.
