[![Build Status](https://travis-ci.org/GravityLabs/netscaler.svg?branch=master)](https://travis-ci.org/GravityLabs/netscaler)

# Netscaler Gem

A gem that uses the Netscaler [Nitro API][1] to access configs and stats.  This has been tested only on Netscaler 9.3.  Hoping to have Netscaler 10.0 support added in the near future.

[1]: http://support.citrix.com/proddocs/topic/netscaler-main-api-10-map/ns-nitro-wrapper-con.html        "Nitro API"


# THIS IS PRE-ALPHA!!!

It is currently *Pre-Alpha* hence the 0-dot version and is susceptible to methods, classes and modules being renamed, added or deleted.  I will try my best to back support as much as I can but will provide release notes of changes.  Would love to get community support, I have access to a Netscaler and will add this to the spec as well down the road.

## How it works
### Connecting to a Netscaler
All params are hash keys.  So to create a new connection to a netscaler:
```ruby
conn = Netscaler::Connection :hostname => 'netscaler01', :username => 'foo', :password => 'bar'
```

If you want to disable ssl verification provide the optional param :verify_ssl => false
```ruby
conn = Netscaler::Connection :hostname => 'netscaler01', :username => 'foo', :password => 'bar', :verify_ssl => false
```

### Disabling and Enabling a Service
We try to keep the classes and methods match the command groups that are in the netscaler cli.  So if you are familiar with this then it should be pretty easy to guess what the methods will look like.  Such as:

disable service service01
```ruby
conn.service.disable(:name => 'service01')
```

enable service service01
```ruby
conn.service.enable(:name => 'service01')
```


## TODO

* Classes and methods for Rewrite policies and actions
* Classes and methods for Responder policies and actions
* Classes and methods for Content Switching policies
* Add new definitions for deleting netscaler object entities
* Add stats
* Add support for Nitro 10.0, 10.1

## Contributing to Netscaler Gem

When writing a new class or method we want to try to follow the same names as the command(s) that is in the NSCLI.  For instance:

NSCLI
```bash
add server <name> (<IPAddress> | (<domain>)
```
RUBY
```ruby
conn.server.add :name => 'foo', :domain => '1.1.1.1'
```

Here is another example, adding an lb vserver.  We created a sub class of Lb called Netscaler::Lb::Vserver.  So it would look something like:

NSCLI
```bash
add lb vserver vip1 HTTP 1.1.1.1 80
```

RUBY
```ruby
conn.lb.vserver.add :name => 'vip1', :serviceType => HTTP, :ipv46 => '1.1.1.1', :port => '80'
```

Otherwise if there are features that are missing or bugs in the code that need fixing, pull requests are welcome.  I am mostly using this for disabling and enabling services but new features are welcome so long as they follow this convention to keep consistency.
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2014 Gravity.com, Inc. See LICENSE.txt for
further details.

