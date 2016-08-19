# Pur&#233;e [![Gem Version](https://badge.fury.io/rb/puree.svg)](https://badge.fury.io/rb/puree)
Pur&#233;e consumes the Pure Research Information System API and puts the metadata into simple data structures.

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
[API in YARD](http://www.rubydoc.info/gems/puree/frames)

[Detailed usage](https://github.com/lulibrary/puree/wiki)




