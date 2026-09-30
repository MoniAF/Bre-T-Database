# BRET Database 🗄️

An Oracle Database project for an employment platform. It manages job categories, job listings, user accounts, professional profiles, profile-to-job relationships, and comments.

The project demonstrates relational database design, access control, auditing, and PL/SQL programming with triggers, functions, and stored procedures.

## Features

- Relational tables with primary and foreign key constraints
- Sample records for categories, users, profiles, comments, and profile-to-job relationships
- Oracle users and roles with different access privileges
- Tablespaces for administration, user control, accounting, and auditing
- Triggers for automatic ID generation and data validation
- Audit tables and triggers for tracking changes
- PL/SQL functions for counts and job statistics
- Stored procedures for reports by province and year

## Database Structure

The main `ADMIN_BRT` schema contains six tables:

| Table | Purpose |
| --- | --- |
| `CATEGORIES` | Job categories |
| `JOBS` | Job listings, including cost, description, category, and creation date |
| `USERS` | User account details |
| `PROFILES` | Professional profile information associated with users |
| `TBL_PROFILE_JOBS` | Junction table connecting profiles and jobs |
| `COMMENTARIES` | Comments associated with profiles |

The `AUDIT_BRT` schema contains audit tables for users, comments, profiles, and jobs.

## Users and Roles

The administration script defines these database users:

- `ADMIN_BRT` — main application schema and database administration
- `CONTROLDATA_BRT` — data consultation and analysis
- `ACCOUNTANT_BRT` — read access to jobs and categories
- `TYPIST_BRT` — data entry
- `AUDIT_BRT` — auditing

The roles are `ADMIN_DBABRT`, `READER_DBABRT`, `TYPIST_DBABRT`, and `AUDITOR_DBABRT`. Each role groups privileges for its intended database responsibilities.

## Tablespaces

The scripts define the following tablespaces:

- `ADMINISTRADOR_TS`
- `USER_CONTROL_TS`
- `ACCOUNTING_TS`
- `AUDIT_TS`

## Triggers and Auditing

The main schema includes triggers that generate IDs for categories, jobs, profiles, users, and comments. It also includes `VERIFY_EMAIL` to check for duplicate user emails and `CHECK_JOBS_DESCRIPTION` to supply a default description when one is not provided.

Audit triggers record `INSERT`, `UPDATE`, and `DELETE` operations on `USERS`, `COMMENTARIES`, `PROFILES`, and `JOBS`. Audit records include the operation date, event type, and relevant values from the affected row.

## PL/SQL Functions

| Function | Purpose |
| --- | --- |
| `CANT_JOBS` | Counts jobs in a category |
| `FN_PROVINCIA_MAYOR_TRABAJOS` | Returns the province with the most jobs |
| `FN_PROVINCIA_MENOR_TRABAJOS` | Returns the province with the fewest jobs |
| `FN_TRABAJO_MAYOR_COSTO` | Returns the highest-cost job |
| `FN_TRABAJO_MENOR_COSTO` | Returns the lowest-cost job |
| `FN_TRABAJO_MAYOR_COSTO_ANNO` | Returns the highest-cost job for a given year |
| `FN_TRABAJO_MENOR_COSTO_ANNO` | Returns the lowest-cost job for a given year |

## Stored Procedures

| Procedure | Purpose |
| --- | --- |
| `JOBS_PROVINCE` | Displays jobs grouped by province |
| `COUNT_JOBS_PROVINCE` | Counts jobs by province |
| `BIGGEST_JOBS_ANNIO` | Reports the year with the most registered jobs |
| `LOWEST_JOBS_ANNIO` | Reports the year with the fewest registered jobs |
| `PR_USUARIOS_POR_ANNO` | Reports registered users by year |

The procedures use PL/SQL features such as cursors, joins, aggregate queries, and `DBMS_OUTPUT`.

## Project Files

| File | Contents |
| --- | --- |
| `AdministradorFINAL.sql` | Tablespaces, database users, roles, and privileges |
| `ADMIN_BRT_FINAL.sql` | Main tables, constraints, sample data, and validation/ID triggers |
| `AUDIT_BRT_FINAL.sql` | Audit tables and audit triggers |
| `CONTROLDATA_BRT_FINAL.sql` | PL/SQL functions, procedures, and reporting queries |

## Technologies

- Oracle Database
- SQL and PL/SQL
- Relational database design
- Database users, roles, and privileges
- Tablespaces
- Triggers, functions, and stored procedures
- Database auditing

## Academic Context

This project was developed as an academic database project to apply relational modeling, database administration, access control, auditing, and PL/SQL programming concepts.
