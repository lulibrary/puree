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

Configure an extractor to get data from a Pure host.

```ruby
extractor = Puree::Extractor::Dataset.new url: ENV['PURE_URL']
```

Provide authentication details if needed.

```ruby
extractor.basic_auth username: ENV['PURE_USERNAME'],
                     password: ENV['PURE_PASSWORD']
```
Fetch the metadata.

```ruby
dataset = extractor.find uuid: 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
#=>
#<Puree::Model::Dataset:0x987f7a4>
```

### Collection of resources
Fetch a bunch.

```ruby
extractor = Puree::Extractor::Collection.new url: ENV['PURE_URL'],
                                             resource: :dataset
collection = extractor.find limit: 50
```

### Person name formatting
TO DO

### Random resource
TO DO

