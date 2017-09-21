# Dependencies

# Services to start
*redis
*sidekiq
*elasticsearch

# Global
* n+1 queries
* think about extracting services into engines
* private network for elasticsearch?
* maybe personalities posts
* >> urgent: classes for coffee
* optional death date for Personality

# Phase 1
* refactor voting system

# Phase 2
* collaborations: maybe queue for updating index
* rework elastic collections and read about indexes
* IMPORTANT: maybe spinners for collaborations update
* analyze and rework interfaces caused by autocomplete/miltitoken
* think about architecture and association/aggregation with content/personality aggregators like examples << urgent for analysis phase
* add images for selections for personality_content form on personality page
    (options, templateSelection, https://stackoverflow.com/questions/33926375/how-to-pass-option-attributes-to-select2)
* tabs for recommendation page

# Phase 3
* roles
* <move info here later>

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
* especially: view folders
* model objects, representers

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
8) Consistency: not null, complex keys, actions on destroy

Hint: elasticsearch-rails can generate app with bootstrap integration