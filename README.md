# Pur&#233;e
Consumes the Pure Research Information System API and puts the metadata into simple data structures.

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

### Collection of resources
Tell Pur&#233;e what you are looking for...

```ruby
c = Puree::Collection.new resource: :dataset
metadata = c.find limit: 50
```
...and get the data from an array of hashes or from an array of instances.

## Documentation
[API in YARD](http://www.rubydoc.info/gems/puree)

[Detailed usage in GitBook](https://aalbinclark.gitbooks.io/puree)