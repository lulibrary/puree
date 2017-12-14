# Pur&#233;e

Metadata extraction from the Pure Research Information System.

## Status

[![Gem Version](https://badge.fury.io/rb/puree.svg)](https://badge.fury.io/rb/puree)
[![Build Status](https://semaphoreci.com/api/v1/aalbinclark/puree/branches/master/badge.svg)](https://semaphoreci.com/aalbinclark/puree)
[![Code Climate](https://codeclimate.com/github/lulibrary/puree/badges/gpa.svg)](https://codeclimate.com/github/lulibrary/puree)
[![Dependency Status](https://www.versioneye.com/user/projects/5899d253a86053003f389e1f/badge.svg?style=flat-square)](https://www.versioneye.com/user/projects/5899d253a86053003f389e1f)
[![GitPitch](https://gitpitch.com/assets/badge.svg)](https://gitpitch.com/lulibrary/puree)

## Installation

Add this line to your application's Gemfile:

    gem 'puree'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install puree

## Configuration
```ruby
# For Puree::Extractor and Puree::REST modules.
config = {
  url:      'https://YOUR_HOST/ws/api/59',
  username: 'YOUR_USERNAME',
  password: 'YOUR_PASSWORD',
  api_key:  'YOUR_API_KEY'
}
```

## Extractor module
Find a resource by identifer and have the metadata automatically extracted
into Ruby objects.

```ruby
# Create an extractor
extractor = Puree::Extractor::Dataset.new config
```

```ruby
# Fetch the metadata for a resource with a particular identifier
dataset = extractor.find 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
#=> #<Puree::Model::Dataset:0xCAFEBABE>
```

```ruby
# Access specific metadata e.g. an internal person's name
dataset.persons_internal[0].name
#=> #<Puree::Model::PersonName:0xCAFEBABE @first="Foo", @last="Bar">
```

```ruby
# Select a formatting style for a person's name
dataset.persons_internal[0].name.last_initial
#=> # "Bar, F."
```

## XMLExtractor module
Get Ruby objects from the XML obtained from Pure.

### Single resource
```ruby
xml = '<project> ... </project>'
```

```ruby
# Create an XML extractor
xml_extractor = Puree::XMLExtractor::Project.new xml
```

```ruby
# Get a single piece of metadata
xml_extractor.title
#=> 'An interesting project title'
```

```ruby
# Get all the metadata together
xml_extractor.model
#=> #<Puree::Model::Project:0xCAFEBABE>
```

### Homogeneous resource collection
```ruby
xml = '<result>
        <dataSet> ... </dataSet>
        <dataSet> ... </dataSet>
        ...
      </result>'
```

```ruby
Puree::XMLExtractor::Collection.datasets xml
#=> [
#     Puree::Model::Dataset:0xCAFEBABE,
#     Puree::Model::Dataset:0xCAFEBABE,
#     Puree::Model::Dataset:0xCAFEBABE,
#     ...
#   ]
```

### Heterogeneous resource collection
```ruby
xml = '<result>
        <contributionToJournal> ... </contributionToJournal>
        <contributionToConference> ... </contributionToConference>
        ...
      </result>'
```

```ruby
Puree::XMLExtractor::Collection.research_outputs xml
#=> {
#     journal_articles: [Puree::Model::JournalArticle:0xCAFEBABE, ...],
#     conference_papers: [Puree::Model::ConferencePaper:0xCAFEBABE, ...],
#     theses: [Puree::Model::Thesis:0xCAFEBABE, ...],
#     other: [Puree::Model::Publication:0xCAFEBABE, ...]
#   }
```

## REST module
Use the REST API and work with the HTTP responses.

### Client
```ruby
# Create a client
client = Puree::REST::Client.new config
```

```ruby
# Find a person
client.persons.find id: 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
#=> #<HTTP::Response:0xCAFEBABE>
```

```ruby
# Find a person, limit the metadata to ORCID and employee start date
client.persons.find id: 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx',
                    params: {fields: ['orcid', 'employeeStartDate']}
#=> #<HTTP::Response:0xCAFEBABE>
```

```ruby
# Find five people, response body as JSON
client.persons.all params: {size: 5}, accept: :json
#=> #<HTTP::Response:0xCAFEBABE>
```

```ruby
# Find research outputs for a person
client.persons.research_outputs id: 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
#=> #<HTTP::Response:0xCAFEBABE>
```

### Resource
```ruby
# Create a resource
persons = Puree::REST::Person.new config
```

```ruby
# Find a person
persons.find id: 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
#=> #<HTTP::Response:0xCAFEBABE>
```

## REST module with XMLExtractor module
Use the REST API and get Ruby objects from the XML.

```ruby
# Create a client
client = Puree::REST::Client.new config
```

```ruby
# Find projects for a person
response = client.persons.projects id: 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
```

```ruby
# Extract metadata from XML
Puree::XMLExtractor::Collection.projects response.body
#=> [
#     Puree::Model::Project:0xCAFEBABE,
#     Puree::Model::Project:0xCAFEBABE,
#     Puree::Model::Project:0xCAFEBABE,
#     ...
#   ]
```