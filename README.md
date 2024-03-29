# Paday

> Read a percentage of a book each day

[![Ruby](https://github.com/dngst/paday/actions/workflows/ruby.yml/badge.svg)](https://github.com/dngst/paday/actions/workflows/ruby.yml)
[![Maintainability](https://api.codeclimate.com/v1/badges/c4d75ff6d0be55133bcc/maintainability)](https://codeclimate.com/github/dngst/paday/maintainability)

## Requirements

- Ruby
- Bundler

## Install

$ bundle

$ rackup

## Usage

Input:

1. Total no. of pages a book has.

2. Percentage of the book to read each day.

[localhost:9292/208/4](http://localhost:9292/208/4)

Output(Estimate):

1. No. of pages to read each day.

2. No. of days it will take to finish reading the book.

3. Projected finish date.

```
{"pages":8,"days":26,"date":"02.Jan.2022"}
```

## Tests

$ bundle exec rspec

## Maintainer

[@dngst](https://github.com/dngst)

## Contributing

PRs and issues accepted. See [CONTRIBUTING.md](./CONTRIBUTING.md)

## License

MIT
