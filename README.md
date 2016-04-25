# Pur&#233;e

A Ruby client for the Pure Research Information System API.

## Supported Pure version
5.5.1

## Supported resource types
dataset

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

# Prepare to get metadata
p = Puree::Dataset.new(endpoint, username, password)

# Get metadata using ID
p.get id: '12345678'

# Get metadata using UUID
p.get uuid: 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'

# Filter metadata into simple data structures
p.title
p.description
p.keywords
p.persons
p.temporalCoverageStartDate
p.temporalCoverageEndDate
p.geographicalCoverage
p.documents
p.relatedPublications
p.dateMadeAvailable
p.openAccessPermission
p.doi

# Combine metadata into one simple data structure
p.all

# Raw Pure content (hash) from HTTParty object
p.content

# Access HTTParty functionality
p.response # HTTParty object
p.response.body # XML
p.response.code
p.response.message
p.response.headers # hash
```