# exchange-2019-dag-lab
Home lab setup: Exchange 2019 DAG on Windows Server 2019 with AD DS

Layer            Role / Component                 Hostname / Name       IP Address         Description
---------------------------------------------------------------------------------------------------------------
Client           Outlook / OWA Client             Client PC/Laptop      192.168.10.x       Internal user accessing Exchange services.

DNS / AD         AD DS / DNS / FSW                WIN2019AD             192.168.10.50      Domain Controller, DNS Server, File Share Witness.

Exchange 1       Mailbox + Client Access          MSEX2019              192.168.10.62      Exchange 2019 server, member of DAG01.

Exchange 2       Mailbox + Client Access          WIN-EX2019            192.168.10.60      Exchange 2019 server, member of DAG01.

DAG Cluster      Database Availability Group      DAG01                 192.168.10.70*     Exchange HA cluster with 2 MBX nodes (IP-less DAG).

Mail Namespace   DNS Entry for Clients            mail.hk2uk.online     192.168.10.62      DNS Round Robin entry for Exchange access.
                                                     (A record)          192.168.10.60



                         ┌────────────────────────────────┐
                         │  Outlook / OWA / ActiveSync    │
                         └───────────────┬────────────────┘
                                         │
                                 DNS: mail.hk2uk.online
                                         │
                                         ▼
                 ┌────────────────────────┴────────────────────────┐
                 │                     LAN 192.168.10.0/24        │
                 └────────────────────────────────────────────────┘

        ┌─────────────────────────┐                 ┌─────────────────────────┐
        │     WIN2019AD           │                 │        DAG01           │
        │  192.168.10.50          │                 │  IP: 192.168.10.70*    │
        │  AD DS / DNS            │                 │  Members:              │
        │  File Share Witness     │◄───────────────►│   - MSEX2019           │
        │  C:\DAGFileShare...     │   Cluster Comm  │   - WIN-EX2019         │
        └───────────┬─────────────┘                 └─────────────┬──────────┘
                    │                                                   │
     AD / DNS Lookup│                                                   │DAG Replication
                    │                                                   │(Log Shipping)
        ┌───────────▼─────────────┐                         ┌───────────▼─────────────┐
        │       MSEX2019          │                         │      WIN-EX2019         │
        │  192.168.10.62          │                         │   192.168.10.60        │
        │  Exchange 2019 MBX/CAS  │                         │   Exchange 2019 MBX/CAS│
        │  DB1 (Active / Passive) │                         │   DB2 (Active / Pass.) │
        └─────────────────────────┘                         └─────────────────────────┘
