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
# #<struct Puree::Model::Dataset uuid="b050f4b5-e272-4914-8cac-3bdc1e673c58",
# created="2015-06-04T16:11:34.713+01:00", modified="2015-07-06T09:59:36
# .430+01:00", locale="en-GB", access="Embargoed",
# associated=[{"type"=>"Journal article", "title"=>"The unprecedented scale of
# the West African Ebola virus disease outbreak is due to environmental and
# sociological factors, not special attributes of the currently circulating
# strain of the virus", "uuid"=>"3fce9568-e94a-4a36-9b0a-bbd125c508eb"},
# {"type"=>"Journal article", "title"=>"The 2014 Ebola virus disease outbreak
# in West Africa", "uuid"=>"eda7f48f-d99a-402e-a103-4784550abac8"}],
# available={"year"=>"2015", "month"=>"6", "day"=>"4"}, description="Data used
# for analysis of selection and evolutionary rate in Zaire Ebolavirus variant
# Makona", doi="http://dx.doi.org/10.17635/lancaster/researchdata/6",
# file=[{"name"=>"Ebola_data_Jun15.zip", "mime"=>"multipart/x-zip",
# "size"=>"4102063", "url"=>"https://pure.lancs.ac
# .uk/ws/files/84179228/Ebola_data_Jun15.zip", "title"=>"Ebola_data_Jun15",
# "license"=>{"name"=>"CC BY", "url"=>"http://creativecommons.org/licenses/by/4
# .0/"}}], keyword=["Ebolavirus", "evolution", "phylogenetics", "virulence",
# "Filoviridae", "positive selection"], link=[],
# organisation=[{"uuid"=>"d181185b-39bb-4538-ace0-4c0c4a399898",
# "name"=>"Biomedical and Life Sciences", "type"=>"Department"}],
# owner={"uuid"=>"d181185b-39bb-4538-ace0-4c0c4a399898", "name"=>"Biomedical
# and Life Sciences", "type"=>"Department"},
# person={"internal"=>[{"name"=>{"first"=>"Derek", "last"=>"Gatherer"},
# "role"=>"Creator", "uuid"=>"0e65614d-0ed3-4b81-b4a1-22da4b301022"}],
# "external"=>[{"name"=>{"first"=>"David", "last"=>"Robertson"},
# "role"=>"Contributor", "uuid"=>"f940152b-41e9-40e7-9906-2a82a1a2c9ca"},
# {"name"=>{"first"=>"Simon", "last"=>"Lovell"}, "role"=>"Contributor",
# "uuid"=>"1b7c0d88-cd7b-44b3-ad44-46bd8cda6811"}, {"name"=>{"first"=>"Miles",
# "last"=>"Carroll"}, "role"=>"Distributor",
# "uuid"=>"870de2dd-8898-4c6f-abcc-1287dc38b4e6"}, {"name"=>{"first"=>"David",
# "last"=>"Matthews"}, "role"=>"Data Collector",
# "uuid"=>"5730535a-f29f-42c1-be72-3efae43802d7"}], "other"=>[]},
# production={"start"=>{"year"=>"2015", "month"=>"6", "day"=>"4"},
# "end"=>{"year"=>"2015", "month"=>"6", "day"=>"4"}}, project=[],
# publication=[{"type"=>"Journal article", "title"=>"The unprecedented scale
# of the West African Ebola virus disease outbreak is due to environmental and
# sociological factors, not special attributes of the currently circulating
# strain of the virus", "uuid"=>"3fce9568-e94a-4a36-9b0a-bbd125c508eb"},
# {"type"=>"Journal article", "title"=>"The 2014 Ebola virus disease outbreak
# in West Africa", "uuid"=>"eda7f48f-d99a-402e-a103-4784550abac8"}],
# publisher="Lancaster University", spatial=["Guinea, Sierra Leone, Liberia"],
# spatial_point={}, temporal={"start"=>{"year"=>"2013", "month"=>"12",
# "day"=>"1"}, "end"=>{"year"=>"2015", "month"=>"6", "day"=>"4"}},
# title="Ebolavirus evolution 2013-2015">
```

### Collection of resources
Fetch a bunch.

```ruby
extractor = Puree::Extractor::Collection.new url: ENV['PURE_URL'],
                                             resource: :dataset
collection = extractor.find limit: 50
```


## Documentation
[API in YARD](http://www.rubydoc.info/gems/puree)

[Detailed usage in GitBook](https://aalbinclark.gitbooks.io/puree)