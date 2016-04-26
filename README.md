# Pur&#233;e

A Ruby client for the Pure Research Information System API.

## API coverage
- Version: 5.5.1.
- Resources: Dataset.

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

# Create connection
p = Puree::Dataset.new endpoint, username, password

# Get metadata using ID
p.get id: '12345678'

# Get metadata using UUID
p.get uuid: 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'

# Filter metadata into simple data structures
p.titles
p.descriptions
p.keywords
p.people
p.temporal
p.geographical
p.files
p.publications
p.available
p.access
p.doi

# Combine metadata into one simple data structure
p.all

# Access HTTParty functionality
p.response # HTTParty object
p.response.body # XML
p.response.code
p.response.message
p.response.headers # hash
```