# Pur&#233;e

A Ruby client for the Pure Research Information System API.


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
d.access
d.associated
d.available
d.created
d.description
d.doi
d.file
d.geographical
d.keyword
d.link
d.modified
d.person
d.production
d.project
d.publication
d.publisher
d.temporal
d.title

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
c = Puree::Collection.new(resource_type: :dataset)

# Get three minimal datasets, starting at record ten, created and modified in January 2016.
c.get endpoint:       endpoint,
      username:       username,
      password:       password,
      limit:          3,  # optional, default 20
      offset:         10, # optional, default 0
      created_start:  '2016-01-01', # optional
      created_end:    '2016-01-31', # optional
      modified_start: '2016-01-01', # optional
      modified_end:   '2016-01-31'  # optional

# Get UUIDs for datasets
uuids = c.uuid

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

## Data structures

### Dataset

#### available
Date made available. If year is present, month and day will have data or an empty string.

```ruby
{
  "year"=>"2016",
  "month"=>"2",
  "day"=>"4"
}
```

#### file
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

#### link
An array of links.

```ruby
[
  {
    "url": "http://www.example.com/~abc1234/xyz/",
    "description": "An interesting description"
  },
]
```

#### person
Contains an array of internal persons, an array of external persons and an array of other persons.

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
  ],
  "other"=>[
    {
      "name"=>{
        "first"=>"Hal",
        "last"=>"Roach"
      },
      "role"=>"Contributor",
      "uuid"=>""
    },
  ]
}
```

#### project
An array of projects associated with the dataset.

```ruby
[
  {
    "title": "An interesting project title",
    "uuid": "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
  },
]
```

#### publication
An array of research outputs associated with the dataset.

```ruby
[
  {
    "type": "Journal article",
    "title": "An interesting journal article title",
    "uuid": "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
  },
  {
    "type": "Conference paper",
    "title": "An interesting conference paper title",
    "uuid": "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
  },
  {
    "type": "Working paper",
    "title": "An interesting working paper title",
    "uuid": "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
  },
  {
    "type": "Paper",
    "title": "An interesting paper title",
    "uuid": "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
  },
  {
    "type": "Dataset",
    "title": "An interesting dataset title",
    "uuid": "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
  },
  {
    "type": "Chapter",
    "title": "An interesting chapter title",
    "uuid": "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
  },
]
```

#### production, temporal
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

### Organisation

#### address
An array of addresses.

```ruby
[
  {
    "street"=>"Lancaster University",
    "building"=>"Bowland North",
    "postcode"=>"LA1 4YN",
    "city"=>"Lancaster",
    "country"=>"United Kingdom"
  },
]
```

### Publication

#### file
An array of files.

```ruby
[
  {
    "name"=>"foo.csv",
    "mime"=>"application/octet-stream",
    "size"=>"1616665158",
    "url"=>"http://example.com/ws/rest/files/12345678/foo.csv",
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
  "year"=>"2016",
  "month"=>"4",
  "day"=>"18"
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

Resource metadata (system data and single hash only)

```ruby
:journal
:project
:publisher
```

Collections (for obtaining identifiers)

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