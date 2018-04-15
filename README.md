# Survey Tool Front End Developer Coding Test

An [Elm][] application that retrieves survey result information from a [JSON][]
[API][], and displays the results.

## Setup

    git clone https://github.com/paulfioravanti/survey_tool_elm.git
    cd survey_tool_elm

## Back end

The back end is an [Elixir][] app that uses [Plug][]'s [Cowboy2 adapter][] to
serve the JSON files expected by the front end.

### Dependencies

- [Elixir][] 1.6.4
- [Erlang][] 20.3.2

I personally recommend [asdf][] to install the languages and their dependencies.

### Setup

    cd back_end
    mix deps.get

### Run Server

    iex -S mix

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

    mix test

[`mix test.watch`][] was used during development, so that can also be used here
to continuously run tests on file changes.

## Front end

The front end is an [Elm][] application that displays the survey result data.
It uses [Tachyons][] for functional CSS styling, making this front/back end
combo one "P" short of the [PETE stack][] (I figured making the back end a
[Phoenix][] application would have been overkill).

### Dependencies

- [Elm][] 0.18.0
- [NodeJS][] 9.9.0

I personally recommend [asdf][] to install the languages and their dependencies.

### Setup

#### Global Setup

I used the following global npm packages during development, so I recommend
installing them to be able to run all application and testing commands:

- [elm-test][]
- [Create Elm App][]
- [elm-verify-examples][]
- [Elm Coverage][]

Install:

    npm install -g elm-test create-elm-app elm-verify-examples elm-coverage

In order to get `mix test.watch`-like functionality with Elm, I used:

- [`just`][]
- [watchexec][]

They can both be installed with [Homebrew][]:

    brew install just watchexec

#### Application Setup

    cd front_end
    npm install
    elm-package install
    cp .env.example .env

### Run Server

    elm-app start

Now, you should be able to use the app at the following address:

- <http://localhost:3000>

(Make sure you also have the back end server running to actually see the
survey results).

### Run Tests

Straight tests:

    elm-test

Verified examples (doctests):

    elm-verified-examples

Run tests and generate code coverage report:

    elm-coverage
    open .coverage/coverage.html

#### Development Mode (optional)

If you're using this app in development, you could do the following:

Use `just` and `watchexec` to run both `elm-verify-examples` and `elm-test`
when any `src` code is modified:

    watchexec --watch src --clear just test

Use `just` and `watchexec` to run both `elm-verify-examples` and `elm-coverage`
(which runs `elm-test`) when any tests are modified. The `src` directory is not
included here because `elm-coverage` ends up touching every `src` file during
its instrumentation phase, leading to infinite loops:

    watchexec --watch tests --ignore tests/elm-package.json --clear just coverage

## Other

I also wrote implementations of the companion back-end developer test to this
front-end test in [Elixir][] and [Ruby][], which can be found at the following:

- <https://github.com/paulfioravanti/survey_tool_elixir>
- <https://github.com/paulfioravanti/survey_tool_ruby>

## Social

[![Contact][twitter-badge]][twitter-url]<br />
[![Stack Overflow][stackoverflow-badge]][stackoverflow-url]

[API]: https://en.wikipedia.org/wiki/Application_programming_interface
[asdf]: https://github.com/asdf-vm/asdf
[Cowboy2 adapter]: https://github.com/elixir-plug/plug/blob/master/lib/plug/adapters/cowboy2.ex
[Create Elm App]: https://github.com/halfzebra/create-elm-app
[Elixir]: https://github.com/elixir-lang/elixir
[Elm]: http://elm-lang.org/
[Elm Coverage]: https://github.com/zwilias/elm-coverage
[elm-test]: https://github.com/elm-community/elm-test
[elm-verify-examples]: https://github.com/stoeffel/elm-verify-examples
[Erlang]: https://www.erlang.org/
[ExUnit]: https://hexdocs.pm/ex_unit/ExUnit.html
[Homebrew]: https://brew.sh/
[JSON]: https://www.json.org/
[JSON Formatter]: https://chrome.google.com/webstore/detail/json-formatter/bcjindcccaagfpapjjmafapmmgkkhgoa
[`just`]: https://github.com/casey/just
[`mix test.watch`]: https://github.com/lpil/mix-test.watch
[NodeJS]: https://nodejs.org/en/
[PETE stack]: https://github.com/dwyl/technology-stack#the-pete-stack
[Phoenix]: http://phoenixframework.org/
[Plug]: https://github.com/elixir-plug/plug
[Ruby]: https://github.com/ruby/ruby
[stackoverflow-badge]: http://stackoverflow.com/users/flair/567863.png
[stackoverflow-url]: http://stackoverflow.com/users/567863/paul-fioravanti
[survey-tool-ruby]: https://github.com/paulfioravanti/survey_tool_ruby
[Tachyons]: http://tachyons.io/
[twitter-badge]: https://img.shields.io/badge/contact-%40paulfioravanti-blue.svg
[twitter-url]: https://twitter.com/paulfioravanti
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

We’re looking forward to your innovative solutions!
