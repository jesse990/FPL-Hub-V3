# FPL-Hub-V3
FPL analytics pipeline redesigned for scalability ahead of the new season. A season variable now tags files/columns, organizes raw data by folder, and feeds bronze/silver/gold SQL staging. Composite season-based surrogate keys tie it all together into a Power BI star schema.

```mermaid
flowchart TD
    A[FPL API] -->|bootstrap-static, fixtures| B[Extract script]
    B -->|writes season-tagged files| C[(Organised folders)]
    C -->|reads files| D[Load script]
    D -->|dtype=str, no transform| E[SQL staging]
    E -->|stg_ tables| F[Bronze / silver / gold views]
    F -->|v_ views, corrections, joins| G[Star schema]
    G -->|fact_player_gameweek + dims| H[Power BI]
```
```
