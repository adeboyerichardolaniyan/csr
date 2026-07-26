-- ============================================================
-- Commercial Signal Room
-- Initial Snowflake setup
-- ============================================================

USE ROLE ACCOUNTADMIN;

-- A warehouse is the compute engine that runs our SQL.
CREATE WAREHOUSE IF NOT EXISTS CSR_WH
    WAREHOUSE_SIZE = 'XSMALL'
    AUTO_SUSPEND = 60
    AUTO_RESUME = TRUE
    INITIALLY_SUSPENDED = TRUE
    COMMENT = 'Compute warehouse for the Commercial Signal Room portfolio project';

-- A database is the top-level container for our project data.
CREATE DATABASE IF NOT EXISTS COMMERCIAL_SIGNAL_ROOM;

USE DATABASE COMMERCIAL_SIGNAL_ROOM;

-- RAW contains source data as close as possible to its original form.
CREATE SCHEMA IF NOT EXISTS RAW;

-- STAGING contains cleaned and standardized source records.
CREATE SCHEMA IF NOT EXISTS STAGING;

-- MARTS contains business-facing analytical models.
CREATE SCHEMA IF NOT EXISTS MARTS;

-- INSIGHTS contains decision-ready conclusions and supporting evidence.
CREATE SCHEMA IF NOT EXISTS INSIGHTS;

-- APP contains small operational objects used by our product.
CREATE SCHEMA IF NOT EXISTS APP;

USE WAREHOUSE CSR_WH;
USE SCHEMA APP;

-- This temporary table proves that Snowflake, FastAPI and React
-- can communicate before we introduce large public datasets.
CREATE TABLE IF NOT EXISTS SYSTEM_STATUS (
    STATUS_ID INTEGER AUTOINCREMENT START 1 INCREMENT 1,
    SERVICE_NAME VARCHAR(100) NOT NULL,
    STATUS VARCHAR(30) NOT NULL,
    MESSAGE VARCHAR(500),
    UPDATED_AT TIMESTAMP_TZ DEFAULT CURRENT_TIMESTAMP()
);

TRUNCATE TABLE SYSTEM_STATUS;

INSERT INTO SYSTEM_STATUS (
    SERVICE_NAME,
    STATUS,
    MESSAGE
)
VALUES (
    'Commercial Signal Room',
    'healthy',
    'Snowflake is connected and ready for public commercial data.'
);

SELECT
    STATUS_ID,
    SERVICE_NAME,
    STATUS,
    MESSAGE,
    UPDATED_AT
FROM SYSTEM_STATUS;