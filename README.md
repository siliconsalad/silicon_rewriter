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
2. Create your feature/bug branch from `develop` (`git checkout -b feature/my_new_feature` or `git checkout -b bug/my_bug_fix`)
3. Commit your changes (`git commit -am 'Add some feature'` or `git commit -am 'Fix some bug'`)
4. Push to the branch (`git push origin feature/my_new_feature` or `git push origin bug/my_bug_fix`)
5. Create new Pull Request

### Advices

We'll have a look to your code only if tests pass.

Follow the conventions you see used in the source already.
  * The [Gitflow workflow](http://nvie.com/posts/a-successful-git-branching-model/)
  * The [Ruby style guide](https://github.com/bbatsov/ruby-style-guide)
