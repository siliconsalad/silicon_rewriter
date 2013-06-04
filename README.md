# SiliconRewriter

An URL rewriter based on a simple hash

## Installation

Add this line to your application's Gemfile:

    gem 'silicon_rewriter'

And then execute:

    $ bundle

## Usage

Then you have to add this line:
```ruby
Rails.application.config.middleware.insert_before 'ActionDispatch::Static', 'SiliconRewriter::Rewriter', my_hash
```

The `my_hash` structure should look like:

```yml
silicon_rewriter:
  rules:
    -
      host: 'localhost'
      from: '/robots.txt'
      to:   '/robots.fr.txt'
    -
      host: 'localhost'
      from: '/404.txt'
      to:   '/404.fr.txt'
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
