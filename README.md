# Pur&#233;e

Metadata extraction from the Pure Research Information System.

## Status

[![Gem Version](https://badge.fury.io/rb/puree.svg)](https://badge.fury.io/rb/puree)
[![Maintainability](https://api.codeclimate.com/v1/badges/0a0a8249dcadb444eb9e/maintainability)](https://codeclimate.com/github/lulibrary/puree/maintainability)

## Installation

Add this line to your application's Gemfile:

    gem 'puree'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install puree

## Configuration
```ruby
# For Extractor and REST modules.
config = {
  url:      'https://YOUR_HOST/ws/api/VERSION',
  username: 'YOUR_USERNAME',
  password: 'YOUR_PASSWORD',
  api_key:  'YOUR_API_KEY'
}
```

Pur&#233;e is tested using known data within a Pure installation.
 
Pur&#233;e version | Pure API version
:---: | :---:
< 2 | < 59
< 2.5 |	59, 510
2.5 |	511

## Extractor module
```ruby
# Configure an extractor for a resource
extractor = Puree::Extractor::Dataset.new config
```

```ruby
# Find out how many records are available
extractor.count
#=> 1000
```

```ruby
# Fetch a random record
extractor.random
#=> #<Puree::Model::Dataset:0x00c0ffee>
```

```ruby
# Fetch the metadata for a record with a particular identifier
dataset = extractor.find 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
#=> #<Puree::Model::Dataset:0x00c0ffee>
```

```ruby
# Access specific metadata e.g. an internal person's name
dataset.persons_internal[0].name
#=> #<Puree::Model::PersonName:0x00c0ffee @first="Foo", @last="Bar">
```

```ruby
# Select a formatting style for a person's name
dataset.persons_internal[0].name.last_initial
#=> "Bar, F."
```

## XMLExtractor module
Get Ruby objects from Pure XML.

### Single record
```ruby
xml = '<project> ... </project>'
```

```ruby
# Configure an XML extractor
xml_extractor = Puree::XMLExtractor::Project.new xml
```

```ruby
# Get a single piece of metadata
xml_extractor.title
#=> "An interesting project title"
```

```ruby
# Get all the metadata together
xml_extractor.model
#=> #<Puree::Model::Project:0x00c0ffee>
```

### Homogeneous record collection
```ruby
xml = '<result>
        <dataSet> ... </dataSet>
        <dataSet> ... </dataSet>
        ...
      </result>'
```

```ruby
# Get an array of datasets
Puree::XMLExtractor::Collection.datasets xml
#=> [#<Puree::Model::Dataset:0x00c0ffee>, ...]
```

### Heterogeneous record collection
```ruby
xml = '<result>
        <contributionToJournal> ... </contributionToJournal>
        <contributionToConference> ... </contributionToConference>
        ...
      </result>'
```

```ruby
# Get a hash of research outputs
Puree::XMLExtractor::Collection.research_outputs xml
#=> {
#     journal_articles: [#<Puree::Model::JournalArticle:0x00c0ffee>, ...],
#     conference_papers: [#<Puree::Model::ConferencePaper:0x00c0ffee>, ...],
#     theses: [#<Puree::Model::Thesis:0x00c0ffee>, ...],
#     other: [#<Puree::Model::ResearchOutput:0x00c0ffee>, ...]
#   }
```

## REST module
Query the Pure REST API.

### Client
```ruby
# Configure a client
client = Puree::REST::Client.new config
```

```ruby
# Find a person
client.persons.find id: 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
#=> #<HTTP::Response:0x00c0ffee>
```

```ruby
# Find a person, limit the metadata to ORCID and employee start date
client.persons.find id: 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx',
                    params: {fields: ['orcid', 'employeeStartDate']}
#=> #<HTTP::Response:0x00c0ffee>
```

```ruby
# Find five people, response body as JSON
client.persons.all params: {size: 5}, accept: :json
#=> #<HTTP::Response:0x00c0ffee>
```

```ruby
# Find three active academics
params = {
  size: 3,
  employmentTypeUri: ['/dk/atira/pure/person/employmenttypes/academic'],
  employmentStatus: 'ACTIVE'
}
client.persons.all_complex params: params
#=> #<HTTP::Response:0x00c0ffee>
```

```ruby
# Find research outputs for a person
client.persons.research_outputs id: 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
#=> #<HTTP::Response:0x00c0ffee>
```

### Resource
```ruby
# Configure a resource
persons = Puree::REST::Person.new config
```

```ruby
# Find a person
persons.find id: 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
#=> #<HTTP::Response:0x00c0ffee>
```

## REST module with XMLExtractor module
Query the Pure REST API and get Ruby objects from Pure XML.

```ruby
# Configure a client
client = Puree::REST::Client.new config
```

```ruby
# Find projects for a person
response = client.persons.projects id: 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
```

```ruby
# Extract metadata from XML
Puree::XMLExtractor::Collection.projects response.to_s
#=> [#<Puree::Model::Project:0x00c0ffee>, ...]
```