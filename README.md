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
dataset = extractor.find 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
#=>
#<Puree::Model::Dataset:0xCAFEBABE>
```

```ruby
# Access specific metadata e.g. an internal person's name
dataset.persons_internal[0].name
#=>
#<Puree::Model::PersonName:0xCAFEBABE @first="Foo", @last="Bar">
```

```ruby
# Select a formatting style for a person's name
dataset.persons_internal[0].name.last_initial
#=>
# "Bar, F."
```