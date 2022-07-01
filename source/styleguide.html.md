---
title: Styleguide
layout: general
---
## Media

### Images

A picture is worth a thousand words, display it with style using the snippet below.

<div class="media">
  <img src="http://placehold.it/550x250.png" alt="">
  <div class="media-caption">
    <small>Sample caption lorem ipsum dolor sit</small>
  </div>
</div>

~~~ html
<div class="media">
  <img src="http://placehold.it/550x250.png" alt="">
  <div class="media-caption">
    <small>Sample caption lorem ipsum dolor sit</small>
  </div>
</div>
~~~

### Video

Use the snippet below for embedded video with either `media-video-wide` or `media-video-slim` for 16:9 or 4:3 aspect ratios, respectively. (The caption is optional)

<div class="media media-video-wide">
  <iframe class="media-video-item" src="https://www.youtube.com/embed/AQ3qLfzg8-w"></iframe>
  <div class="media-caption">
    <small>Sample caption lorem ipsum dolor sit</small>
  </div>
</div>

~~~ html
<div class="media media-video-wide">
  <iframe class="media-video-item" src="..."></iframe>
  <div class="media-caption">
    <small>Sample caption lorem ipsum dolor sit</small>
  </div>
</div>
~~~

## Content Card

A basic example of boxed content.

<div class="panel panel-default">
  <div class="panel-heading">
    <div class="panel-title">
      Title
    </div>
  </div>
  <div class="panel-body">
    <p>
      Card body lorem ipsum dolor sit amet, consectetur adipisicing elit. Ratione porro itaque culpa adipisci iusto qui accusamus, dolorum cumque eligendi laudantium doloribus illo, eveniet accusantium, ducimus voluptatum dolore expedita repellendus totam.
    </p>
  </div>
  <div class="panel-footer">
    <p>
      Card footer lorem ipsum dolor sit amet, consectetur.
    </p>
  </div>
</div>

Note that custom markdown exists to implement this card. See the readme for this repo for details. Example (but don't indent your markdown like is shown here):
~~~ html
  [[Title
  Card body lorem ipsum dolor sit amet, consectetur adipisicing elit. Ratione porro itaque culpa adipisci iusto qui accusamus, dolorum cumque eligendi laudantium doloribus illo, eveniet accusantium, ducimus voluptatum dolore expedita repellendus totam.
  Card footer lorem ipsum dolor sit amet, consectetur.]]
~~~

## Table

Below is an example of our default style table.

First Header  | Second Header
------------- | -------------
Content Cell  | Content Cell
Content Cell  | Content Cell

~~~ markdown
First Header  | Second Header
------------- | -------------
Content Cell  | Content Cell
Content Cell  | Content Cell
~~~

## Markdown

Yes you read that right - this text is written in [Markdown](http://daringfireball.net/projects/markdown/syntax) using the [Redcarpet](https://github.com/vmg/redcarpet) ruby gem.

## Syntax Hightlighting

### Middleman Syntax

Below is a sample Ruby snippet that uses [Markdown](http://daringfireball.net/projects/markdown/syntax) and [Middleman-Syntax](https://github.com/middleman/middleman-syntax).

```ruby
parameter "cloud" do
  type "string."
  label "Cloud server should be launched in"
  allowed_values "AWS US-East", "Google"
end
```

### Multi-language Code Examples

For some examples, you might want to include multiple examples in different languages. For example, for an API call, you might want to show it in Ruby and in Curl. Custom markdown exists for this behavior. Here is an example of a 2-tabbed (curl and ruby) code example (note: don't indent your markdown like is done here -- also note that the syntax isn't quite correct - it's so this styleguide page renders the example somewhat correctly):

<script src="https://gist.github.com/jasonmelgoza/37b0973fa3094eb2f949.js"></script>

The above (un-indented) will render as:

[[[
### Curl
``` shell
curl -i -h -X ...
```
###

### Ruby
``` ruby
RestClient.get(...)
```
###
]]]

### Embedded Github Gist

If you're in a time crunch you could also use a embedded [Github Gist](https://gist.github.com/) which would look like the example below.

<script src="https://gist.github.com/jasonmelgoza/dc2425d74cbf9ef219be.js"></script>

### Inline Code blocks

Code can also be displayed `inline` using straight Slim or the supplied [Markdown](http://daringfireball.net/projects/markdown/syntax) filter.

## Alerts

For when you need to give your readers a heads-up type of message.

<div class="alert alert-info" role="alert"><strong>Heads up!</strong> This alert needs your attention, but it's not super important.</div>

Note that custom markdown exists to implement this card. See the readme for this repo for details. Example (but don't indent your markdown like is shown here):
```html
  !!success*Great!*....
  !!info*Note:*....
  !!warning*Watch out!*....
  !!danger*Careful!*....
```

## Steps

Here are two (very basic) step patterns which are great for quick setup guides or procedural steps.

### List Steps

<ol class="list-steps">
  <li>Read the README.</li>
  <li>Click the edit button.</li>
  <li>In the editor, write some text, tell a bit about your project.</li>
  <li>Click the save button.</li>
</ol>

<div class="media">
  <img src="http://placehold.it/550x250.png" alt="">
  <div class="media-caption">
    <small>Screenshot or GIF caption example.</small>
  </div>
</div>

<script src="https://gist.github.com/jasonmelgoza/d079bb433f01dc3edb61.js"></script>

### Table Steps

For procedural guides where details matter use this step-by-step pattern.

<table class="table table-steps">
  <thead>
    <tr>
      <th>Step</th>
      <th>Screenshot</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Read the README.</td>
      <td><img src="http://placehold.it/300x300" alt="step 1"></td>
    </tr>
    <tr>
      <td>Click the edit button.</td>
      <td><img src="http://placehold.it/300x300" alt="step 2"></td>
    </tr>
    <tr>
      <td>In the editor, write some text, tell a bit about your project.</td>
      <td><img src="http://placehold.it/300x300" alt="step 3"></td>
    </tr>
    <tr>
      <td>Click the save button.</td>
      <td><img src="http://placehold.it/300x300" alt="step 4"></td>
    </tr>
  </tbody>
</table>

<script src="https://gist.github.com/jasonmelgoza/ab461e6b2a2d37ab27c5.js"></script>
