# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

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

