# Pur&#233;e

A client for the Pure Research Information System API.

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

# Preferably use environment variables
p = Puree::API.new(endpoint, username, password)

# Get data from endpoint for a resource type (symbol) using Pure ID
# Returns HTTParty object
p.get(resource_type: :dataset, id: '12345678')

# Get data from endpoint for a resource type (string) using Pure UUID
# Returns HTTParty object
p.get(resource_type: 'dataset', uuid: 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx')

# Optional parameters for puree.get
latest_api: false
rendering: <:xml_short|:xml_compact>

# Access HTTParty functionality
p.response # HTTParty object
p.response.body # XML
p.response.code
p.response.message
p.response.headers # hash

# All Pure content from HTTParty object (hash)
p.content

# Specific Pure content from HTTParty object (hash) using a method or simply via hash
p.node '<node>'
p.content['<node>']

# Resource types supported
dataset
publication

# Nodes available (dataset, xml_long)
documents
persons
relatedPublications
dateMadeAvailable
temporalCoverageStartDate
temporalCoverageEndDate
geographicalCoverage
openAccessPermission

# Nodes available (dataset, xml_short)
persons
dateMadeAvailable
openAccessPermission

# Nodes available (dataset, xml_compact)
persons
dateMadeAvailable
openAccessPermission
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/puree/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
