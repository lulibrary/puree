# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## Unreleased
- Metadata: activity?, clipping?, externalPerson?

## 1.3.0 - 2017-04-03
### Added
- Publication type - JournalArticle, Paper, ConferencePaper.

## 1.2.0 - 2017-03-31
### Added
- Publication - language, owner, translated_title, translated_subtitle.
- Publication types - Doctoral Thesis and Master's Thesis.

### Changed
- Publication - common attributes established. doi, event, pages become mixins
for publication types.

## 1.1.0 - 2017-03-24
### Added
- Publication - keywords, publisher.

## 1.0.0 - 2017-03-15
### Added
- Dataset - legal conditions.
- Collection - random resource.

### Changed
- Simplified authentication.
- Hash data structures converted to model classes.
- All dates in Time format.

### Removed
- Global configuration.

### Fixed
- Event - end date extraction.

## 0.20.0 - 2017-02-03
### Added
- Dataset - spatial_point.
- Resource subclasses - locale.

### Fixed
- Collection - array of instances.

## 0.19.2 - 2017-01-27
### Fixed
- Dataset - production, temporal extraction.

## 0.19.1 - 2016-11-30
### Fixed
- Dataset, Publication - person role extraction.

## 0.19.0 - 2016-09-21
### Added
- Journal - issn, publisher.
- Publisher - name.

### Changed
- Collection - simpler api for count of records available.

## 0.18.0 - 2016-09-20
### Added
- Collection - count of records available.

## 0.17.1 - 2016-09-08
### Fixed
- Dataset - available extraction.

## 0.17.0 - 2016-09-02
### Added
- Resource subclasses - uuid, created, modified as methods.
- Resource subclasses - set content from XML string.

### Fixed
- Organisation - organisation extraction.

## 0.16.1 - 2016-08-30
### Fixed
- Dataset, Project, Publication - person uuid returns text rather than a Nokogiri object.

## 0.16.0 - 2016-08-19
### Added
- Collection - instance parameter.

### Changed
- Parameter endpoint renamed to base_url.
- Dataset (geographical renamed to spatial).
- Metadata methods return pre-extracted data.

## 0.15.0 - 2016-06-22
### Added
- Person (email).
- Server metadata (version).
- Download statistics.
- Collection - metadata fetch.
- Collection - returns uuids or metadata, depending upon parameter.
- Project metadata (acronym, description, owner, status, temporal, title, type, url).
- Collection and resource types - optional basic authentication.
- Replaced request library.
- Publication - category, event, organisation, page, person, status, type.
- Project - organisation, person.
- Dataset - organisation, person.
- Server and download - optional basic authentication.


### Changed
- Dataset - organisation becomes owner.
- Global configuration namespace simplified.
- Person (affiliation - uuid added to name in a hash).
- Collection - parameter renamed to resource, in keeping with class structure.
- Resource types return metadata rather than HTTP response object.

## 0.14.0 - 2016-06-10
### Added
- Dataset (organisation).
- Organisation (parent).
- Credentials set globally.
- Global credentials override in ctor of resource.
- Find as alias for get.

### Removed
- Credentials passed with get.

## 0.13.0 - 2016-05-20
### Added
- Collection server-side search by date range (created, modified) and paging.

## 0.12.0 - 2016-05-20
### Added
- Resource (created, modified, uuid).

## 0.11.0 - 2016-05-19
### Added
- Event metadata (city, country, date, description, location, title, type).
- Organisation metadata (address, email, phone, type, url).

### Changed
- Dataset metadata (return string not array for description, title).
- Publication metadata (return string not array for description, subtitle, title).

## 0.10.0 - 2016-05-17
### Added
- Dataset metadata (associated, link, project, production as range, person for those without uuid, publication for all research outputs, publisher).

### Fixed
- Dataset metadata (description splitting, geographical stripping).

## 0.9.0 - 2016-05-16
### Added
- Dataset metadata (production).
- Organisation metadata (name).
- Person metadata (image, keyword, name).

## 0.8.0 - 2016-05-11
### Added
- Publication metadata (description, doi, file, subtitle, title).

## 0.7.0 - 2016-05-10
### Added
- Person metadata (affiliation, orcid).
- Nokogiri.

## 0.6.0 - 2016-05-06
### Added
- API map factored out of Resource.
- Collections (journal, organisation, person, project, publication, publisher).
- Resource classes with HTTParty metadata (journal, organisation, person, project, publication, publisher).

## 0.5.0 - 2016-04-29
### Added
- Refactoring ctor.
- Populate resource metadata from get and assignment.
- Dataset collection.
- RSpec tests for dataset collection.

## 0.4.0 - 2016-04-27
### Added
- Date normalisation and conversion to ISO8601.

## 0.3.0 - 2016-04-26
### Added
- Yard documentation.
- Simplification of public interface method names.

## 0.2.0 - 2016-04-25
### Added
- RSpec tests for datasets.

## 0.1.0 - 2016-04-21
### Added
- Working product supports datasets.

