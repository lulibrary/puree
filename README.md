# Pur&#233;e [![Gem Version](https://badge.fury.io/rb/puree.svg)](https://badge.fury.io/rb/puree)
A Ruby client for the Pure Research Information System API.


## Installation

Add this line to your application's Gemfile:

    gem 'puree'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install puree

## Usage
### Configuration
Set the endpoint for Pure (e.g. `http://www.example.com/ws/rest`) and the
authentication credentials. Basic authentication can be turned off.

```ruby

# Global settings using a block
Puree.configure do |config|
  config.endpoint   = ENV['PURE_ENDPOINT']   # optional, default nil
  config.username   = ENV['PURE_USERNAME']   # optional, default nil
  config.password   = ENV['PURE_PASSWORD']   # optional, default nil
  config.basic_auth = true                   # optional, default false
end

# Global settings individually
Puree.endpoint   = ENV['PURE_ENDPOINT']      # optional, default nil
Puree.username   = ENV['PURE_USERNAME']      # optional, default nil
Puree.password   = ENV['PURE_PASSWORD']      # optional, default nil
Puree.basic_auth = true                      # optional, default false

# Use global settings
d = Puree::Dataset.new

# Override one or more global settings in an instance
d = Puree::Dataset.new endpoint:   ENV['ANOTHER_PURE_ENDPOINT'],  # optional, default nil
                       username:   ENV['ANOTHER_PURE_USERNAME'],  # optional, default nil
                       password:   ENV['ANOTHER_PURE_PASSWORD'],  # optional, default nil
                       basic_auth: true                           # optional, default false
```

### Dataset
Get the metadata into a hash.

```ruby
d = Puree::Dataset.new

# Get metadata using ID
metadata = d.find id: 12345678

# Reuse instance with another ID
metadata = d.find id: 87654321

# Get metadata using UUID
metadata = d.find uuid: 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'

# Get specific metadata
metadata['doi']

# Access HTTParty functionality
d.response # HTTParty object
d.response.body # XML
d.response.code
d.response.message
d.response.headers # hash
```

### Collection (dataset)
Get an array of metadata of resource type specified in constructor. The limit parameter has no maximum value.

```ruby
c = Puree::Collection.new resource: :dataset

# Get metadata for fifty datasets, starting at record ten, created and modified in January 2016
metadata =  c.find limit:          50,            # optional, default 20, no maximum
                   offset:         10,            # optional, default 0
                   created_start:  '2016-01-01',  # optional
                   created_end:    '2016-01-31',  # optional
                   modified_start: '2016-01-01',  # optional
                   modified_end:   '2016-01-31'   # optional
```


Get just the UUIDs

`full: false`

### Download (dataset)
Uses limit and offset like Collection. Resources available :dataset.

```ruby
p = Puree::Download.new
metadata = p.find resource: :dataset,
                  limit:    1000
```

## Resource data structures

### Common to all
#### created
#### modified
#### uuid

### Dataset
access
associated

#### available
Date made available. If year is present, month and day will have data or an empty string.

```ruby
{
  "year" => "2016",
  "month" => "2",
  "day" => "4"
}
```

#### description
#### doi

#### file
An array of files.

```ruby
[
  {
    "name" => "foo.csv",
    "mime" => "application/octet-stream",
    "size" => "1616665158",
    "url" => "http://example.com/ws/rest/files/12345678/foo.csv",
    "title" => "foo.csv",
    "license" => {
      "name" => "CC BY-NC",
      "url" => "http://creativecommons.org/licenses/by-nc/4.0/"
    }
  },
]
```

#### geographical
#### keyword

#### link
An array of links.

```ruby
[
  {
    "url" => "http://www.example.com/~abc1234/xyz/",
    "description" => "An interesting description"
  },
]
```

#### owner
Organisation responsible.

```ruby
{
  "uuid" => "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx",
  "name" => "Institute for the Arts",
  "type" => "Department"
}
```

#### person
Contains an array of internal persons, an array of external persons and an array of other persons.

```ruby
{
  "internal" => [
    {
      "name" => {
        "first" => "Stan",
        "last" => "Laurel"
       },
       "role" => "Creator",
       "uuid" => "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
    },
  ],
  "external" => [
  ],
  "other" => [
    {
      "name" => {
        "first" => "Hal",
        "last" => "Roach"
      },
      "role" => "Contributor",
      "uuid" => ""
    },
  ]
}
```


#### project
An array of projects associated with the dataset.

```ruby
[
  {
    "title" => "An interesting project title",
    "uuid" => "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
  },
]
```

#### publication
An array of research outputs associated with the dataset.

```ruby
[
  {
    "type" => "Journal article",
    "title" => "An interesting journal article title",
    "uuid" => "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
  },
  {
    "type" => "Conference paper",
    "title" => "An interesting conference paper title",
    "uuid" => "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
  },
  {
    "type" => "Working paper",
    "title" => "An interesting working paper title",
    "uuid" => "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
  },
  {
    "type" => "Paper",
    "title" => "An interesting paper title",
    "uuid" => "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
  },
  {
    "type" => "Dataset",
    "title" => "An interesting dataset title",
    "uuid" => "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
  },
  {
    "type" => "Chapter",
    "title" => "An interesting chapter title",
    "uuid" => "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
  },
]
```

#### publisher


#### production, temporal
Date range. If year is present, month and day will have data or an empty string.

```ruby
{
  "start" => {
    "year" => "2005",
    "month" => "5",
    "day" => "10"
  },
  "end" => {
    "year" => "2011",
    "month" => "9",
    "day" => "18"
  }
}
```

#### title


### Organisation

#### address
An array of addresses.

```ruby
[
  {
    "street" => "Lancaster University",
    "building" => "Bowland North",
    "postcode" => "LA1 4YN",
    "city" => "Lancaster",
    "country" => "United Kingdom"
  },
]
```

#### parent
Parent organisation.

```ruby
{
  "uuid" => "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx",
  "name" => "Institute for the Arts",
  "type" => "Department"
}
```

### Project

#### owner
Organisation responsible.

```ruby
{
  "uuid" => "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx",
  "name" => "Institute for the Arts",
  "type" => "Department"
}
```

#### temporal
```ruby
{
  "temporal" => {
    "expected" => {
      "start" => "2016-03-01Z",
      "end" => "2018-02-28Z"
    },
    "actual" => {
      "start" => "2016-03-01Z",
      "end" => ""
    }
  }
}
```

### Publication

#### file
An array of files.

```ruby
[
  {
    "name" => "foo.csv",
    "mime" => "application/octet-stream",
    "size" => "1616665158",
    "url" => "http://example.com/ws/rest/files/12345678/foo.csv",
  },
]
```

## Other data structures
### Download
An array of hashes, where each hash is a resource.

```ruby
[
  {
    "uuid" => "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx",
    "download" => "1999"
  },
  {
    "uuid" => "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx",
    "download" => "666"
  },
]
```

## Utilities

### Convert date to ISO 8601 format.

```ruby
Puree::Date.iso d.available
```
```ruby
{
  "year" => "2016",
  "month" => "4",
  "day" => "18"
}
```
becomes

```ruby
"2016-04-18"
```


## API coverage
Version

```ruby
5.5.1
```

Resource metadata

```ruby
:dataset
:event
:organisation
:person
:publication
```

Collections

```ruby
:dataset
:event
:journal
:organisation
:person
:project
:publication
:publisher
```

Other metadata

```ruby
:download
:server
```