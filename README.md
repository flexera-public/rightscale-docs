[![Last published status](https://travis-ci.com/rightscale/docs.svg?token=GoZeb5fH3U2AXfxxupWL&branch=master)](https://travis-ci.com/rightscale/docs)

[Go here](/HOW-TO.md) for a detailed How-To on the Dockerized workflow for docs development.

### Where does the new docs site live?
The docs site uses Github Pages and is available at https://docs.rightscale.com
Please do not touch the source/CNAME file.

### How do I contribute?

#### Setup your machine for writing docs

Prerequisites: you should have Ruby, RubyGems and git installed.

Before you can run a local web server to browse your docs changes, you need to perform some one-time setup:
* `git clone git@github.com:rightscale/docs.git`
* `cd docs`
* `gem install bundler -v '<2'` (http://bundler.io/bundle_install.html)
* `bundle install`

If you can't, or don't want to, install the numerous development dependencies of this project, another option is to build everything inside a Docker container. As a prerequisite, you should be running a Docker engine and have docker-compose installed. A `Dockerfile` and `docker-compose.yml` are provided for your convenience and should work with no special handling or setup.

#### Write some docs!

Once your machine is setup to run the docs application, do this:
* Switch to the master branch: `git checkout master`
* Run `git pull` to get the latest changes
* Create a new branch: `git checkout -b my_new_branch`
* Run the development server, either on your host or in a container:
    * Docker: Run `docker-compose up` and then open [http://localhost:4567](http://localhost:4567) to browse. The live-reload feature works so you can see your changes when when make them (requires page refresh).
    * Localhost: Run `bundle exec rake serve`. Open [http://localhost:4567](http://localhost:4567) to browse. It has a live-reload feature so you can see your changes in real time.
* Add/edit the content, see [http://localhost:4567/styleguide.html](http://localhost:4567/styleguide.html) for a work-in-progress styleguide that we'll be adding to over time. Please use all-lower-case file names and underscores, no spaces!
* Ensure you haven't added any broken links or images, run `bundle exec rake check_links`
* Commit your changes: `git add .` followed by `git commit -m "Add new stuff"` (plz add a meaningful commit message)
* Run `git push origin my_branch` to push your changes to GitHub
* Send a [pull-request into the `master` branch](https://github.com/rightscale/docs/pulls)
* Jim Johnson will review the changes and give you feedback
* Once your pull-request is merged, TravisCI will build the site and push it to the `gh-pages` branch, which will go live instantly!

### What should I do if there's an issue with the docs site?
Please create a JIRA ticket in the "Documentation Requests" project so we can fix it!

### A lightweight, streamlined approach for creating "Tweak" requests
In the event you just need to make a minor change or perhaps you are not a regular contributor to the docs site (i.e., you do not have or care to install all the necessary tools, etc.) you can use this quick procedure to create a branch, make a change, and submit a Pull Request for the docs team to review... [Creating a Tweak Request](http://cl.ly/251M1o241s2l).

### How can I show a live preview of my pull-request to someone?
Checkout [this Confluence page](https://confluence.flexera.com/pages/viewpage.action?pageId=153620617) on how you can do this.
Or just run `bundle exec rake surge`.

For the docker-based flow, read the [How To intructions](HOW-TO.md#previewing-docs-with-surge).

### Retina Images and Screenshots

The easiest way on OSX to add Retina screenshots is to take a screenshot (CMD-SHIFT-4), and then run `bundle exec rake img:screenshot`. Quickly fill out the form and this will create 2 images in the `source/img` directory (provided you have a Retina screen): a regular resolution one and a @2x image.

The markdown image helper will generate the appropriate srcset attribute if it finds an image file with the identical name with `@2x` appended to it. (This way you can create retina assets automatically).

For example this markdown:

```markdown
![Scenario Builder Example](/img/ca-scenario-builder-example.png)
```
generates this following HTML:

```html
<img src="/img/ca-scenario-builder-example.png" alt="Scenario Builder Example" srcset="/img/ca-scenario-builder-example@2x.png 2x" width="363" height="330">
```

provided that both `source/img/ca-scenario-builder-example.png` and `source/img/ca-scenario-builder-example@2x.png` exist.

### Custom markdown syntax
This project contains some custom markdown syntax that is used to implement the "Content Card" and "Alerts" elements in the [Styleguide](http://localhost:4567/styleguide.html)

#### Content Cards
The syntax for content cards is as follows:
~~~
[[<title of card>
<card content>
<footer of card>]]
~~~

Note that the title and footer can only be one line and must be appended/prepended to the double-square brackets marker. The footer and header are optional, although cards look strange without a header so you should really always have one.

Example:
~~~
[[Interesting Content
This card is full of interesting content that you might want to tell people about.

You can also include _markdown_ in this card.
]]
~~~

#### Alerts
The styleguide contains 4 kinds of alerts, all of which are available using the same syntax, as follows:
~~~
!!<alert_type>*<strong_styled>*<normal_styled>
~~~

The alert_type must be one of "success", "info", "warning", or "danger".

The strong_styled is simply styled strongly, usually used for a word like "Note" or "Warning".

The content can only be one line.

Example:
~~~
!!info*Note*This is something you should take note of
!!warning**This doesn't have any strongly-styled content
~~~

#### Tabbed-code examples
To have code examples that are tabbed for different languages, you surround the entire thing with `[[[` `]]]` and then surround each tab with `###`. The header `###` should have the tab name after it and shouldn't use special characters.

Example:
<pre><code>
[[[
### Curl
``` shell
curl -i -h -X ...
```
###

### Ruby
``` Ruby
RestClient.get(...)
```
###
]]]
</code></pre>

### Gliffy

#### About
Gliffy is a program used to create various types of diagrams and pictures. Any image created using Gliffy can be edited, published, or shared with other people. The exported images can be used in websites and blogs, used in standalone web pages, or downloaded as a png file.

#### Getting Started
You can access gliffy by visiting https://www.gliffy.com.

#### Editing a Pre-existing diagram
From the tool bar in the top left corner select File -> Open. Locate the desired diagram either through the directory in the left column or from the list of recently edited diagrams in the center. Select the diagram and press “Open” to begin editing.

Images and shapes can be selected from the left column and dragged into the diagram. Any image or shape can be resized and rotated.

#### Publishing a diagram
From the main editor page, select the “My Documents” button in the top right corner. This opens a Document Manager page in a separate tab. All diagrams synced to this account are displayed in the manager page. In order to publish a diagram, locate the desired diagram, select it, and press Publish.

From the publish window the diagram can be made public or private by modifying the setting at the top of the window. The diagram is given in three different forms:

Interactive Web Page: URL that can be pasted into a browser to view the diagram

Image: A PNG link that can be modified for various sizes using the dropdown menu. Sizes can be small, medium, large, or thumbnail. Currently on docs.rightscale.com images should be no wider than 600 pixels.

Embed Code: javascript code that can be pasted into a blog or website to display the given diagram. For example:
  ~~~
  <script src="https://www.gliffy.com/diagramEmbed.js" type="text/javascript"> </script><script type="text/javascript"> gliffy_did = "8271531"; embedGliffy(); </script>
  ~~~

Most people will prefer to use the Image method of exporting diagrams. Any of these methods can work but the Image method seems to be the simplest and requires the least amount of code in the page.

#### Collaborate
From the Document Manager page the option to collaborate on a diagram rather than publishing it can be selected. By selecting the email of the person/people you wish to collaborate with they will receive an email invitation to edit the diagram. While this feature can be useful, we will be using a shared account for Gliffy which means that all documents will be accessible.

### Grabbing a Page Pathname for Easy Link Building
In the lower right-hand corner of each page you will see a small 'Copy Path' icon which, when clicked, will copy the pathname for the current page to your clipboard. This can be handy when you are creating links to other pages in the docs site and you want to easily get the pathname for the target page.

### Adding keywords/tags to a page
You can add keywords/tags to a page to increase the likehood that page is listed when using these words in the search box. Just add a "tags" section in the page header like this:
  ~~~
  ---
  title: page title
  description: description of the page
  tags: tag1 tag2 tag3 tag4
  ---
  ~~~
Remember that it will take around a day for the crawler to pick up your changes and apply them to the displayed results.

### Updating the RightScale Policies page
The [RightScale Policies](https://docs.rightscale.com/policies/getting_started/policy_list.html) page is automatically updated based on the [active-policy-list.json](https://s3.amazonaws.com/rs-policysync-tool/active-policy-list.json) file that Travis creates on merge to the master branch in the [Policy_Templates](https://github.com/rightscale/policy_templates/blob/master/.travis.yml) repository.

A new task(download_policy_list) has been added to the [rakefile](docs/Rakefile) to pull in the policy list and reformat it into the structure that the [policy_list.html.slim](docs/source/policies/getting_started/policy_list.html.slim) file expects.

The task will automatically run as part of the `serve` and `build` rake tasks.

If you wish to manually update and verify the task and policy list, you can run `bundle exec rake download_policy_list` on your development machine.

### A Note on Redirects

After the RightScale acquisition, a `data/redirect.yml` file was added to easily add redirects from relative links in the Middleman app

Example:
```
- original: ca/cloud_comp/index.html
  redirect: https://docs.flexera.com/Optima/Content/helplibrary/cloudcomp.htm
```

Unfortunately, this file doesn't auto-reload in the dockerized setup, so if you're using docker-compose and editing this file, you'll need to rebuild your docker image (or fix this to auto-reload!).

#### Rebuilding your docker image
1. Stop the running docs container with CTRL+C

        $ docker-compose up
        Starting docs_docs_1 ... done
        Attaching to docs_docs_1
        docs_1  | Serving docs site locally...
        docs_1  | Goto http://localhost:4567 to see the site; press Ctrl+C to kill this.
        docs_1  | Downloading Policy List
        docs_1  | Done.
        ^CGracefully stopping... (press Ctrl+C again to force)
        Stopping docs_docs_1 ... done

1. List all docker containers

        $ docker ps -a
        CONTAINER ID        IMAGE               COMMAND                  CREATED                     STATUS              PORTS                                                         NAMES
        8611e0ac4921        docs_docs           "bundle exec rake se…"   About an hour ago   Up 29         minutes       0.0.0.0:4567->4567/tcp, 0.0.0.0:35729->35729/tcp, 23729/tcp   docs_docs_1

1. Remove the container you just stopped

        $ docker rm 8611e0ac4921
        8611e0ac4921

1. List and remove the `docs_docs` docker image

        $ docker images
        REPOSITORY                     TAG                 IMAGE ID            CREATED             SIZE
        docs_docs                      latest              6217aaefb851        About an hour ago   877MB
        rightscale/ops_ruby21x_build   latest              b741ccde3be2        6 weeks ago         590MB

1. Delete the docker image by `IMAGE ID`

        $ docker rmi 6217aaefb851
        Untagged: docs_docs:latest
        Deleted: sha256:6217aaefb85142347e67fafd5296e7570b72ac2707391843cf12d1cb86b80c11
        ...more lines...
        Deleted: sha256:7432563683263bb37fda3de20af95d0c80772dbade0fb97453b6a1c6f7b317a5

1. Make changes to `data/redirects.yml`
1. Recreate the `docs_docs` docker image and start a container

        $ docker-compose up
        ...output omitted...
```