BEGIN;

CREATE TABLE events (
    key             UUID,  -- event key
    source          TEXT,  -- identification of external source of the event
    ev_type         TEXT,  -- event type
    description     TEXT,  -- event's description
    data            JSONB,  -- related data in json format
    ev_time         timestamp,  -- event's generation time
    tags            integer[]  -- tags defined by the client
) PARTITION BY RANGE (ev_time);

-- 6 hours partition
CREATE TABLE events_20190201_0
    (LIKE events INCLUDING DEFAULTS INCLUDING CONSTRAINTS)
    PARTITION BY HASH (source);

CREATE TABLE events_20190201_6
    (LIKE events INCLUDING DEFAULTS INCLUDING CONSTRAINTS)
    PARTITION BY HASH (source);

CREATE TABLE events_20190201_12
    (LIKE events INCLUDING DEFAULTS INCLUDING CONSTRAINTS)
    PARTITION BY HASH (source);

CREATE TABLE events_20190201_18
    (LIKE events INCLUDING DEFAULTS INCLUDING CONSTRAINTS)
    PARTITION BY HASH (source);

-- hash partitions
CREATE TABLE events_20190201_0_0
    (LIKE events_20190201_0 INCLUDING DEFAULTS INCLUDING CONSTRAINTS);
ALTER TABLE events_20190201_0 ATTACH PARTITION events_20190201_0_0
    FOR VALUES WITH (MODULUS 6, REMAINDER 0);

CREATE TABLE events_20190201_0_1
    (LIKE events_20190201_0 INCLUDING DEFAULTS INCLUDING CONSTRAINTS);
ALTER TABLE events_20190201_0 ATTACH PARTITION events_20190201_0_1
    FOR VALUES WITH (MODULUS 6, REMAINDER 1);

CREATE TABLE events_20190201_0_2
    (LIKE events_20190201_0 INCLUDING DEFAULTS INCLUDING CONSTRAINTS);
ALTER TABLE events_20190201_0 ATTACH PARTITION events_20190201_0_2
    FOR VALUES WITH (MODULUS 6, REMAINDER 2);

CREATE TABLE events_20190201_0_3
    (LIKE events_20190201_0 INCLUDING DEFAULTS INCLUDING CONSTRAINTS);
ALTER TABLE events_20190201_0 ATTACH PARTITION events_20190201_0_3
    FOR VALUES WITH (MODULUS 6, REMAINDER 3);

CREATE TABLE events_20190201_0_4
    (LIKE events_20190201_0 INCLUDING DEFAULTS INCLUDING CONSTRAINTS);
ALTER TABLE events_20190201_0 ATTACH PARTITION events_20190201_0_4
    FOR VALUES WITH (MODULUS 6, REMAINDER 4);

CREATE TABLE events_20190201_0_5
    (LIKE events_20190201_0 INCLUDING DEFAULTS INCLUDING CONSTRAINTS);
ALTER TABLE events_20190201_0 ATTACH PARTITION events_20190201_0_5
    FOR VALUES WITH (MODULUS 6, REMAINDER 5);

-- attach 1th partition level to events table
ALTER TABLE events ATTACH PARTITION events_20190201_0
    FOR VALUES FROM ('2019-02-01 00:00:00') TO ('2019-02-01 06:00:00');

END;
