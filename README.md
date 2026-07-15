# FPL-Hub-V3
Redesigned my FPL analytics pipeline to solve a scalability issue ahead of the new season. Added a season variable that tags each file/column and organizes raw data into folders, loads it through bronze/silver/gold SQL staging, and builds composite season-based surrogate keys feeding a Power BI star schema.
