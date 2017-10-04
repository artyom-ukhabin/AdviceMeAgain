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
* correct pattern name for thing that I called decorator - facade - see Sandy Metz 4 rules

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
* definitely dirty wrong abstraction with recommendations decorators. Find the way to refactor. Also, fetchers vs decorators?
* its possible to ajax when page is ready instead of setting @ variable for random recommendations section (now variables just flying around)
* URGENT: pub-sub system, ^ 3th point (maybe for chat in phase 3)
* reasonability content/collaborative filterings for personality
* URGENT: refactor genres system - look like sti but with different tables. Very bad solution now.
  > Start analysis phase from here
  >(it can be be as elegant as sti if define "find(type, id)" method in parent Genre class: "#{type}Genre.find(id)")

# Phase 3
* css
* pub-sub system (for recommendations update or chat)
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
* nested layouts, place for layouts logic - helpers? Investigate where to place layouts css/js too.

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