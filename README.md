# My Dev Ecosystem

[![Maintainability](https://api.codeclimate.com/v1/badges/b66e6104c5b6ee8bdf48/maintainability)](https://codeclimate.com/github/k-rudy/dev-ecosystem/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/b66e6104c5b6ee8bdf48/test_coverage)](https://codeclimate.com/github/k-rudy/dev-ecosystem/test_coverage)

A set of useful tools to automate a bunch of my routine jobs. Built on Hanami(http://hanamirb.org/guides/) framework 🌸

## Setup

How to run tests:

```
% bundle exec rake
```

How to run the development console:

```
% bundle exec hanami console
```

How to run the development server:

```
% bundle exec hanami server
```

How to prepare (create and migrate) DB for `development` and `test` environments:

```
% bundle exec hanami db prepare

% HANAMI_ENV=test bundle exec hanami db prepare
```
