# Pur&#233;e

A Ruby client for the Pure Research Information System API.

## API coverage
- Version: 5.5.1.
- Resources: Dataset.
- Collections: Dataset, Organisation, Person, Project, Publication

## Installation

Add this line to your application's Gemfile:

    gem 'puree'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install puree

## Usage
```ruby
endpoint = 'http://example.com/ws/rest'
```

Dataset.

```ruby
d = Puree::Dataset.new

# Get metadata using ID
d.get id:       12345678,
      endpoint: endpoint,
      username: username,
      password: password

# Get metadata using UUID
d.get uuid:     'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx',
      endpoint: endpoint,
      username: username,
      password: password

# Filter metadata into simple data structures
d.title
d.description
d.keyword
d.person
d.temporal
d.geographical
d.file
d.publication
d.available
d.access
d.doi

# Combine metadata into one simple data structure
d.metadata

# Access HTTParty functionality
d.response # HTTParty object
d.response.body # XML
d.response.code
d.response.message
d.response.headers # hash
```

Collection.

```ruby
dc = Puree::Collection.new(:dataset)

# Get minimal datasets, optionally specifying a quantity (default is 20)
dc.get endpoint: endpoint,
       username: username,
       password: password,
       qty:      1000

# Get UUIDs for datasets
uuids = dc.UUID

# Get metadata using UUID
datasets = []
uuids.each do |uuid|
    d = Puree::Dataset.new
    d.get endpoint: endpoint,
          username: username,
          password: password,
          uuid:     uuid
    datasets << d.metadata
end
```

## Utilities

### Convert date to ISO 8601 format.

```ruby
Puree::Date.iso d.available
```
```ruby
{
  "year"=>"2016",
  "month"=>"4",
  "day"=>"18"
}
```
becomes

```ruby
"2016-04-18"
```


## Dataset data structures

### available
Date made available. If year is present, month and day will have data or an empty string.

```ruby
{
  "year"=>"2016",
  "month"=>"2",
  "day"=>"4"
}
```

### file
An array of files.

```ruby
[
  {
    "name"=>"foo.csv",
    "mime"=>"application/octet-stream",
    "size"=>"1616665158",
    "url"=>"http://example.com/ws/rest/files/12345678/foo.csv",
    "title"=>"foo.csv",
    "license"=>{
      "name"=>"CC BY-NC",
      "url"=>"http://creativecommons.org/licenses/by-nc/4.0/"
    }
  },
]
```

### person
Contains an array of internal persons and an array of external persons.

```ruby
{
  "internal"=>[
    {
      "name"=>{
        "first"=>"Stan",
        "last"=>"Laurel"
       },
       "role"=>"Creator",
       "uuid"=>"xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
    },
  ],
  "external"=>[
  ]
}
```

### publication
An array of related publications.

```ruby
[
  {
    "type"=>"Journal article",
    "title"=>"An interesting title",
    "uuid"=>"xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
  },
]
```

### temporal
Date range. If year is present, month and day will have data or an empty string.

```ruby
{
  "start"=>{
    "year"=>"2005",
    "month"=>"5",
    "day"=>"10"
  },
  "end"=>{
    "year"=>"2011",
    "month"=>"9",
    "day"=>"18"
  }
}
```