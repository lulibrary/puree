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
The following examples are for the Dataset resource type.

### Configuration

Create a hash for passing to an extractor.

```ruby
# Pure host with authentication.
config = {
  url:      ENV['PURE_URL'],
  username: ENV['PURE_USERNAME'],
  password: ENV['PURE_PASSWORD']
}
```

```ruby
# Pure host without authentication.
config = {
  url: ENV['PURE_URL']
}
```

### Resource

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

### Collection

Configure a collection extractor to retrieve data from a Pure host.

```ruby
collection_extractor = Puree::Extractor::Collection.new config:   config,
                                                        resource: :dataset
```

Fetch a bunch of resources.

```ruby
collection_extractor.find limit: 2
# =>
#<Puree::Model::Dataset:0xa62fd90>
#<Puree::Model::Dataset:0xa5e8c24>
```

Fetch a random resource from the entire collection.

```ruby
collection_extractor.random_resource
# =>
#<Puree::Model::Dataset:0x97998bc>
```

### Query

Get answers to important questions.

#### Funding

Configure a funding query to retrieve data from a Pure host.

```ruby
funding_query = Puree::Query::Funding.new config
```

Who are the funders (if any) for a project?

```ruby
funding_query.project_funders uuid: 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
# =>
#<Puree::Model::ExternalOrganisation:0x98986f0>
```

Who are the funders (if any) for a publication, via a project?

```ruby
funding_query.publication_funders uuid: 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
```

#### Person

Configure a person query to retrieve data from a Pure host.

```ruby
person_query = Puree::Query::Person.new config
```

Get at most ten publications published by a person during the first six months of 2017.

```ruby
person_query.publications uuid: 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx',
                          limit: 10,
                          published_start: '2017-01-01',
                          published_end: '2017-06-30'
# =>
#<Puree::Model::Publication:0x9d2c004>
#<Puree::Model::Publication:0xa285028>
```