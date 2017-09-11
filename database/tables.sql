/*****************************************

		GENERAL SCHEMA

******************************************/

CREATE SCHEMA general;
GRANT USAGE ON SCHEMA general TO dashboard, dalton;
GRANT CREATE ON SCHEMA general TO dalton WITH GRANT OPTION;

CREATE TABLE IF NOT EXISTS general.shops (
	code VARCHAR(10) PRIMARY KEY,
	name TEXT NOT NULL
);
ALTER TABLE general.shops OWNER TO dalton;
GRANT SELECT ON general.shops TO dashboard;
GRANT SELECT, UPDATE, INSERT ON general.shops TO dalton WITH GRANT OPTION;


CREATE TABLE IF NOT EXISTS general.locations (
    shop VARCHAR(10) REFERENCES general.shops(code) ON UPDATE CASCADE,
    code TEXT NOT NULL,
    name TEXT NOT NULL,
    street TEXT,
    house_number TEXT,
    postal_code TEXT,
    city TEXT,
    country TEXT,
    latitude NUMERIC,
    longitude NUMERIC,
    shop_type TEXT,
    tracked BOOLEAN DEFAULT false,
    first_tracked TIMESTAMP WITH time zone,
    last_tracked TIMESTAMP WITH time zone,
    unavailabe TIMESTAMP WITH time zone[],
    web_selection TEXT,
    web_verification TEXT,
    PRIMARY KEY (shop, code)
);
ALTER TABLE general.locations OWNER TO dalton;
GRANT SELECT ON general.locations TO service, dashboard;
GRANT SELECT, INSERT, UPDATE ON general.locations TO dalton WITH GRANT OPTION;


/*****************************************

		NORMALIZED DATA

******************************************/

/*		Static info 		 */

CREATE SCHEMA common;
GRANT USAGE ON SCHEMA common TO daltix, dashboard;
GRANT CREATE ON SCHEMA common TO dalton WITH GRANT OPTION;

CREATE TABLE IF NOT EXISTS common.remarkable_normalization_results (
    -- Yeah, yeah, horrible name, I know.
    shop VARCHAR(10) NOT NULL,
    location TEXT NOT NULL,
    product_id TEXT NOT NULL,
    downloaded_on TIMESTAMP WITH TIME ZONE NOT NULL,
    run_id INTEGER NOT NULL,
    level TEXT NOT NULL,
    message TEXT,
    PRIMARY KEY (shop, location, run_id, downloaded_on, product_id),
    FOREIGN KEY (shop, location) REFERENCES general.locations(shop, code) ON UPDATE CASCADE
);

ALTER TABLE common.remarkable_normalization_results OWNER TO dalton;
GRANT ALL PRIVILEGES ON common.remarkable_normalization_results TO dalton WITH GRANT OPTION;
GRANT SELECT ON common.remarkable_normalization_results TO daltix, dashboard; -- Who else?
GRANT UPDATE ON common.remarkable_normalization_results TO daltix, dashboard;

/*****************************************

		METRICS

******************************************/

CREATE SCHEMA metrics;
GRANT USAGE ON SCHEMA metrics TO dalton;
GRANT CREATE ON SCHEMA metrics TO dalton WITH GRANT OPTION;

CREATE TABLE IF NOT EXISTS metrics.metrics (
    shop VARCHAR(10) NOT NULL,
    location TEXT NOT NULL,
    run_id INTEGER NOT NULL,
    origin TEXT NOT NULL, -- the one who made this metric
    type TEXT NOT NULL,
    name TEXT NOT NULL,
    value TEXT NOT NULL,
    unit TEXT NOT NULL,
    measured_on TIMESTAMP WITH TIME ZONE DEFAULT now(),
    FOREIGN KEY (shop, location) REFERENCES general.locations(shop, code) ON UPDATE CASCADE,
    PRIMARY KEY(shop, location, run_id, origin, type, name, unit, measured_on)
);

ALTER TABLE metrics.metrics OWNER TO dalton;
GRANT ALL PRIVILEGES ON metrics.metrics TO dalton WITH GRANT OPTION;
GRANT SELECT ON common.remarkable_normalization_results TO daltix, dashboard;


/****************************************************

		Allow searching through different schemas

*****************************************************/

DO $$
BEGIN
	execute 'ALTER DATABASE ' || current_database() || ' SET search_path TO general, common, metrics;';
END;
$$
