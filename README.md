# NOTES ON UPGRADING KAMAILIO FROM 5.5 to 6.0

## Output of corex.list_sockets changes from UPPERCASE to lowercase

```
Nov 19 2019 with gcc 7.3.1
[root@aio1 kamailio]# kamcmd corex.list_sockets
{
        PROTO: udp
        NAME: 10.1.1.41
        ADDRLIST: {
                ADDR: 10.1.1.41
        }
        PORT: 5060
        MCAST: no
        MHOMED: no
        ADVERTISE: -
}
```
to
```
 kamcmd corex.list_sockets
{
        af: IPv4
        proto: udp
        name: 10.1.1.14
        addrlist: {
                addr: 10.1.1.14
        }
        port: 5060
        sockstr: udp:10.1.1.14:5060
        agname: none
        mcast: no
        mhomed: no
        virtual: no
        sockname: -
        advertise: -
}
```

SO need to change:

```
 git diff nodes-role.cfg
diff --git a/kamailio/nodes-role.cfg b/kamailio/nodes-role.cfg
index 7eebb8c..df510f5 100644
--- a/kamailio/nodes-role.cfg
+++ b/kamailio/nodes-role.cfg
@@ -252,10 +252,10 @@ route[LISTENER_STATUS]
     $var(listeners) = "";
     while( $var(loop) < $var(count) ) {
        $var(listener) = $(jsonrpl(body){kz.json,result[$var(loop)]});
-       $var(proto) = $(var(listener){kz.json,PROTO});
-       $var(address) = $(var(listener){kz.json,ADDRLIST.ADDR});
+       $var(proto) = $(var(listener){kz.json,proto});
+       $var(address) = $(var(listener){kz.json,addrlist.addr});
        if($var(address) != "127.0.0.1") {
-           $var(port) = $(var(listener){kz.json,PORT});
+           $var(port) = $(var(listener){kz.json,port});
            if($var(port) == "WS_PORT") {
               $var(proto) = "ws";
            }
```

## SQL TABLE htable is altered [https://www.kamailio.org/wikidocs/install/upgrade/5.8.x-to-6.0.0/]

So need to change:

```
psql -U kamailio -d postgres://kamailio:kamailio@127.0.0.1/kamailio

kamailio=> ALTER TABLE htable ALTER COLUMN key_name TYPE VARCHAR(256);
kamailio=> ALTER TABLE htable ALTER COLUMN key_value TYPE VARCHAR(512);
```

Also need to update db_script for new installs:

git diff db_scripts/kamailio_initdb_postgres.sql


 CREATE TABLE public.htable (
     id integer NOT NULL,
-    key_name character varying(64) DEFAULT ''::character varying NOT NULL,
+    key_name character varying(256) DEFAULT ''::character varying NOT NULL,
     key_type integer DEFAULT 0 NOT NULL,
     value_type integer DEFAULT 0 NOT NULL,
-    key_value character varying(128) DEFAULT ''::character varying NOT NULL,
+    key_value character varying(512) DEFAULT ''::character varying NOT NULL,
     expires integer DEFAULT 0 NOT NULL
 );


## Lots of postgres/presence ERRORS just when idle

```
Jul 24 09:52:31 debian12-kazoo kamailio[1752733]: ERROR: presence [notify.c:3206]: pres_timer_send_notify(): Handling non presence.winfo dialogs
Jul 24 09:52:31 debian12-kazoo kamailio[1752733]: ERROR: db_postgres [km_dbase.c:546]: db_postgres_query_lock(): transaction not in progress
Jul 24 09:52:31 debian12-kazoo kamailio[1752733]: ERROR: presence [notify.c:2926]: process_dialogs(): in sql query
Jul 24 09:52:31 debian12-kazoo kamailio[1752733]: ERROR: presence [notify.c:3206]: pres_timer_send_notify(): Handling non presence.winfo dialogs
Jul 24 09:52:31 debian12-kazoo kamailio[1752733]: ERROR: db_postgres [km_dbase.c:546]: db_postgres_query_lock(): transaction not in progress
Jul 24 09:52:31 debian12-kazoo kamailio[1752733]: ERROR: presence [notify.c:2926]: process_dialogs(): in sql query
Jul 24 09:52:31 debian12-kazoo kamailio[1752733]: ERROR: presence [notify.c:3206]: pres_timer_send_notify(): Handling non presence.winfo dialogs
Jul 24 09:52:31 debian12-kazoo kamailio[1752733]: ERROR: db_postgres [km_dbase.c:546]: db_postgres_query_lock(): transaction not in progress
Jul 24 09:52:31 debian12-kazoo kamailio[1752733]: ERROR: presence [notify.c:2926]: process_dialogs(): in sql query
Jul 24 09:52:31 debian12-kazoo kamailio[1752733]: ERROR: presence [notify.c:3206]: pres_timer_send_notify(): Handling non presence.winfo dialogs
Jul 24 09:52:31 debian12-kazoo kamailio[1752733]: ERROR: db_postgres [km_dbase.c:546]: db_postgres_query_lock(): transaction not in progress
Jul 24 09:52:31 debian12-kazoo kamailio[1752733]: ERROR: presence [notify.c:2926]: process_dialogs(): in sql query
Jul 24 09:52:31 debian12-kazoo kamailio[1752733]: ERROR: presence [notify.c:3206]: pres_timer_send_notify(): Handling non presence.winfo dialogs
Jul 24 09:52:31 debian12-kazoo kamailio[1752733]: ERROR: db_postgres [km_dbase.c:546]: db_postgres_query_lock(): transaction not in progress
Jul 24 09:52:31 debian12-kazoo kamailio[1752733]: ERROR: presence [notify.c:2926]: process_dialogs(): in sql query
Jul 24 09:52:31 debian12-kazoo kamailio[1752733]: ERROR: presence [notify.c:3206]: pres_timer_send_notify(): Handling non presence.winfo dialogs
Jul 24 09:52:31 debian12-kazoo kamailio[1752733]: ERROR: db_postgres [km_dbase.c:546]: db_postgres_query_lock(): transaction not in progress
Jul 24 09:52:31 debian12-kazoo kamailio[1752733]: ERROR: presence [notify.c:2926]: process_dialogs(): in sql query
```

After some digging decided to change the subs_db_mode in presence-role.cfg


```
 git diff presence-role.cfg

-modparam("presence", "subs_db_mode", 3)
+modparam("presence", "subs_db_mode", 2)


-modparam("presence", "db_update_period", 0)
+modparam("presence", "db_update_period", 2)

```
