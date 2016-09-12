#HSLIDE

## Rationale

Several projects revealed challenges when getting specific data from the Pure Research Information System API.

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

<a href="http://dmao.info/" target="_blank">GitHub</a>

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
- Metadata available in simple data structures. <!-- .element: class="fragment" -->
- No XML processing needed in any code. <!-- .element: class="fragment" -->

#VSLIDE

## Single resource
Tell Pur&#233;e what you are looking for...

```ruby
d = Puree::Dataset.new
metadata = d.find uuid: 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
```
...and get the data from a hash...

```ruby
metadata['doi']
```

...or using a method...

```ruby
d.doi
```

#VSLIDE

## Collection of resources
Tell Pur&#233;e what you are looking for...

```ruby
c = Puree::Collection.new resource: :dataset
metadata = c.find limit: 50
```
...and get the data from an array of hashes or from an array of instances.

#VSLIDE

## Location

<a href="https://rubygems.org/gems/puree" target="_blank">RubyGems</a>

<a href="https://github.com/lulibrary/puree" target="_blank">GitHub</a>

#VSLIDE

## Documentation

<a href="http://www.rubydoc.info/gems/puree" target="_blank">API in YARD</a>

<a href="https://aalbinclark.gitbooks.io/puree" target="_blank">Detailed usage in GitBook</a>