# FPL-Hub-V3
FPL analytics pipeline redesigned for scalability ahead of the new season. A season variable now tags files/columns, organizes raw data by folder, and feeds bronze/silver/gold SQL staging. Composite season-based surrogate keys tie it all together into a Power BI star schema.

```mermaid
flowchart TD
    A[FPL API] -->|bootstrap-static, fixtures| B[Extract script]
    B -->|writes season-tagged files| C[(Organised folders)]
    C -->|reads files| D[Load script]
    D -->|raw load, no transform| E[(Bronze - stg_ tables)]
    E -->|reads stg_ tables| F[Silver - v_ views]
    F -->|type casting, format cleanup, single-source| G[Gold - dim_ / fact_ views]
    G -->|joins, corrections, star schema shape| H[Power BI]
```
## Tech stack

- **Source**: FPL API (`bootstrap-static`, fixtures endpoints)
- **Extraction / loading**: Python (pandas, SQLAlchemy, pyodbc)
- **Database**: SQL Server 2025, SSMS
- **Transformation**: T-SQL (bronze/silver/gold views)
- **Reporting**: Power BI Desktop (Import mode, DAX)

## Data Model

```mermaid
erDiagram
  DIM_TEAMS ||--o{ FACT_TABLE : teamkey
  DIM_TEAMS ||--o{ FIXTURE_BRIDGE : teamkey
  FIXTURE_BRIDGE ||--o{ DIM_FIXTURE : fixkey
  DIM_FIXTURE ||--o{ FACT_TABLE : fixkey
  DIM_PLAYERS ||--o{ FACT_TABLE : playerkey
  DIM_SEASONS ||--o{ FACT_TABLE : season_id

  DIM_TEAMS {
    int teamkey PK
    string code
    int id
    int idkey
    string name
    string short_name
    int season
    string badge
  }
  DIM_PLAYERS {
    int playerkey PK
    int elementkey
    string code
    int id
    string display_name
    string name
    string photo
    string position
    int position_id
  }
  DIM_FIXTURE {
    int fixkey PK
    date date
    bool finished
    string away
    string away_badge
    string away_code
    int away_key
    int away_score
    ... ...
  }
  DIM_SEASONS {
    int season_id PK
    string season
  }
  FIXTURE_BRIDGE {
    int fixkey FK
    int gameweek
    string home_away
  }
  FACT_TABLE {
    string playerkey
    int goals
    int assists
    int gw
    float xg
    int defcon
    int corners_indirect_fk_rank
    int direct_fk_rank
    ... ...
  }
```
