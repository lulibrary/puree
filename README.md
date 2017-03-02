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

### Single resource

Configure a resource extractor to get data from a Pure host.

```ruby
dataset_extractor = Puree::Extractor::Dataset.new url: ENV['PURE_URL']
```

Provide authentication details if needed.

```ruby
dataset_extractor.basic_auth username: ENV['PURE_USERNAME'],
                             password: ENV['PURE_PASSWORD']
```
Fetch the metadata.

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

Choose a formatting style for a person's name.

```ruby
dataset.persons_internal[0].name.last_initial
# =>
# "Bar, F."
```

### Collection

Configure a collection extractor to get data from a Pure host.

```ruby
collection_extractor = Puree::Extractor::Collection.new url: ENV['PURE_URL'],
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
```


