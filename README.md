# Soccer Master

CLI tool to calculate soccer leagues results based on files.


## How to install it


First make sure you have ruby installed (any version equal or to above 2.3.x should work just fine). If you don't have ruby depending on your OS you can get it through [rvm](https://rvm.io/), [rbenv](https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-ubuntu-18-04-es), or [any other](https://www.ruby-lang.org/es/documentation/installation/) method that you can find on their site.

You will also need to have [Bundler](https://bundler.io/) installed to handle the dependencies chances are that if you have ruby you also have bundler already installed you can double check this with

```bash

bundler --version

```

if you have it already installed you should see something like `Bundler version x.x.x`. If not just run `gem install bundler` and wait.


Same deal with [Rake](https://github.com/ruby/rake) you should already have it but if needed it can be installed with `gem install rake`. To confirm if you have it or not you can run `rake --version`


With that out of the way you can clone this repository:

```bash
git clone https://github.com/lucas-aragno/soccer-master
```

then `cd` into the directory (`cd soccer-master`) and install the dependencies (at the  moment we only have `minitest` for testing).


```
rake install
```

this should bundle and package the gem.


Once that's done you should be able to type

```
soccer_master /path/to/your/file
```

to use the tool from any location on your computer.




## How it works


The basic usage of the tool is calling the `soccer_master` cli command from your console and providing a the address of the file you want to process.


Files should look like this

```
San Jose Earthquakes 3, Santa Cruz Slugs 3
Capitola Seahorses 1, Aptos FC 0
Felton Lumberjacks 2, Monterey United 0
Felton Lumberjacks 1, Aptos FC 2
Santa Cruz Slugs 0, Capitola Seahorses 0
Monterey United 4, San Jose Earthquakes 2
Santa Cruz Slugs 2, Aptos FC 3
San Jose Earthquakes 1, Felton Lumberjacks 4
Monterey United 1, Capitola Seahorses 0
Aptos FC 2, Monterey United 0
Capitola Seahorses 5, San Jose Earthquakes 5
Santa Cruz Slugs 1, Felton Lumberjacks 1
```

In which you have a match: <team1> <score team 1>, <team2> <score team2> on each line without any spaces. If the file does not have the right format you will get an error.


Now let's say you have a file called `scores.txt` on your desktop with the previous content you can go where that file is and run `soccer_master scores.txt`

You should see an output like this one on your console:

```
Matchday 1
Capitola Seahorses, 3 pts
Felton Lumberjacks, 3 pts
San Jose Earthquakes, 1 pt

Matchday 2
Capitola Seahorses, 4 pts
Aptos FC, 3 pts
Felton Lumberjacks, 3 pts

Matchday 3
Aptos FC, 6 pts
Felton Lumberjacks, 6 pts
Monterey United, 6 pts

Matchday 4
Aptos FC, 9 pts
Felton Lumberjacks, 7 pts
Monterey United, 6 pts
```


## Running the tests


If you installed minitest with the previous steps you should be able to run 

```
rake test
```

And get the test running, if they all pass the output would look like this:

```
# Running:                                                                                                                                                                                                                                                              ....................                                                                                                                                                                                                                                                    Finished in 0.006427s, 3111.8718 runs/s, 6379.3372 assertions/s. 
```




## Code structure


This CLI is structured using a similar approach to traiblazer architecture in which we have "concepts" folders, in this case match, match_day, and team_score, and within those folders we have operations which are objects that model a top-level function regarding those concepts the idea behind them is to hold business specific rules within each object regardin 1 specific operation and hide it from the caller (being a controller or a function on another module) with this in mind an operation will just know how to do 1 thing or how to compose another set of operations to do one thing.

Within the concepts also live things like models modeling the entity, constants and exceptions if needed.