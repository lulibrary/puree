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


## Usage

### Configuration
```ruby
# Used by classes in the Puree::API and Puree::Extractor namespaces.
config = {
  url:      'https://YOUR_HOST/ws/api/59',
  username: 'YOUR_USERNAME',
  password: 'YOUR_PASSWORD',
  api_key:  'YOUR_API_KEY'
}
```

### Find a resource by ID and get a usable Ruby object

```ruby
# Create an extractor
extractor = Puree::Extractor::Dataset.new config
```

```ruby
# Fetch the metadata for a resource with a particular identifier
dataset = extractor.find id: 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
# =>
#<Puree::Model::Dataset:0xCAFEBABE>
```

```ruby
# Access specific metadata e.g. an internal person's name
dataset.persons_internal[0].name
# =>
#<Puree::Model::PersonName:0xCAFEBABE @first="Foo", @last="Bar">
```

```ruby
# Select a formatting style for a person's name
dataset.persons_internal[0].name.last_initial
# =>
# "Bar, F."
```

### Map XML from API responses to Ruby objects

#### Single resource
```ruby
xml = '<project>...</project>'
```

```ruby
# Create an XML extractor
extractor = Puree::XMLExtractor::Project.new xml: xml
```

```ruby
# Get a single piece of metadata
extractor.title
#=> 'An interesting project title'
```

```ruby
# Get all the metadata together
extractor.model
#=> #<Puree::Model::Project:0xCAFEBABE>
```

#### Resource collection


#### Classify a heterogeneous collection of research outputs
```ruby
xml = '<result>
        <contributionToJournal> ... </contributionToJournal>
        <contributionToConference> ... </contributionToConference>
        ...
      </result>'
```

```ruby
Puree::XMLExtractor::PublicationCollection.classify xml: xml
#=> {
#     journal_article: [Puree::Model::JournalArticle:0xCAFEBABE, ...],
#     conference_paper: [Puree::Model::ConferencePaper:0xCAFEBABE, ...],
#     thesis: [Puree::Model::Thesis:0xCAFEBABE, ...],
#     other: [Puree::Model::Publication:0xCAFEBABE, ...]
#   }
```

### API wrapper

Get raw HTTP responses.

#### Client
```ruby
# Create a client
client = Puree::API::Client.new config
```

```ruby
# Find a person
client.persons.find id: 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
```

```ruby
# Find a person, limit the metadata to ORCID and employee start date
client.persons.find id: 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx',
                               params: {fields: ['orcid', 'employeeStartDate']}
```

```ruby
# Find five people, response body as JSON
client.persons.all params: {size: 5}, accept: :json
```

```ruby
# Find research outputs for a person
client.persons.research_outputs id: 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
```

#### Resource

```ruby
# Create a resource
persons = Puree::API::Resource::Person.new config
```

```ruby
# Find a person
persons.find id: 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
```