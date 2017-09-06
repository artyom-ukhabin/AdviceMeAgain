# Dependencies

# Services to start
*redis
*sidekiq
*elasticsearch

# Global
* n+1 queries
* think about extracting services into engines
* private network for elasticsearch?

# Phase 1
* refactor voting system

# Phase 2
* collaborations: maybe background, queue for updating index, redis(?)
* rework elastic collections and read about indexes

Some of used techniques:
* Decorator
* Query object
* Duck types
* Hierarchical controllers organization

Plans:
* chat(sockets)

Things to learn:
* DRY vs duplications
* more SOLID
* folders and namespaces

Phase 2 is in progress.

Phase 2:
1) Collaboration filtering. Recommendations page with ~5 metrics for each rateable
2) background job + indexes or nosql base or cache or something for collaboration filtering data. Maybe elasticsearch.
2.5) Redis queue
3) recommendations section with random metric
4) ajax with alert/link/section after click rate
5) Content oriented search in contradiction to collaborating search - user oriented. Base: genres. (and tags?)
6) rake task for generating a lot of data
7) n+1 queries

Hint: elasticsearch-rails can generate app with bootstrap integration