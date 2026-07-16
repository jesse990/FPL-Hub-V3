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

