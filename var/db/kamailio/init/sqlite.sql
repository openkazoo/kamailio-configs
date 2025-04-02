PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE version (
    table_name VARCHAR(32) NOT NULL,
    table_version INTEGER DEFAULT 0 NOT NULL,
    PRIMARY KEY(table_name)
);
INSERT INTO 'version' VALUES('version',1);
INSERT INTO 'version' VALUES('acc',5);
INSERT INTO 'version' VALUES('acc_cdrs',2);
INSERT INTO 'version' VALUES('missed_calls',4);
INSERT INTO 'version' VALUES('dbaliases',1);
INSERT INTO 'version' VALUES('subscriber',7);
INSERT INTO 'version' VALUES('usr_preferences',2);
INSERT INTO 'version' VALUES('carrierroute',3);
INSERT INTO 'version' VALUES('carrierfailureroute',2);
INSERT INTO 'version' VALUES('carrier_name',1);
INSERT INTO 'version' VALUES('domain_name',1);
INSERT INTO 'version' VALUES('cpl',1);
INSERT INTO 'version' VALUES('dialog',7);
INSERT INTO 'version' VALUES('dialog_vars',1);
INSERT INTO 'version' VALUES('dialplan',2);
INSERT INTO 'version' VALUES('dispatcher',4);
INSERT INTO 'version' VALUES('domain',2);
INSERT INTO 'version' VALUES('domain_attrs',1);
INSERT INTO 'version' VALUES('domainpolicy',2);
INSERT INTO 'version' VALUES('dr_gateways',3);
INSERT INTO 'version' VALUES('dr_rules',3);
INSERT INTO 'version' VALUES('dr_gw_lists',1);
INSERT INTO 'version' VALUES('dr_groups',2);
INSERT INTO 'version' VALUES('grp',2);
INSERT INTO 'version' VALUES('re_grp',1);
INSERT INTO 'version' VALUES('htable',2);
INSERT INTO 'version' VALUES('imc_rooms',1);
INSERT INTO 'version' VALUES('imc_members',1);
INSERT INTO 'version' VALUES('lcr_gw',3);
INSERT INTO 'version' VALUES('lcr_rule_target',1);
INSERT INTO 'version' VALUES('lcr_rule',3);
INSERT INTO 'version' VALUES('matrix',1);
INSERT INTO 'version' VALUES('mohqcalls',1);
INSERT INTO 'version' VALUES('mohqueues',1);
INSERT INTO 'version' VALUES('silo',8);
INSERT INTO 'version' VALUES('mtree',1);
INSERT INTO 'version' VALUES('mtrees',2);
INSERT INTO 'version' VALUES('pdt',1);
INSERT INTO 'version' VALUES('trusted',6);
INSERT INTO 'version' VALUES('address',6);
INSERT INTO 'version' VALUES('pl_pipes',1);
INSERT INTO 'version' VALUES('presentity',5);
INSERT INTO 'version' VALUES('active_watchers',12);
INSERT INTO 'version' VALUES('watchers',3);
INSERT INTO 'version' VALUES('xcap',4);
INSERT INTO 'version' VALUES('pua',7);
INSERT INTO 'version' VALUES('purplemap',1);
INSERT INTO 'version' VALUES('aliases',8);
INSERT INTO 'version' VALUES('rls_presentity',1);
INSERT INTO 'version' VALUES('rls_watchers',3);
INSERT INTO 'version' VALUES('rtpengine',1);
INSERT INTO 'version' VALUES('rtpproxy',1);
INSERT INTO 'version' VALUES('sca_subscriptions',2);
INSERT INTO 'version' VALUES('sip_trace',4);
INSERT INTO 'version' VALUES('speed_dial',2);
INSERT INTO 'version' VALUES('topos_d',1);
INSERT INTO 'version' VALUES('topos_t',1);
INSERT INTO 'version' VALUES('uacreg',3);
INSERT INTO 'version' VALUES('uid_credentials',7);
INSERT INTO 'version' VALUES('uid_user_attrs',3);
INSERT INTO 'version' VALUES('uid_domain',2);
INSERT INTO 'version' VALUES('uid_domain_attrs',1);
INSERT INTO 'version' VALUES('uid_global_attrs',1);
INSERT INTO 'version' VALUES('uid_uri',3);
INSERT INTO 'version' VALUES('uid_uri_attrs',2);
INSERT INTO 'version' VALUES('uri',1);
INSERT INTO 'version' VALUES('userblacklist',1);
INSERT INTO 'version' VALUES('globalblacklist',1);
INSERT INTO 'version' VALUES('location',9);
INSERT INTO 'version' VALUES('location_attrs',1);
INSERT INTO 'version' VALUES('event_list',1);
INSERT INTO 'version' VALUES('active_watchers_log',1);
INSERT INTO 'version' VALUES('keepalive',4);
INSERT INTO 'version' VALUES('auth_cache',2);
INSERT INTO 'version' VALUES('block_cache',2);
CREATE TABLE acc (
    id INTEGER PRIMARY KEY NOT NULL,
    method VARCHAR(16) DEFAULT '' NOT NULL,
    from_tag VARCHAR(64) DEFAULT '' NOT NULL,
    to_tag VARCHAR(64) DEFAULT '' NOT NULL,
    callid VARCHAR(255) DEFAULT '' NOT NULL,
    sip_code VARCHAR(3) DEFAULT '' NOT NULL,
    sip_reason VARCHAR(128) DEFAULT '' NOT NULL,
    time TIMESTAMP WITHOUT TIME ZONE NOT NULL
);
CREATE TABLE acc_cdrs (
    id INTEGER PRIMARY KEY NOT NULL,
    start_time TIMESTAMP WITHOUT TIME ZONE DEFAULT '2000-01-01 00:00:00' NOT NULL,
    end_time TIMESTAMP WITHOUT TIME ZONE DEFAULT '2000-01-01 00:00:00' NOT NULL,
    duration REAL DEFAULT 0 NOT NULL
);
CREATE TABLE missed_calls (
    id INTEGER PRIMARY KEY NOT NULL,
    method VARCHAR(16) DEFAULT '' NOT NULL,
    from_tag VARCHAR(64) DEFAULT '' NOT NULL,
    to_tag VARCHAR(64) DEFAULT '' NOT NULL,
    callid VARCHAR(255) DEFAULT '' NOT NULL,
    sip_code VARCHAR(3) DEFAULT '' NOT NULL,
    sip_reason VARCHAR(128) DEFAULT '' NOT NULL,
    time TIMESTAMP WITHOUT TIME ZONE NOT NULL
);
CREATE TABLE dbaliases (
    id INTEGER PRIMARY KEY NOT NULL,
    alias_username VARCHAR(64) DEFAULT '' NOT NULL,
    alias_domain VARCHAR(64) DEFAULT '' NOT NULL,
    username VARCHAR(64) DEFAULT '' NOT NULL,
    domain VARCHAR(64) DEFAULT '' NOT NULL
);
CREATE TABLE subscriber (
    id INTEGER PRIMARY KEY NOT NULL,
    username VARCHAR(64) DEFAULT '' NOT NULL,
    domain VARCHAR(64) DEFAULT '' NOT NULL,
    password VARCHAR(64) DEFAULT '' NOT NULL,
    ha1 VARCHAR(128) DEFAULT '' NOT NULL,
    ha1b VARCHAR(128) DEFAULT '' NOT NULL,
    CONSTRAINT subscriber_account_idx UNIQUE (username, domain)
);
CREATE TABLE usr_preferences (
    id INTEGER PRIMARY KEY NOT NULL,
    uuid VARCHAR(64) DEFAULT '' NOT NULL,
    username VARCHAR(128) DEFAULT 0 NOT NULL,
    domain VARCHAR(64) DEFAULT '' NOT NULL,
    attribute VARCHAR(32) DEFAULT '' NOT NULL,
    type INTEGER DEFAULT 0 NOT NULL,
    value VARCHAR(128) DEFAULT '' NOT NULL,
    last_modified TIMESTAMP WITHOUT TIME ZONE DEFAULT '2000-01-01 00:00:01' NOT NULL
);
CREATE TABLE carrierroute (
    id INTEGER PRIMARY KEY NOT NULL,
    carrier INTEGER DEFAULT 0 NOT NULL,
    domain INTEGER DEFAULT 0 NOT NULL,
    scan_prefix VARCHAR(64) DEFAULT '' NOT NULL,
    flags INTEGER DEFAULT 0 NOT NULL,
    mask INTEGER DEFAULT 0 NOT NULL,
    prob REAL DEFAULT 0 NOT NULL,
    strip INTEGER DEFAULT 0 NOT NULL,
    rewrite_host VARCHAR(128) DEFAULT '' NOT NULL,
    rewrite_prefix VARCHAR(64) DEFAULT '' NOT NULL,
    rewrite_suffix VARCHAR(64) DEFAULT '' NOT NULL,
    description VARCHAR(255) DEFAULT NULL
);
CREATE TABLE carrierfailureroute (
    id INTEGER PRIMARY KEY NOT NULL,
    carrier INTEGER DEFAULT 0 NOT NULL,
    domain INTEGER DEFAULT 0 NOT NULL,
    scan_prefix VARCHAR(64) DEFAULT '' NOT NULL,
    host_name VARCHAR(128) DEFAULT '' NOT NULL,
    reply_code VARCHAR(3) DEFAULT '' NOT NULL,
    flags INTEGER DEFAULT 0 NOT NULL,
    mask INTEGER DEFAULT 0 NOT NULL,
    next_domain INTEGER DEFAULT 0 NOT NULL,
    description VARCHAR(255) DEFAULT NULL
);
CREATE TABLE carrier_name (
    id INTEGER PRIMARY KEY NOT NULL,
    carrier VARCHAR(64) DEFAULT NULL
);
CREATE TABLE domain_name (
    id INTEGER PRIMARY KEY NOT NULL,
    domain VARCHAR(64) DEFAULT NULL
);
CREATE TABLE cpl (
    id INTEGER PRIMARY KEY NOT NULL,
    username VARCHAR(64) NOT NULL,
    domain VARCHAR(64) DEFAULT '' NOT NULL,
    cpl_xml TEXT,
    cpl_bin TEXT,
    CONSTRAINT cpl_account_idx UNIQUE (username, domain)
);
CREATE TABLE dialog (
    id INTEGER PRIMARY KEY NOT NULL,
    hash_entry INTEGER NOT NULL,
    hash_id INTEGER NOT NULL,
    callid VARCHAR(255) NOT NULL,
    from_uri VARCHAR(128) NOT NULL,
    from_tag VARCHAR(64) NOT NULL,
    to_uri VARCHAR(128) NOT NULL,
    to_tag VARCHAR(64) NOT NULL,
    caller_cseq VARCHAR(20) NOT NULL,
    callee_cseq VARCHAR(20) NOT NULL,
    caller_route_set VARCHAR(512),
    callee_route_set VARCHAR(512),
    caller_contact VARCHAR(128) NOT NULL,
    callee_contact VARCHAR(128) NOT NULL,
    caller_sock VARCHAR(64) NOT NULL,
    callee_sock VARCHAR(64) NOT NULL,
    state INTEGER NOT NULL,
    start_time INTEGER NOT NULL,
    timeout INTEGER DEFAULT 0 NOT NULL,
    sflags INTEGER DEFAULT 0 NOT NULL,
    iflags INTEGER DEFAULT 0 NOT NULL,
    toroute_name VARCHAR(32),
    req_uri VARCHAR(128) NOT NULL,
    xdata VARCHAR(512)
);
CREATE TABLE dialog_vars (
    id INTEGER PRIMARY KEY NOT NULL,
    hash_entry INTEGER NOT NULL,
    hash_id INTEGER NOT NULL,
    dialog_key VARCHAR(128) NOT NULL,
    dialog_value VARCHAR(512) NOT NULL
);
CREATE TABLE dialplan (
    id INTEGER PRIMARY KEY NOT NULL,
    dpid INTEGER NOT NULL,
    pr INTEGER NOT NULL,
    match_op INTEGER NOT NULL,
    match_exp VARCHAR(64) NOT NULL,
    match_len INTEGER NOT NULL,
    subst_exp VARCHAR(64) NOT NULL,
    repl_exp VARCHAR(256) NOT NULL,
    attrs VARCHAR(64) NOT NULL
);
CREATE TABLE dispatcher (
    id INTEGER PRIMARY KEY NOT NULL,
    setid INTEGER DEFAULT 0 NOT NULL,
    destination VARCHAR(192) DEFAULT '' NOT NULL,
    flags INTEGER DEFAULT 0 NOT NULL,
    priority INTEGER DEFAULT 0 NOT NULL,
    attrs VARCHAR(128) DEFAULT '' NOT NULL,
    description VARCHAR(64) DEFAULT '' NOT NULL
);
CREATE TABLE domain (
    id INTEGER PRIMARY KEY NOT NULL,
    domain VARCHAR(64) NOT NULL,
    did VARCHAR(64) DEFAULT NULL,
    last_modified TIMESTAMP WITHOUT TIME ZONE DEFAULT '2000-01-01 00:00:01' NOT NULL,
    CONSTRAINT domain_domain_idx UNIQUE (domain)
);
CREATE TABLE domain_attrs (
    id INTEGER PRIMARY KEY NOT NULL,
    did VARCHAR(64) NOT NULL,
    name VARCHAR(32) NOT NULL,
    type INTEGER NOT NULL,
    value VARCHAR(255) NOT NULL,
    last_modified TIMESTAMP WITHOUT TIME ZONE DEFAULT '2000-01-01 00:00:01' NOT NULL
);
CREATE TABLE domainpolicy (
    id INTEGER PRIMARY KEY NOT NULL,
    rule VARCHAR(255) NOT NULL,
    type VARCHAR(255) NOT NULL,
    att VARCHAR(255),
    val VARCHAR(128),
    description VARCHAR(255) NOT NULL,
    CONSTRAINT domainpolicy_rav_idx UNIQUE (rule, att, val)
);
CREATE TABLE dr_gateways (
    gwid INTEGER PRIMARY KEY NOT NULL,
    type INTEGER DEFAULT 0 NOT NULL,
    address VARCHAR(128) NOT NULL,
    strip INTEGER DEFAULT 0 NOT NULL,
    pri_prefix VARCHAR(64) DEFAULT NULL,
    attrs VARCHAR(255) DEFAULT NULL,
    description VARCHAR(128) DEFAULT '' NOT NULL
);
CREATE TABLE dr_rules (
    ruleid INTEGER PRIMARY KEY NOT NULL,
    groupid VARCHAR(255) NOT NULL,
    prefix VARCHAR(64) NOT NULL,
    timerec VARCHAR(255) NOT NULL,
    priority INTEGER DEFAULT 0 NOT NULL,
    routeid VARCHAR(64) NOT NULL,
    gwlist VARCHAR(255) NOT NULL,
    description VARCHAR(128) DEFAULT '' NOT NULL
);
CREATE TABLE dr_gw_lists (
    id INTEGER PRIMARY KEY NOT NULL,
    gwlist VARCHAR(255) NOT NULL,
    description VARCHAR(128) DEFAULT '' NOT NULL
);
CREATE TABLE dr_groups (
    id INTEGER PRIMARY KEY NOT NULL,
    username VARCHAR(64) NOT NULL,
    domain VARCHAR(128) DEFAULT '' NOT NULL,
    groupid INTEGER DEFAULT 0 NOT NULL,
    description VARCHAR(128) DEFAULT '' NOT NULL
);
CREATE TABLE grp (
    id INTEGER PRIMARY KEY NOT NULL,
    username VARCHAR(64) DEFAULT '' NOT NULL,
    domain VARCHAR(64) DEFAULT '' NOT NULL,
    grp VARCHAR(64) DEFAULT '' NOT NULL,
    last_modified TIMESTAMP WITHOUT TIME ZONE DEFAULT '2000-01-01 00:00:01' NOT NULL,
    CONSTRAINT grp_account_group_idx UNIQUE (username, domain, grp)
);
CREATE TABLE re_grp (
    id INTEGER PRIMARY KEY NOT NULL,
    reg_exp VARCHAR(128) DEFAULT '' NOT NULL,
    group_id INTEGER DEFAULT 0 NOT NULL
);
CREATE TABLE htable (
    id INTEGER PRIMARY KEY NOT NULL,
    key_name VARCHAR(64) DEFAULT '' NOT NULL,
    key_type INTEGER DEFAULT 0 NOT NULL,
    value_type INTEGER DEFAULT 0 NOT NULL,
    key_value VARCHAR(128) DEFAULT '' NOT NULL,
    expires INTEGER DEFAULT 0 NOT NULL
);
CREATE TABLE imc_rooms (
    id INTEGER PRIMARY KEY NOT NULL,
    name VARCHAR(64) NOT NULL,
    domain VARCHAR(64) NOT NULL,
    flag INTEGER NOT NULL,
    CONSTRAINT imc_rooms_name_domain_idx UNIQUE (name, domain)
);
CREATE TABLE imc_members (
    id INTEGER PRIMARY KEY NOT NULL,
    username VARCHAR(64) NOT NULL,
    domain VARCHAR(64) NOT NULL,
    room VARCHAR(64) NOT NULL,
    flag INTEGER NOT NULL,
    CONSTRAINT imc_members_account_room_idx UNIQUE (username, domain, room)
);
CREATE TABLE lcr_gw (
    id INTEGER PRIMARY KEY NOT NULL,
    lcr_id SMALLINT NOT NULL,
    gw_name VARCHAR(128),
    ip_addr VARCHAR(50),
    hostname VARCHAR(64),
    port SMALLINT,
    params VARCHAR(64),
    uri_scheme SMALLINT,
    transport SMALLINT,
    strip SMALLINT,
    prefix VARCHAR(16) DEFAULT NULL,
    tag VARCHAR(64) DEFAULT NULL,
    flags INTEGER DEFAULT 0 NOT NULL,
    defunct INTEGER DEFAULT NULL
);
CREATE TABLE lcr_rule_target (
    id INTEGER PRIMARY KEY NOT NULL,
    lcr_id SMALLINT NOT NULL,
    rule_id INTEGER NOT NULL,
    gw_id INTEGER NOT NULL,
    priority SMALLINT NOT NULL,
    weight INTEGER DEFAULT 1 NOT NULL,
    CONSTRAINT lcr_rule_target_rule_id_gw_id_idx UNIQUE (rule_id, gw_id)
);
CREATE TABLE lcr_rule (
    id INTEGER PRIMARY KEY NOT NULL,
    lcr_id SMALLINT NOT NULL,
    prefix VARCHAR(16) DEFAULT NULL,
    from_uri VARCHAR(64) DEFAULT NULL,
    request_uri VARCHAR(64) DEFAULT NULL,
    mt_tvalue VARCHAR(128) DEFAULT NULL,
    stopper INTEGER DEFAULT 0 NOT NULL,
    enabled INTEGER DEFAULT 1 NOT NULL,
    CONSTRAINT lcr_rule_lcr_id_prefix_from_uri_idx UNIQUE (lcr_id, prefix, from_uri)
);
CREATE TABLE matrix (
    first INTEGER NOT NULL,
    second SMALLINT NOT NULL,
    res INTEGER NOT NULL
);
CREATE TABLE mohqcalls (
    id INTEGER PRIMARY KEY NOT NULL,
    mohq_id INTEGER NOT NULL,
    call_id VARCHAR(100) NOT NULL,
    call_status INTEGER NOT NULL,
    call_from VARCHAR(100) NOT NULL,
    call_contact VARCHAR(100),
    call_time TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    CONSTRAINT mohqcalls_mohqcalls_idx UNIQUE (call_id)
);
CREATE TABLE mohqueues (
    id INTEGER PRIMARY KEY NOT NULL,
    name VARCHAR(25) NOT NULL,
    uri VARCHAR(100) NOT NULL,
    mohdir VARCHAR(100),
    mohfile VARCHAR(100) NOT NULL,
    debug INTEGER NOT NULL,
    CONSTRAINT mohqueues_mohqueue_uri_idx UNIQUE (uri),
    CONSTRAINT mohqueues_mohqueue_name_idx UNIQUE (name)
);
CREATE TABLE silo (
    id INTEGER PRIMARY KEY NOT NULL,
    src_addr VARCHAR(128) DEFAULT '' NOT NULL,
    dst_addr VARCHAR(128) DEFAULT '' NOT NULL,
    username VARCHAR(64) DEFAULT '' NOT NULL,
    domain VARCHAR(64) DEFAULT '' NOT NULL,
    inc_time INTEGER DEFAULT 0 NOT NULL,
    exp_time INTEGER DEFAULT 0 NOT NULL,
    snd_time INTEGER DEFAULT 0 NOT NULL,
    ctype VARCHAR(32) DEFAULT 'text/plain' NOT NULL,
    body BLOB,
    extra_hdrs TEXT,
    callid VARCHAR(128) DEFAULT '' NOT NULL,
    status INTEGER DEFAULT 0 NOT NULL
);
CREATE TABLE mtree (
    id INTEGER PRIMARY KEY NOT NULL,
    tprefix VARCHAR(32) DEFAULT '' NOT NULL,
    tvalue VARCHAR(128) DEFAULT '' NOT NULL,
    CONSTRAINT mtree_tprefix_idx UNIQUE (tprefix)
);
CREATE TABLE mtrees (
    id INTEGER PRIMARY KEY NOT NULL,
    tname VARCHAR(128) DEFAULT '' NOT NULL,
    tprefix VARCHAR(32) DEFAULT '' NOT NULL,
    tvalue VARCHAR(128) DEFAULT '' NOT NULL,
    CONSTRAINT mtrees_tname_tprefix_tvalue_idx UNIQUE (tname, tprefix, tvalue)
);
CREATE TABLE pdt (
    id INTEGER PRIMARY KEY NOT NULL,
    sdomain VARCHAR(128) NOT NULL,
    prefix VARCHAR(32) NOT NULL,
    domain VARCHAR(128) DEFAULT '' NOT NULL,
    CONSTRAINT pdt_sdomain_prefix_idx UNIQUE (sdomain, prefix)
);
CREATE TABLE trusted (
    id INTEGER PRIMARY KEY NOT NULL,
    src_ip VARCHAR(50) NOT NULL,
    proto VARCHAR(4) NOT NULL,
    from_pattern VARCHAR(64) DEFAULT NULL,
    ruri_pattern VARCHAR(64) DEFAULT NULL,
    tag VARCHAR(64),
    priority INTEGER DEFAULT 0 NOT NULL
);
CREATE TABLE address (
    id INTEGER PRIMARY KEY NOT NULL,
    grp INTEGER DEFAULT 1 NOT NULL,
    ip_addr VARCHAR(50) NOT NULL,
    mask INTEGER DEFAULT 32 NOT NULL,
    port SMALLINT DEFAULT 0 NOT NULL,
    tag VARCHAR(64)
);
CREATE TABLE pl_pipes (
    id INTEGER PRIMARY KEY NOT NULL,
    pipeid VARCHAR(64) DEFAULT '' NOT NULL,
    algorithm VARCHAR(32) DEFAULT '' NOT NULL,
    plimit INTEGER DEFAULT 0 NOT NULL
);
CREATE TABLE presentity (
    id INTEGER PRIMARY KEY NOT NULL,
    username VARCHAR(64) NOT NULL,
    domain VARCHAR(64) NOT NULL,
    event VARCHAR(64) NOT NULL,
    etag VARCHAR(128) NOT NULL,
    expires INTEGER NOT NULL,
    received_time INTEGER NOT NULL,
    body BLOB NOT NULL,
    sender VARCHAR(128) NOT NULL,
    priority INTEGER DEFAULT 0 NOT NULL,
    ruid VARCHAR(64),
    CONSTRAINT presentity_presentity_idx UNIQUE (username, domain, event, etag),
    CONSTRAINT presentity_ruid_idx UNIQUE (ruid)
);
CREATE TABLE active_watchers (
    id INTEGER PRIMARY KEY NOT NULL,
    presentity_uri VARCHAR(128) NOT NULL,
    watcher_username VARCHAR(64) NOT NULL,
    watcher_domain VARCHAR(64) NOT NULL,
    to_user VARCHAR(64) NOT NULL,
    to_domain VARCHAR(64) NOT NULL,
    event VARCHAR(64) DEFAULT 'presence' NOT NULL,
    event_id VARCHAR(64),
    to_tag VARCHAR(64) NOT NULL,
    from_tag VARCHAR(64) NOT NULL,
    callid VARCHAR(255) NOT NULL,
    local_cseq INTEGER NOT NULL,
    remote_cseq INTEGER NOT NULL,
    contact VARCHAR(128) NOT NULL,
    record_route TEXT,
    expires INTEGER NOT NULL,
    status INTEGER DEFAULT 2 NOT NULL,
    reason VARCHAR(64),
    version INTEGER DEFAULT 0 NOT NULL,
    socket_info VARCHAR(64) NOT NULL,
    local_contact VARCHAR(128) NOT NULL,
    from_user VARCHAR(64) NOT NULL,
    from_domain VARCHAR(64) NOT NULL,
    updated INTEGER NOT NULL,
    updated_winfo INTEGER NOT NULL,
    flags INTEGER DEFAULT 0 NOT NULL,
    user_agent VARCHAR(255) DEFAULT '', watcher_uri varchar(64) NOT NULL DEFAULT 'sip:no_watcher@no_domain',
    CONSTRAINT active_watchers_active_watchers_idx UNIQUE (callid, to_tag, from_tag)
);
CREATE TABLE watchers (
    id INTEGER PRIMARY KEY NOT NULL,
    presentity_uri VARCHAR(128) NOT NULL,
    watcher_username VARCHAR(64) NOT NULL,
    watcher_domain VARCHAR(64) NOT NULL,
    event VARCHAR(64) DEFAULT 'presence' NOT NULL,
    status INTEGER NOT NULL,
    reason VARCHAR(64),
    inserted_time INTEGER NOT NULL,
    CONSTRAINT watchers_watcher_idx UNIQUE (presentity_uri, watcher_username, watcher_domain, event)
);
CREATE TABLE xcap (
    id INTEGER PRIMARY KEY NOT NULL,
    username VARCHAR(64) NOT NULL,
    domain VARCHAR(64) NOT NULL,
    doc BLOB NOT NULL,
    doc_type INTEGER NOT NULL,
    etag VARCHAR(128) NOT NULL,
    source INTEGER NOT NULL,
    doc_uri VARCHAR(255) NOT NULL,
    port INTEGER NOT NULL,
    CONSTRAINT xcap_doc_uri_idx UNIQUE (doc_uri)
);
CREATE TABLE pua (
    id INTEGER PRIMARY KEY NOT NULL,
    pres_uri VARCHAR(128) NOT NULL,
    pres_id VARCHAR(255) NOT NULL,
    event INTEGER NOT NULL,
    expires INTEGER NOT NULL,
    desired_expires INTEGER NOT NULL,
    flag INTEGER NOT NULL,
    etag VARCHAR(128) NOT NULL,
    tuple_id VARCHAR(64),
    watcher_uri VARCHAR(128) NOT NULL,
    call_id VARCHAR(255) NOT NULL,
    to_tag VARCHAR(64) NOT NULL,
    from_tag VARCHAR(64) NOT NULL,
    cseq INTEGER NOT NULL,
    record_route TEXT,
    contact VARCHAR(128) NOT NULL,
    remote_contact VARCHAR(128) NOT NULL,
    version INTEGER NOT NULL,
    extra_headers TEXT NOT NULL,
    CONSTRAINT pua_pua_idx UNIQUE (etag, tuple_id, call_id, from_tag)
);
CREATE TABLE purplemap (
    id INTEGER PRIMARY KEY NOT NULL,
    sip_user VARCHAR(128) NOT NULL,
    ext_user VARCHAR(128) NOT NULL,
    ext_prot VARCHAR(16) NOT NULL,
    ext_pass VARCHAR(64)
);
CREATE TABLE aliases (
    id INTEGER PRIMARY KEY NOT NULL,
    ruid VARCHAR(64) DEFAULT '' NOT NULL,
    username VARCHAR(64) DEFAULT '' NOT NULL,
    domain VARCHAR(64) DEFAULT NULL,
    contact VARCHAR(255) DEFAULT '' NOT NULL,
    received VARCHAR(128) DEFAULT NULL,
    path VARCHAR(512) DEFAULT NULL,
    expires TIMESTAMP WITHOUT TIME ZONE DEFAULT '2030-05-28 21:32:15' NOT NULL,
    q REAL DEFAULT 1.0 NOT NULL,
    callid VARCHAR(255) DEFAULT 'Default-Call-ID' NOT NULL,
    cseq INTEGER DEFAULT 1 NOT NULL,
    last_modified TIMESTAMP WITHOUT TIME ZONE DEFAULT '2000-01-01 00:00:01' NOT NULL,
    flags INTEGER DEFAULT 0 NOT NULL,
    cflags INTEGER DEFAULT 0 NOT NULL,
    user_agent VARCHAR(255) DEFAULT '' NOT NULL,
    socket VARCHAR(64) DEFAULT NULL,
    methods INTEGER DEFAULT NULL,
    instance VARCHAR(255) DEFAULT NULL,
    reg_id INTEGER DEFAULT 0 NOT NULL,
    server_id INTEGER DEFAULT 0 NOT NULL,
    connection_id INTEGER DEFAULT 0 NOT NULL,
    keepalive INTEGER DEFAULT 0 NOT NULL,
    partition INTEGER DEFAULT 0 NOT NULL,
    CONSTRAINT aliases_ruid_idx UNIQUE (ruid)
);
CREATE TABLE rls_presentity (
    id INTEGER PRIMARY KEY NOT NULL,
    rlsubs_did VARCHAR(255) NOT NULL,
    resource_uri VARCHAR(128) NOT NULL,
    content_type VARCHAR(255) NOT NULL,
    presence_state BLOB NOT NULL,
    expires INTEGER NOT NULL,
    updated INTEGER NOT NULL,
    auth_state INTEGER NOT NULL,
    reason VARCHAR(64) NOT NULL,
    CONSTRAINT rls_presentity_rls_presentity_idx UNIQUE (rlsubs_did, resource_uri)
);
CREATE TABLE rls_watchers (
    id INTEGER PRIMARY KEY NOT NULL,
    presentity_uri VARCHAR(128) NOT NULL,
    to_user VARCHAR(64) NOT NULL,
    to_domain VARCHAR(64) NOT NULL,
    watcher_username VARCHAR(64) NOT NULL,
    watcher_domain VARCHAR(64) NOT NULL,
    event VARCHAR(64) DEFAULT 'presence' NOT NULL,
    event_id VARCHAR(64),
    to_tag VARCHAR(64) NOT NULL,
    from_tag VARCHAR(64) NOT NULL,
    callid VARCHAR(255) NOT NULL,
    local_cseq INTEGER NOT NULL,
    remote_cseq INTEGER NOT NULL,
    contact VARCHAR(128) NOT NULL,
    record_route TEXT,
    expires INTEGER NOT NULL,
    status INTEGER DEFAULT 2 NOT NULL,
    reason VARCHAR(64) NOT NULL,
    version INTEGER DEFAULT 0 NOT NULL,
    socket_info VARCHAR(64) NOT NULL,
    local_contact VARCHAR(128) NOT NULL,
    from_user VARCHAR(64) NOT NULL,
    from_domain VARCHAR(64) NOT NULL,
    updated INTEGER NOT NULL,
    CONSTRAINT rls_watchers_rls_watcher_idx UNIQUE (callid, to_tag, from_tag)
);
CREATE TABLE rtpengine (
    id INTEGER PRIMARY KEY NOT NULL,
    setid INTEGER DEFAULT 0 NOT NULL,
    url VARCHAR(64) NOT NULL,
    weight INTEGER DEFAULT 1 NOT NULL,
    disabled INTEGER DEFAULT 0 NOT NULL,
    stamp TIMESTAMP WITHOUT TIME ZONE DEFAULT '1900-01-01 00:00:01' NOT NULL,
    CONSTRAINT rtpengine_rtpengine_nodes UNIQUE (setid, url)
);
CREATE TABLE rtpproxy (
    id INTEGER PRIMARY KEY NOT NULL,
    setid VARCHAR(32) DEFAULT 00 NOT NULL,
    url VARCHAR(64) DEFAULT '' NOT NULL,
    flags INTEGER DEFAULT 0 NOT NULL,
    weight INTEGER DEFAULT 1 NOT NULL,
    description VARCHAR(64) DEFAULT '' NOT NULL
);
CREATE TABLE sca_subscriptions (
    id INTEGER PRIMARY KEY NOT NULL,
    subscriber VARCHAR(255) NOT NULL,
    aor VARCHAR(255) NOT NULL,
    event INTEGER DEFAULT 0 NOT NULL,
    expires INTEGER DEFAULT 0 NOT NULL,
    state INTEGER DEFAULT 0 NOT NULL,
    app_idx INTEGER DEFAULT 0 NOT NULL,
    call_id VARCHAR(255) NOT NULL,
    from_tag VARCHAR(64) NOT NULL,
    to_tag VARCHAR(64) NOT NULL,
    record_route TEXT,
    notify_cseq INTEGER NOT NULL,
    subscribe_cseq INTEGER NOT NULL,
    server_id INTEGER DEFAULT 0 NOT NULL,
    CONSTRAINT sca_subscriptions_sca_subscriptions_idx UNIQUE (subscriber, call_id, from_tag, to_tag)
);
CREATE TABLE sip_trace (
    id INTEGER PRIMARY KEY NOT NULL,
    time_stamp TIMESTAMP WITHOUT TIME ZONE DEFAULT '2000-01-01 00:00:01' NOT NULL,
    time_us INTEGER DEFAULT 0 NOT NULL,
    callid VARCHAR(255) DEFAULT '' NOT NULL,
    traced_user VARCHAR(128) DEFAULT '' NOT NULL,
    msg TEXT NOT NULL,
    method VARCHAR(50) DEFAULT '' NOT NULL,
    status VARCHAR(128) DEFAULT '' NOT NULL,
    fromip VARCHAR(50) DEFAULT '' NOT NULL,
    toip VARCHAR(50) DEFAULT '' NOT NULL,
    fromtag VARCHAR(64) DEFAULT '' NOT NULL,
    totag VARCHAR(64) DEFAULT '' NOT NULL,
    direction VARCHAR(4) DEFAULT '' NOT NULL
);
CREATE TABLE speed_dial (
    id INTEGER PRIMARY KEY NOT NULL,
    username VARCHAR(64) DEFAULT '' NOT NULL,
    domain VARCHAR(64) DEFAULT '' NOT NULL,
    sd_username VARCHAR(64) DEFAULT '' NOT NULL,
    sd_domain VARCHAR(64) DEFAULT '' NOT NULL,
    new_uri VARCHAR(128) DEFAULT '' NOT NULL,
    fname VARCHAR(64) DEFAULT '' NOT NULL,
    lname VARCHAR(64) DEFAULT '' NOT NULL,
    description VARCHAR(64) DEFAULT '' NOT NULL,
    CONSTRAINT speed_dial_speed_dial_idx UNIQUE (username, domain, sd_domain, sd_username)
);
CREATE TABLE topos_d (
    id INTEGER PRIMARY KEY NOT NULL,
    rectime TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    s_method VARCHAR(64) DEFAULT '' NOT NULL,
    s_cseq VARCHAR(64) DEFAULT '' NOT NULL,
    a_callid VARCHAR(255) DEFAULT '' NOT NULL,
    a_uuid VARCHAR(255) DEFAULT '' NOT NULL,
    b_uuid VARCHAR(255) DEFAULT '' NOT NULL,
    a_contact VARCHAR(128) DEFAULT '' NOT NULL,
    b_contact VARCHAR(128) DEFAULT '' NOT NULL,
    as_contact VARCHAR(128) DEFAULT '' NOT NULL,
    bs_contact VARCHAR(128) DEFAULT '' NOT NULL,
    a_tag VARCHAR(255) DEFAULT '' NOT NULL,
    b_tag VARCHAR(255) DEFAULT '' NOT NULL,
    a_rr TEXT,
    b_rr TEXT,
    s_rr TEXT,
    iflags INTEGER DEFAULT 0 NOT NULL,
    a_uri VARCHAR(128) DEFAULT '' NOT NULL,
    b_uri VARCHAR(128) DEFAULT '' NOT NULL,
    r_uri VARCHAR(128) DEFAULT '' NOT NULL,
    a_srcaddr VARCHAR(128) DEFAULT '' NOT NULL,
    b_srcaddr VARCHAR(128) DEFAULT '' NOT NULL,
    a_socket VARCHAR(128) DEFAULT '' NOT NULL,
    b_socket VARCHAR(128) DEFAULT '' NOT NULL
);
CREATE TABLE topos_t (
    id INTEGER PRIMARY KEY NOT NULL,
    rectime TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    s_method VARCHAR(64) DEFAULT '' NOT NULL,
    s_cseq VARCHAR(64) DEFAULT '' NOT NULL,
    a_callid VARCHAR(255) DEFAULT '' NOT NULL,
    a_uuid VARCHAR(255) DEFAULT '' NOT NULL,
    b_uuid VARCHAR(255) DEFAULT '' NOT NULL,
    direction INTEGER DEFAULT 0 NOT NULL,
    x_via TEXT,
    x_vbranch VARCHAR(255) DEFAULT '' NOT NULL,
    x_rr TEXT,
    y_rr TEXT,
    s_rr TEXT,
    x_uri VARCHAR(128) DEFAULT '' NOT NULL,
    a_contact VARCHAR(128) DEFAULT '' NOT NULL,
    b_contact VARCHAR(128) DEFAULT '' NOT NULL,
    as_contact VARCHAR(128) DEFAULT '' NOT NULL,
    bs_contact VARCHAR(128) DEFAULT '' NOT NULL,
    x_tag VARCHAR(255) DEFAULT '' NOT NULL,
    a_tag VARCHAR(255) DEFAULT '' NOT NULL,
    b_tag VARCHAR(255) DEFAULT '' NOT NULL,
    a_srcaddr VARCHAR(128) DEFAULT '' NOT NULL,
    b_srcaddr VARCHAR(128) DEFAULT '' NOT NULL,
    a_socket VARCHAR(128) DEFAULT '' NOT NULL,
    b_socket VARCHAR(128) DEFAULT '' NOT NULL
);
CREATE TABLE uacreg (
    id INTEGER PRIMARY KEY NOT NULL,
    l_uuid VARCHAR(64) DEFAULT '' NOT NULL,
    l_username VARCHAR(64) DEFAULT '' NOT NULL,
    l_domain VARCHAR(64) DEFAULT '' NOT NULL,
    r_username VARCHAR(64) DEFAULT '' NOT NULL,
    r_domain VARCHAR(64) DEFAULT '' NOT NULL,
    realm VARCHAR(64) DEFAULT '' NOT NULL,
    auth_username VARCHAR(64) DEFAULT '' NOT NULL,
    auth_password VARCHAR(64) DEFAULT '' NOT NULL,
    auth_ha1 VARCHAR(128) DEFAULT '' NOT NULL,
    auth_proxy VARCHAR(128) DEFAULT '' NOT NULL,
    expires INTEGER DEFAULT 0 NOT NULL,
    flags INTEGER DEFAULT 0 NOT NULL,
    reg_delay INTEGER DEFAULT 0 NOT NULL,
    CONSTRAINT uacreg_l_uuid_idx UNIQUE (l_uuid)
);
CREATE TABLE uid_credentials (
    id INTEGER PRIMARY KEY NOT NULL,
    auth_username VARCHAR(64) NOT NULL,
    did VARCHAR(64) DEFAULT '_default' NOT NULL,
    realm VARCHAR(64) NOT NULL,
    password VARCHAR(28) DEFAULT '' NOT NULL,
    flags INTEGER DEFAULT 0 NOT NULL,
    ha1 VARCHAR(32) NOT NULL,
    ha1b VARCHAR(32) DEFAULT '' NOT NULL,
    uid VARCHAR(64) NOT NULL
);
CREATE TABLE uid_user_attrs (
    id INTEGER PRIMARY KEY NOT NULL,
    uid VARCHAR(64) NOT NULL,
    name VARCHAR(32) NOT NULL,
    value VARCHAR(128),
    type INTEGER DEFAULT 0 NOT NULL,
    flags INTEGER DEFAULT 0 NOT NULL,
    CONSTRAINT uid_user_attrs_userattrs_idx UNIQUE (uid, name, value)
);
CREATE TABLE uid_domain (
    id INTEGER PRIMARY KEY NOT NULL,
    did VARCHAR(64) NOT NULL,
    domain VARCHAR(64) NOT NULL,
    flags INTEGER DEFAULT 0 NOT NULL,
    CONSTRAINT uid_domain_domain_idx UNIQUE (domain)
);
CREATE TABLE uid_domain_attrs (
    id INTEGER PRIMARY KEY NOT NULL,
    did VARCHAR(64),
    name VARCHAR(32) NOT NULL,
    type INTEGER DEFAULT 0 NOT NULL,
    value VARCHAR(128),
    flags INTEGER DEFAULT 0 NOT NULL,
    CONSTRAINT uid_domain_attrs_domain_attr_idx UNIQUE (did, name, value)
);
CREATE TABLE uid_global_attrs (
    id INTEGER PRIMARY KEY NOT NULL,
    name VARCHAR(32) NOT NULL,
    type INTEGER DEFAULT 0 NOT NULL,
    value VARCHAR(128),
    flags INTEGER DEFAULT 0 NOT NULL,
    CONSTRAINT uid_global_attrs_global_attrs_idx UNIQUE (name, value)
);
CREATE TABLE uid_uri (
    id INTEGER PRIMARY KEY NOT NULL,
    uid VARCHAR(64) NOT NULL,
    did VARCHAR(64) NOT NULL,
    username VARCHAR(64) NOT NULL,
    flags INTEGER DEFAULT 0 NOT NULL,
    scheme VARCHAR(8) DEFAULT 'sip' NOT NULL
);
CREATE TABLE uid_uri_attrs (
    id INTEGER PRIMARY KEY NOT NULL,
    username VARCHAR(64) NOT NULL,
    did VARCHAR(64) NOT NULL,
    name VARCHAR(32) NOT NULL,
    value VARCHAR(128),
    type INTEGER DEFAULT 0 NOT NULL,
    flags INTEGER DEFAULT 0 NOT NULL,
    scheme VARCHAR(8) DEFAULT 'sip' NOT NULL,
    CONSTRAINT uid_uri_attrs_uriattrs_idx UNIQUE (username, did, name, value, scheme)
);
CREATE TABLE uri (
    id INTEGER PRIMARY KEY NOT NULL,
    username VARCHAR(64) DEFAULT '' NOT NULL,
    domain VARCHAR(64) DEFAULT '' NOT NULL,
    uri_user VARCHAR(64) DEFAULT '' NOT NULL,
    last_modified TIMESTAMP WITHOUT TIME ZONE DEFAULT '2000-01-01 00:00:01' NOT NULL,
    CONSTRAINT uri_account_idx UNIQUE (username, domain, uri_user)
);
CREATE TABLE userblacklist (
    id INTEGER PRIMARY KEY NOT NULL,
    username VARCHAR(64) DEFAULT '' NOT NULL,
    domain VARCHAR(64) DEFAULT '' NOT NULL,
    prefix VARCHAR(64) DEFAULT '' NOT NULL,
    whitelist SMALLINT DEFAULT 0 NOT NULL
);
CREATE TABLE globalblacklist (
    id INTEGER PRIMARY KEY NOT NULL,
    prefix VARCHAR(64) DEFAULT '' NOT NULL,
    whitelist SMALLINT DEFAULT 0 NOT NULL,
    description VARCHAR(255) DEFAULT NULL
);
CREATE TABLE location (
    id INTEGER PRIMARY KEY NOT NULL,
    ruid VARCHAR(64) DEFAULT '' NOT NULL,
    username VARCHAR(64) DEFAULT '' NOT NULL,
    domain VARCHAR(64) DEFAULT NULL,
    contact VARCHAR(512) DEFAULT '' NOT NULL,
    received VARCHAR(128) DEFAULT NULL,
    path VARCHAR(512) DEFAULT NULL,
    expires TIMESTAMP WITHOUT TIME ZONE DEFAULT '2030-05-28 21:32:15' NOT NULL,
    q REAL DEFAULT 1.0 NOT NULL,
    callid VARCHAR(255) DEFAULT 'Default-Call-ID' NOT NULL,
    cseq INTEGER DEFAULT 1 NOT NULL,
    last_modified TIMESTAMP WITHOUT TIME ZONE DEFAULT '2000-01-01 00:00:01' NOT NULL,
    flags INTEGER DEFAULT 0 NOT NULL,
    cflags INTEGER DEFAULT 0 NOT NULL,
    user_agent VARCHAR(255) DEFAULT '' NOT NULL,
    socket VARCHAR(64) DEFAULT NULL,
    methods INTEGER DEFAULT NULL,
    instance VARCHAR(255) DEFAULT NULL,
    reg_id INTEGER DEFAULT 0 NOT NULL,
    server_id INTEGER DEFAULT 0 NOT NULL,
    connection_id INTEGER DEFAULT 0 NOT NULL,
    keepalive INTEGER DEFAULT 0 NOT NULL,
    partition INTEGER DEFAULT 0 NOT NULL,
    CONSTRAINT location_ruid_idx UNIQUE (ruid)
);
CREATE TABLE location_attrs (
    id INTEGER PRIMARY KEY NOT NULL,
    ruid VARCHAR(64) DEFAULT '' NOT NULL,
    username VARCHAR(64) DEFAULT '' NOT NULL,
    domain VARCHAR(64) DEFAULT NULL,
    aname VARCHAR(64) DEFAULT '' NOT NULL,
    atype INTEGER DEFAULT 0 NOT NULL,
    avalue VARCHAR(512) DEFAULT '' NOT NULL,
    last_modified TIMESTAMP WITHOUT TIME ZONE DEFAULT '2000-01-01 00:00:01' NOT NULL
);
CREATE TABLE event_list ( event varchar(25) PRIMARY KEY NOT NULL);
INSERT INTO 'event_list' VALUES('dialog');
INSERT INTO 'event_list' VALUES('message-summary');
INSERT INTO 'event_list' VALUES('presence');
CREATE TABLE active_watchers_log (
    id INTEGER PRIMARY KEY NOT NULL,
    presentity_uri VARCHAR(128) NOT NULL COLLATE NOCASE,
    watcher_username VARCHAR(64) NOT NULL COLLATE NOCASE,
    watcher_domain VARCHAR(64) NOT NULL COLLATE NOCASE,
    to_user VARCHAR(64) NOT NULL COLLATE NOCASE,
    to_domain VARCHAR(64) NOT NULL COLLATE NOCASE,
    event VARCHAR(64) DEFAULT 'presence' NOT NULL,
    callid VARCHAR(255) NOT NULL,
    time INTEGER NOT NULL,
    result INTEGER NOT NULL,
    sent_msg BLOB NOT NULL,
    received_msg BLOB NOT NULL,
    user_agent VARCHAR(255) DEFAULT '' COLLATE NOCASE,
    CONSTRAINT active_watchers_active_watchers_log_idx UNIQUE (presentity_uri, watcher_username, watcher_domain, event)
);
CREATE TABLE keepalive (
    id INTEGER PRIMARY KEY NOT NULL,
    contact VARCHAR(2048) NOT NULL COLLATE NOCASE,
    received VARCHAR(32) NOT NULL COLLATE NOCASE,
    sockinfo VARCHAR(128) NOT NULL COLLATE NOCASE,
    time_inserted timestamp DEFAULT CURRENT_TIMESTAMP,
    time_sent timestamp DEFAULT CURRENT_TIMESTAMP,
    slot INTEGER NOT NULL,
    selected INTEGER DEFAULT 0,
    failed INTEGER DEFAULT 0,
    CONSTRAINT keepalive_idx UNIQUE (contact),
    CONSTRAINT keepalive_idx_2 UNIQUE (slot, failed, contact)
);
CREATE TABLE auth_cache(
    id INT,
    key_name TEXT,
    key_type INT,
    value_type INT,
    key_value TEXT,
    expires INT
);
CREATE TABLE block_cache(
    id INT,
    key_name TEXT,
    key_type INT,
    value_type INT,
    key_value TEXT,
    expires INT
);
CREATE TABLE tmp_probe(
    event TEXT,
    presentity_uri TEXT,
    'action' INT
);
CREATE INDEX acc_callid_idx ON acc (callid);
CREATE INDEX acc_cdrs_start_time_idx ON acc_cdrs (start_time);
CREATE INDEX missed_calls_callid_idx ON missed_calls (callid);
CREATE INDEX dbaliases_alias_user_idx ON dbaliases (alias_username);
CREATE INDEX dbaliases_alias_idx ON dbaliases (alias_username, alias_domain);
CREATE INDEX dbaliases_target_idx ON dbaliases (username, domain);
CREATE INDEX subscriber_username_idx ON subscriber (username);
CREATE INDEX usr_preferences_ua_idx ON usr_preferences (uuid, attribute);
CREATE INDEX usr_preferences_uda_idx ON usr_preferences (username, domain, attribute);
CREATE INDEX dialog_hash_idx ON dialog (hash_entry, hash_id);
CREATE INDEX dialog_vars_hash_idx ON dialog_vars (hash_entry, hash_id);
CREATE INDEX domain_attrs_domain_attrs_idx ON domain_attrs (did, name);
CREATE INDEX domainpolicy_rule_idx ON domainpolicy (rule);
CREATE INDEX re_grp_group_idx ON re_grp (group_id);
CREATE INDEX lcr_gw_lcr_id_idx ON lcr_gw (lcr_id);
CREATE INDEX lcr_rule_target_lcr_id_idx ON lcr_rule_target (lcr_id);
CREATE INDEX matrix_matrix_idx ON matrix (first, second);
CREATE INDEX silo_account_idx ON silo (username, domain);
CREATE INDEX trusted_peer_idx ON trusted (src_ip);
CREATE INDEX presentity_presentity_expires ON presentity (expires);
CREATE INDEX presentity_account_idx ON presentity (username, domain, event);
CREATE INDEX active_watchers_active_watchers_expires ON active_watchers (expires);
CREATE INDEX active_watchers_active_watchers_pres ON active_watchers (presentity_uri, event);
CREATE INDEX active_watchers_updated_idx ON active_watchers (updated);
CREATE INDEX active_watchers_updated_winfo_idx ON active_watchers (updated_winfo, presentity_uri);
CREATE INDEX xcap_account_doc_type_idx ON xcap (username, domain, doc_type);
CREATE INDEX xcap_account_doc_type_uri_idx ON xcap (username, domain, doc_type, doc_uri);
CREATE INDEX xcap_account_doc_uri_idx ON xcap (username, domain, doc_uri);
CREATE INDEX pua_expires_idx ON pua (expires);
CREATE INDEX pua_dialog1_idx ON pua (pres_id, pres_uri);
CREATE INDEX pua_dialog2_idx ON pua (call_id, from_tag);
CREATE INDEX pua_record_idx ON pua (pres_id);
CREATE INDEX aliases_account_contact_idx ON aliases (username, domain, contact);
CREATE INDEX aliases_expires_idx ON aliases (expires);
CREATE INDEX rls_presentity_rlsubs_idx ON rls_presentity (rlsubs_did);
CREATE INDEX rls_presentity_updated_idx ON rls_presentity (updated);
CREATE INDEX rls_presentity_expires_idx ON rls_presentity (expires);
CREATE INDEX rls_watchers_rls_watchers_update ON rls_watchers (watcher_username, watcher_domain, event);
CREATE INDEX rls_watchers_rls_watchers_expires ON rls_watchers (expires);
CREATE INDEX rls_watchers_updated_idx ON rls_watchers (updated);
CREATE INDEX sca_subscriptions_sca_expires_idx ON sca_subscriptions (server_id, expires);
CREATE INDEX sca_subscriptions_sca_subscribers_idx ON sca_subscriptions (subscriber, event);
CREATE INDEX sip_trace_traced_user_idx ON sip_trace (traced_user);
CREATE INDEX sip_trace_date_idx ON sip_trace (time_stamp);
CREATE INDEX sip_trace_fromip_idx ON sip_trace (fromip);
CREATE INDEX sip_trace_callid_idx ON sip_trace (callid);
CREATE INDEX topos_d_rectime_idx ON topos_d (rectime);
CREATE INDEX topos_d_a_callid_idx ON topos_d (a_callid);
CREATE INDEX topos_d_a_uuid_idx ON topos_d (a_uuid);
CREATE INDEX topos_d_b_uuid_idx ON topos_d (b_uuid);
CREATE INDEX topos_t_rectime_idx ON topos_t (rectime);
CREATE INDEX topos_t_a_callid_idx ON topos_t (a_callid);
CREATE INDEX topos_t_x_vbranch_idx ON topos_t (x_vbranch);
CREATE INDEX topos_t_a_uuid_idx ON topos_t (a_uuid);
CREATE INDEX uid_credentials_cred_idx ON uid_credentials (auth_username, did);
CREATE INDEX uid_credentials_uid ON uid_credentials (uid);
CREATE INDEX uid_credentials_did_idx ON uid_credentials (did);
CREATE INDEX uid_credentials_realm_idx ON uid_credentials (realm);
CREATE INDEX uid_domain_did_idx ON uid_domain (did);
CREATE INDEX uid_domain_attrs_domain_did ON uid_domain_attrs (did, flags);
CREATE INDEX uid_uri_uri_idx1 ON uid_uri (username, did, scheme);
CREATE INDEX uid_uri_uri_uid ON uid_uri (uid);
CREATE INDEX userblacklist_userblacklist_idx ON userblacklist (username, domain, prefix);
CREATE INDEX globalblacklist_globalblacklist_idx ON globalblacklist (prefix);
CREATE INDEX location_account_contact_idx ON location (username, domain, contact);
CREATE INDEX location_expires_idx ON location (expires);
CREATE INDEX location_connection_idx ON location (server_id, connection_id);
CREATE INDEX location_attrs_account_record_idx ON location_attrs (username, domain, ruid);
CREATE INDEX location_attrs_last_modified_idx ON location_attrs (last_modified);
CREATE INDEX keepalive_idx_3 ON keepalive (slot, selected, time_sent);
CREATE INDEX keepalive_idx_4 ON keepalive (received, selected);
CREATE TRIGGER active_watchers_watcher_uri_insert
AFTER INSERT ON active_watchers
FOR EACH ROW
BEGIN
   UPDATE active_watchers SET watcher_uri = 'sip:' || NEW.watcher_username || '@' || NEW.watcher_domain where id = NEW.id;
END;
CREATE TRIGGER active_watchers_watcher_uri_update 
AFTER UPDATE ON active_watchers
FOR EACH ROW
WHEN OLD.watcher_username <> NEW.watcher_username OR OLD.watcher_domain <> NEW.watcher_domain
BEGIN
   UPDATE active_watchers SET watcher_uri = 'sip:' || NEW.watcher_username || '@' || NEW.watcher_domain where id = NEW.id;
END;
CREATE UNIQUE INDEX active_watchers_contact ON active_watchers (contact, id);
CREATE INDEX active_watchers_event_watcher_uri ON active_watchers (event, watcher_uri);
CREATE INDEX location_attrs_ruid ON location_attrs (ruid);
CREATE UNIQUE INDEX location_ruid ON location (ruid);
CREATE UNIQUE INDEX idx_dispatcher_destination on dispatcher(destination);
CREATE VIEW w_watchers_contact as
select id, case when instr(contact,';') > 0
                then substr(contact, 1, instr(contact,';')-1)
                else contact
           end as contact
from active_watchers;
CREATE VIEW presentities as
select id, cast(printf('sip:%s@%s',username,domain) as varchar(64)) presentity_uri ,
          username, domain, event, cast(substr(etag, instr(etag,'@')+1) as varchar(64)) callid, 
          datetime(received_time, 'unixepoch') as received,
          datetime(expires, 'unixepoch') as expire_date,
          expires, cast(sender as varchar(30)) sender,
          lower(cast( case when event = 'dialog' 
                           then substr(body, instr(BODY,'<state>')+7, instr(body,'</state>') - instr(body,'<state>') - 7) 
                           when event = 'presence' 
                           then case when instr(body,'<dm:note>') == 0 
                                    then replace(substr(body, instr(body,'<note>')+6, instr(body,'</note>') - instr(body,'<note>') - 6), ' ', '') 
                                    else replace(substr(body, instr(body,'<dm:note>')+9, instr(body,'</dm:note>') - instr(body,'<dm:note>') - 9), ' ', '')
                                end
                           when event = 'message-summary' 
                           then case when instr(body,'Messages-Waiting: yes') = 0 
                                     then 'Waiting' 
                                     else 'Not-Waiting' 
                                end 
                      end  as varchar(12))) state 
    from presentity;
CREATE VIEW wdispatcher as
    select *, 
        cast(substr(attrs, instr(attrs, 'zone=')+5, instr(attrs, ';profile')-instr(attrs, 'zone=')-5) as varchar(20)) zone,
        cast(substr(attrs, instr(attrs, 'duid=')+5, instr(attrs, ';node')-instr(attrs, 'duid=')-5) as integer) idx,
        cast(substr(attrs, instr(attrs, 'node=')+5) as varchar(50)) node 
    from dispatcher;
CREATE VIEW w_keepalive_contact as
     select id, slot, selected, failed, case when instr(contact,';') > 0
                                        then substr(contact, 1, instr(contact,';')-1)
                                        else contact
                                        end as contact
     from keepalive;
CREATE VIEW w_location_contact as
    select id, ruid, case when instr(contact,';') > 0
                          then substr(contact, 1, instr(contact,';')-1)
                          else contact
                          end as contact
    from location;
COMMIT;
