CREATE TYPE param (
    name text,
    type int,
    position int,
);

CREATE TYPE materialized_param (
  name  text,
  type  text,
  position int,
  value blob,
);

CREATE TABLE task_registry (
  domain_id      uuid,
  type           int, -- workflow or activity
  name           text,
  version        int,
  id             uuid,
  parent_id      uuid,
  inputs         list<frozen <param>>,
  default_inputs list<frozen <materialized_param>>,
  outputs        list<frozen <param>>,
  created_time   timestamp,
  created_by     text,
PRIMARY KEY (domain_id, type, name, version)
) WITH COMPACTION = {
'class': 'org.apache.cassandra.db.compaction.LeveledCompactionStrategy'
};

CREATE INDEX task_by_id ON task_registry (id);

CREATE TABLE resources (
  domain_id      uuid,
  type           int,
  name           text,
  version        int,
  id             uuid,
  content        blob,
  created_time   timestamp,
  created_by     text,
PRIMARY KEY (domain_id, name, version)
) WITH COMPACTION = {
'class': 'org.apache.cassandra.db.compaction.LeveledCompactionStrategy'
};

CREATE INDEX resource_by_id ON resources (id);

CREATE TABLE resource_sets (
  domain_id           uuid,
  name                text,
  version             int,
  resources           list<uuid>,
  owner               text,
  created_time        timestamp,
  created_by          text,
  is_active           boolean,
  prev_active_version int,
PRIMARY KEY (domain_id, name, version)
) WITH COMPACTION = {
'class': 'org.apache.cassandra.db.compaction.LeveledCompactionStrategy'
};

CREATE INDEX resource_sets_by_name ON resource_sets (name);
CREATE INDEX resource_sets_is_active ON resource_sets (is_active);
