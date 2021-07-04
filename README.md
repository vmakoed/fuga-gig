# Fuga::Gig

A command line tool using the public Github API to download and save avatar
images from repository owners matching the provided search criteria.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fuga-gig'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install fuga-gig

## Usage

Downloading images:

```bash
bin/gig topic:ruby topic:rails
```

Viewing images:
```bash
ls topic:ruby-topic:rails/
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/vmakoed/fuga-gig.

## TODO

- [ ] Core
  - [ ] Github API client
  - [ ] API results parser
  - [ ] File downloader
  - [ ] CLI
- [ ] Edge cases
  - [ ] Rate limit
  - [ ] Error handling (connection errors)
  - [ ] Pagination handling
  - [ ] Download once (skip downloading same image)
- [ ] Performance
  - [ ] Avoid reading whole file into memory
- [ ] Nice to have
   - [ ] Progress bar
