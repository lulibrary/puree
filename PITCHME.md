#HSLIDE

## Rationale

Projects revealed challenges getting specific data from the Pure Research Information System API.

#VSLIDE

## DOI minting

Transforming metadata to the DataCite XML schema and minting Digital Object Identifiers.

<a href="https://github.com/lulibrary/doi" target="_blank">GitHub</a>

#VSLIDE

## Fedora repository

Transforming metadata to RDF and ingesting via REST API.

#VSLIDE

## Linked open data

Transforming metadata to RDF and publishing in Fuseki triple store.

#VSLIDE

## Primo

Enriching author metadata.

#VSLIDE

## DMAOnline

Ingesting research data management data from the Current Research Information System (CRIS) of multiple institutions.

<a href="http://dmao.info/" target="_blank">Project website</a>

#HSLIDE

## Pure API challenges

#VSLIDE

- Metadata at resource level e.g. dataset.
- Only XML available. <!-- .element: class="fragment" -->
- XML needs processing to extract specific metadata. <!-- .element: class="fragment" -->
- Local web services consuming the Pure API are not useful when contributing FOSS. <!-- .element: class="fragment" -->

#HSLIDE

## Pur&#233;e: an answer to the challenges

#VSLIDE

- Consumes the Pure API.
- Metadata available as Ruby data models. <!-- .element: class="fragment" -->
- No XML processing needed in any code. <!-- .element: class="fragment" -->

#VSLIDE

## Resource

Configure an extractor to retrieve data from a Pure host.

```ruby
dataset_extractor = Puree::Extractor::Dataset.new config
```

Fetch the metadata for a resource with a particular identifier.

```ruby
dataset = dataset_extractor.find uuid: 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
# =>
#<Puree::Model::Dataset:0x987f7a4>
```

Access specific metadata e.g. an internal person's name.

```ruby
dataset.persons_internal[0].name
# =>
#<Puree::Model::PersonName:0x9add67c @first="Foo", @last="Bar">
```

Select a formatting style for a person's name.

```ruby
dataset.persons_internal[0].name.last_initial
# =>
# "Bar, F."
```

#VSLIDE

## Collection

Configure a collection extractor to retrieve data from a Pure host.

```ruby
collection_extractor = Puree::Extractor::Collection.new config:   config,
                                                        resource: :dataset
```

Fetch a bunch of resources.

```ruby
dataset_collection = collection_extractor.find limit: 2
# =>
#<Puree::Model::Dataset:0xa62fd90>
#<Puree::Model::Dataset:0xa5e8c24>
```

Fetch a random resource from the entire collection.

```ruby
random_dataset = collection_extractor.random_resource
# =>
#<Puree::Model::Dataset:0x97998bc>
```

#VSLIDE

## Location

<a href="https://rubygems.org/gems/puree" target="_blank">RubyGems</a>

<a href="https://github.com/lulibrary/puree" target="_blank">GitHub</a>