[![Build Status][travis-badge]][travis-url]

# Survey Tool Front End Developer Coding Test

An [Elm][] application that retrieves survey result information from a [JSON][]
[API][], and displays the results.

### Demo

- [Front end application][]
- [Back end JSON API][]

## Setup

```console
git clone https://github.com/paulfioravanti/survey_tool_elm.git
cd survey_tool_elm
```

## Back end

The back end is an [Elixir][] app that uses [PlugCowboy][] to serve the JSON
files expected by the front end.

### Dependencies

- [Elixir][] 1.15.7 ([asdf-elixir pre-compiled version][]: 1.15.7-otp-26)
- [Erlang][] 26.1.2

### Setup

```console
cd back_end
mix deps.get
```

### Run Server

```console
mix run --no-halt
```

Now, you should be able to open the following links and get the appropriate
JSON response:

- <http://localhost:4000/survey_results>
- <http://localhost:4000/survey_results/1>
- <http://localhost:4000/survey_results/2>

Other addresses should return an error JSON object.

For easy reading of JSON objects in a browser, I recommend the
[JSON Formatter][] extension for Google Chrome.

### Run Tests

The back end server has a small suite of tests, written with [ExUnit][], that
can be run with:

```console
mix test
```

[`mix test.watch`][] was used during development, so that can also be used here
to continuously run tests on file changes.

## Front end

The front end is an [Elm][] application that displays the survey result data.
It uses [Tachyons][] for functional CSS styling and responsive layouts for
mobile and desktop screens, making this front/back end combo one "P" short of
the [PETE stack][] (I figured making the back end a [Phoenix][] application
would have been overkill).

### Dependencies

- [Elm][] 0.19.1
- [NodeJS][] 21.2.0

### Setup

#### Global Setup

I used the following global npm packages during development, so I recommend
installing them to be able to run all application and testing commands:

- [Create Elm App][]
- [elm-test][]
- [elm-verify-examples][]
- [Elm Coverage][]
- [Elm Analyse][]

Install:

```console
npm install -g elm-test create-elm-app elm-verify-examples elm-coverage elm-analyse
```

In order to get `mix test.watch`-like functionality with Elm, I used:

- [`just`][]
- [watchexec][]

They can both be installed with [Homebrew][]:

```console
brew install just watchexec
```

#### Application Setup

```console
cd front_end
npm install
elm-package install
cp .env.example .env
```

In development, if you want to serve up the back end JSON application from a
location other than <http://localhost:4000>, then you can
configure that in the `.env` file.

### Run Server

```console
NODE_OPTIONS=--openssl-legacy-provider elm-app start
```

> The `--openssl-legacy-provider` option is needed until
> [this issue][create-elm-app#604] gets addressed.

Now, you should be able to use the app at the following address:

- <http://localhost:3000>

(Make sure you also have the back end server running to actually see the
survey results).

### Run Tests

Install the elm packages in the `tests` directory first:

```console
cd tests
elm-package install
```

Straight tests:

```console
elm-test
```

Verified examples (doctests):

```console
elm-verify-examples
```

Run tests and generate code coverage report.  

> Coverage is currently stuck at 99% because there is no way to
generate a `Navigation.Key` for `Browser.application` apps in a test
environment. Hopefully, that will be fixed one day, but the issue to follow is
[here](https://github.com/elm-explorations/test/issues/24).

```console
elm-coverage
open .coverage/coverage.html
```

Run Elm Analyse confirm best practices are being adhered to:

```console
elm-analyse
```

Note: it may take a while for the `elm-css` library to be loaded the first
time this is run, so give it potentially about 10 minutes.

#### Development Mode (optional)

If you're using this app in development, you could do the following:

Use `just` and `watchexec` to run both `elm-verify-examples` and `elm-test`
when any `src` code is modified:

```console
watchexec --watch src --clear just test
```

Use `just` and `watchexec` to run both `elm-verify-examples` and `elm-coverage`
(which runs `elm-test`) when any tests are modified. The `src` directory is not
included here because `elm-coverage` ends up touching every `src` file during
its instrumentation phase, leading to infinite loops:

```console
watchexec --watch tests --ignore tests/elm-package.json --clear just coverage
```

## Deployment

Both the front end and back end applications have been deployed to [Heroku][],
and can be found at the following links:

- Front end: <https://survey-tool-front-end.herokuapp.com/survey_results>
- Back end: <https://survey-tool-back-end.herokuapp.com/survey_results>

### Deployment Notes

The git remotes for the application look like the following:

```sh
➜ [survey_tool_elm (master)]$ git remote -v
heroku-survey-tool-back-end  https://git.heroku.com/survey-tool-back-end.git (fetch)
heroku-survey-tool-back-end  https://git.heroku.com/survey-tool-back-end.git (push)
heroku-survey-tool-front-end https://git.heroku.com/survey-tool-front-end.git (fetch)
heroku-survey-tool-front-end https://git.heroku.com/survey-tool-front-end.git (push)
origin  git@github.com:paulfioravanti/survey_tool_elm.git (fetch)
origin  git@github.com:paulfioravanti/survey_tool_elm.git (push)
```

Both applications share the same Github repository, but are deployed to separate
Heroku instance using `git subtree`:

```sh
git subtree push --prefix back_end heroku-survey-tool-back-end master
git subtree push --prefix front_end heroku-survey-tool-front-end master
```

The back end application uses the [Heroku Buildpack for Elixir][], and when it
gets deployed, the `mix run --no-halt` command in the `Procfile` gets run to
start the Cowboy server to serve up the JSON.

The front end application uses [heroku-buildpack-static][] for deployment, with
a `static.json` file that points the `root` folder of the application at
the `build` directory.

There is a [Heroku buildpack for Elm apps][], but since the application was
created with [Create Elm App][], the command to generate a production app is
[`elm-app build`][] (and not `elm make` as the buildpack expects), which, along
with other Create Elm App commands, are not available during the deployment
process.

Therefore, a new build of this application must be manually generated locally
before every Heroku deployment. Hence, the `build` directory has been
put under version control (by default it is `.gitignore`d). 

The push/deployment process is mostly automated via the `push` script in the
root directory. The way to use it is:

- `./push back`: push repo contents to Github and deploy the back end app to
  Heroku
- `./push front`: generate a build, push repo contents to Github, then deploy
  the front end app to Heroku
- `./push both`: generate a build, push repo contents to Github, then push the
  back and front end apps to Heroku

## Other

I also wrote implementations of the companion back-end developer test to this
front-end test in [Elixir][] and [Ruby][], which can be found at the following:

- <https://github.com/paulfioravanti/survey_tool_elixir>
- <https://github.com/paulfioravanti/survey_tool_ruby>

[asdf-elixir pre-compiled version]: https://github.com/asdf-vm/asdf-elixir#elixir-precompiled-versions
[API]: https://en.wikipedia.org/wiki/Application_programming_interface
[Back end JSON API]: https://survey-tool-back-end.herokuapp.com/survey_results
[Create Elm App]: https://github.com/halfzebra/create-elm-app
[create-elm-app#604]: https://github.com/halfzebra/create-elm-app/issues/604
[Elixir]: https://github.com/elixir-lang/elixir
[Elm]: http://elm-lang.org/
[Elm Analyse]: https://github.com/stil4m/elm-analyse
[Elm Coverage]: https://github.com/zwilias/elm-coverage
[`elm-app build`]: https://github.com/halfzebra/create-elm-app#elm-app-build
[elm-test]: https://github.com/elm-community/elm-test
[elm-verify-examples]: https://github.com/stoeffel/elm-verify-examples
[Erlang]: https://www.erlang.org/
[ExUnit]: https://hexdocs.pm/ex_unit/ExUnit.html
[Front end application]: https://survey-tool-front-end.herokuapp.com/survey_results
[Heroku]: https://www.heroku.com/
[Heroku buildpack for Elm apps]: https://github.com/srid/heroku-buildpack-elm
[heroku-buildpack-static]: https://github.com/heroku/heroku-buildpack-static
[Heroku Buildpack for Elixir]: https://github.com/HashNuke/heroku-buildpack-elixir
[Homebrew]: https://brew.sh/
[JSON]: https://www.json.org/
[JSON Formatter]: https://chrome.google.com/webstore/detail/json-formatter/bcjindcccaagfpapjjmafapmmgkkhgoa
[`just`]: https://github.com/casey/just
[`mix test.watch`]: https://github.com/lpil/mix-test.watch
[NodeJS]: https://nodejs.org/en/
[PETE stack]: https://github.com/dwyl/technology-stack#the-pete-stack
[Phoenix]: http://phoenixframework.org/
[PlugCowboy]: https://github.com/elixir-plug/plug_cowboy
[Ruby]: https://github.com/ruby/ruby
[survey-tool-ruby]: https://github.com/paulfioravanti/survey_tool_ruby
[Tachyons]: http://tachyons.io/
[travis-badge]: https://travis-ci.org/paulfioravanti/survey_tool_elm.svg?branch=master
[travis-url]: https://travis-ci.org/paulfioravanti/survey_tool_elm
[watchexec]: https://github.com/mattgreen/watchexec

---

# Requirements

# Culture Amp’s Front End Developer Coding Test

This repository contains a small number of static JSON files, which represent the responses from an HTTP API that offers access to a database of survey results.

Your task is to build a web front end that displays the data supplied by this API. You must process the survey data and display the results in a clear, usable interface.

## Getting Started

We suggest you start by setting up an HTTP server that will serve up these JSON files upon request. This may be the same server that serves your web application to consume the API, but make sure to design your application in such a way that you could easily point it to an arbitrary base URL for the API, somewhere else on the Internet.

One you’ve got the API available, use whatever client-side libraries or frameworks you like to build the application that consumes it.

(Tip: If your application will access the API directly from the browser, using the same server for both your application and the API it consumes will save you having to deal with cross-origin requests. Of course, if you enjoy that sort of thing, feel free to go for it!)

## The API

`index.json` is returned when you send a GET request for the root URL. It returns a list of the surveys that are stored in the database, and high-level statistics for each. For each survey, a URL is included that points to one of the other JSON files.

The remaining JSON files each provide full response data for one of these surveys. Each survey is broken into one or more themes, each theme contains one or more questions and each question contains a list of responses. A response represents an individual user (`"respondent_id"`) answering an individual question (`"question_id"`). The content of each response represents an agreement rating on a scale of `"1"` (strongly disagree) to `"5"` (strongly agree). If you wished, you could obtain all of the responses for a single user by consulting all of the responses with that user’s `"respondent_id"`.

## Requirements

Your application should include:

* a page that lists all of the surveys and allows the user to choose one to view its results;
* a page that displays an individual survey’s results, including:
    - participation rate as a percentage
    - the average rating (from 1 to 5) for each question

Responses with an empty rating should be considered non-responses (questions skipped by the survey respondent). These responses should be excluded when calculating the average.

You can deliver a set of static HTML pages that consume the API data with JavaScript, but keep in mind that we need to be able to read your code, so if you’re compiling your JavaScript in any way, please include your source code too. Alternatively, if you want to build an application that runs on its own web server, that’s okay too.

## Recommendations

* Be creative in considering the right way to display the results.
* Feel free to use frameworks and libraries, but keep in mind that we are looking for something that demonstrates that you can write good front-end code, not just wire up a framework.
* Static JSON files load pretty quickly, but not all web APIs are so performant. Consider how your application will behave if the API is slow.
* Include a README file with clear build instructions that we can follow.
* Include in your README any other details you would like to share, such as tradeoffs you chose to make, what areas of the problem you chose to focus on and the reasons for your design decisions.
* We like tests.

Beyond meeting the minimum requirements above, it’s up to you where you want to focus. We don’t expect a fully-finished, production-quality web application; rather, we’re happy for you to focus on whatever areas you feel best showcase your skills.

## Submitting your solution

Assuming you use Git to track changes to your code, when you’re ready to submit your solution, please use `git bundle` to package up a copy of your repository (with complete commit history) as a single file and send it to us as an email attachment. 

```
git bundle create front-end-coding-test.bundle master
```

We're looking forward to your innovative solutions!
