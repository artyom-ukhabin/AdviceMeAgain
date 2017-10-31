# Dependencies

# Services to start
*redis
*sidekiq
*elasticsearch

# Global
* n+1 queries
* think about extracting services into gems
* private network for elasticsearch?
* maybe personalities posts
* >> urgent: classes for coffee
* optional death date for Personality
* correct pattern name for thing that I called decorator - facade - see Sandy Metz 4 rules
* IMPORTANT: add multitoken fields on creating entities(personality, content, genre)
* Consistency: not null, complex keys, actions on destroy

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
* IMPORTANT: pub-sub system, ^ 3th point (maybe for chat in phase 3)
* reasonability content/collaborative filterings for personality
* URGENT: refactor genres system - look like sti but with different tables. Very bad solution now.
  > Start analysis phase from here
  >(it can be be as elegant as sti if define "find(type, id)" method in parent Genre class: "#{type}Genre.find(id)")
* URGENT: delete duplication in elasticsearch models - item_prediction, recommendations_connector and in workers/updaters
* MANDATORY: write task to reindexing elasticsearch. Cause this is not funny and never was.
* URGENT: maybe some sort of system for tie all updaters for content based filtering. Implement pub-sub or callbacks?
* clean users_controller garbage
* One generalizator for elastic models
* document types of elastic depends from module names now. Rework.
* URGENT: learn these freaking elasticsearch/elasticsearch gems at last
* MANDATORY: check percent numbers for content and personalities in content based recommendations.
* MANDATORY: Recommendations doesnt deleting after deleting users in collaborative filtering. Fix.
* refactor content based updaters - scope for arrays and for single

# Deploy
* MANDATORY: add build recommendations rake tasks in init script
* MANDATORY: assets are not clearing between deploys
* some issues, described in the different place

# Phase 3
* css
* pub-sub system (for recommendations update or chat)
* roles
* move info here later

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

# Current status
Project is freezed right now. Dont forget to fix recommendations for both collaborative and content based before phase 3.

Hint: elasticsearch-rails can generate app with bootstrap integration
Find the way to recreate ES index: (#{Model}.gateway.create_index! force: true and run both top-level rake tasks for now)