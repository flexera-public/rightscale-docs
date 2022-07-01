# Overview

The purpose of this document is to provide a "How-To" for updating documentation using Middleman.
[Middleman](https://middlemanapp.com/) is a framework for easily building websites with static content, perfect for a documentation website.

These docs are currently shown at [https://docs.rightscale.com/](https://docs.rightscale.com/).

# Local Development Setup

The instructions provided below are for the Dockerized workflow for editing our documentation. It is possible to install Ruby locally along with all the other dependencies, but it is not recommended as it is a huge pain and likely will require hours of your time working out OS-related issues. To streamline setup and save your sanity, a Docker image build is provided.

## Prerequisites

This section contains a list of prerequisites for the Dockerized workflow when editing our docs:

### Install Docker

Docker is a set of software tools for building and maintaining "containers", which are isolated environments (like a virtual machine) that can run code in any operating system. You'll need to install Docker.

You can get Docker [here](https://docs.docker.com/get-docker/).

### Install `git`

The `git` commandline tool is used for version control. When you make changes to the docs, you will create a _feature branch_ from the _main branch_, make your changes to the docs, commit your changes into your branch, then merge them back into the main branch.

You can download git [here](https://git-scm.com/downloads).

The most common `git` workflow looks like the following (commands typed into the terminal application of your OS):

		$ git checkout master             # Checkout the master branch
		$ git pull origin master          # Pull down all updates to master branch from Github
		                                  # This ensures you're have the latest docs.
		$ git branch my_change            # Create a feature branch called 'my_change'
		$ git checkout my_change          # Checkout your 'my_change' feature branch
			# ... Make some changes locally ...
		$ git add .                       # Stage all of your changes to be committed
		$ git commit -m "what I changed"  # Create a new commit on your feature branch
		                                  # The commit message will be "what I changed"
		$ git push origin my_change       # Push your my_change feature branch to GitHub
			# ... Create a Pull Request in GitHub to review and merge your changes into master

_Note: if you use the optional GitHub Desktop tool below, these commands will be automatically run in the background for you._

For more information on git, [read this nice introduction](https://git-scm.com/book/en/v2/Getting-Started-What-is-Git%3F).

### (Optional) Install GitHub Desktop

For those who are new to using the `git` commandline tool, you may prefer instead to use GitHub Desktop, which is a free, GUI application built to streamline the main operations in `git`. You'll still need to have `git` installed, but the GUI will build and run the `git` commands underneath for you.

You can download GitHub Desktop [here](https://desktop.github.com/).

### GitHub access to the RightScale org

You will need access to the RightScale org to edit docs. Please ask your manager.

In addition, you will need to follow [these instructions](https://help.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh) for creating and registering an SSH key with GitHub so you can securely and safely work with private repositories.

### Clone the `rightscale/docs` repository

To clone the `rightscale/docs` repository, do the following:

1. Open the terminal application on your computer
2. Create a folder where you want the docs Git repository to live. For example, you might want to put the docs repo under `<YourHomeFolder>/Docs/`. Below is an example in MacOS:

		$ cd ~        # Change directory to your home folder (~ is an alias)
		$ mkdir Docs  # Make a directory/folder called "Docs"
		$ cd Docs     # Change directory to your Docs folder

3. Clone the `rightscale/docs` repo

		$ git clone git@github.com:rightscale/docs.git

	If you encounter any issues running the above command, you likely do not have an SSH Key registered with GitHub. Please refer to the previous section for a link to instructions to do this.

4. Change directory into the `rightscale/docs` repository

		$ cd docs

Congratulations! You should now have everything you need to write documentation.

## Starting the Middleman Docs Server

Once you have all of the prerequisites, you can start the Middleman docs server using the following steps.

1. Make sure that you are in the cloned `rightscale/docs` repository
2. Build and run the `docs` Docker image with `docker-compose`

		$ docker-compose up
		Building docs
		Step 1/12 : FROM rightscale/ops_ruby21x_build
		 ---> b741ccde3be2
		..............................
		... LOTS OF OMITTED OUTPUT ...
		..............................
		Step 12/12 : CMD ["bundle", "exec", "rake", "serve"]
		 ---> Running in d1117a3dc0e1
		Removing intermediate container d1117a3dc0e1
		 ---> 2cb4c62c63e9
		Successfully built 2cb4c62c63e9
		Successfully tagged docs_docs:latest
		WARNING: Image for service docs was built because it did not already exist. To rebuild this image you 		must use `docker-compose build` or `docker-compose up --build`.
		Creating docs_docs_1 ... done
		Attaching to docs_docs_1
		docs_1  | Serving docs site locally...
		docs_1  | Goto http://localhost:4567 to see the site; press Ctrl+C to kill this.
		docs_1  | Downloading Policy List
		docs_1  | Done.
3. Open your browser and go to [http://localhost:4567](http://localhost:4567).


Wait about 10 seconds and you should see the docs site appear in your browser, served from Middleman's web server running locally in your Docker image. Any time you change the files in the `rightscale/docs` Git repository, Middleman will automatically reload those changes and display them for you.

## Rebuilding docs Docker Image

From time to time, you may find that you need to rebuild the docs Docker image, for example if you modify anything in the `data/` or `source/img/` folder of the repository.

To rebuild the docker image do the following steps.

1. Terminate the running Middleman server started in the previous section by typing CTRL+C together. The Middleman server was started previously using `docker-compose`.
2. Rebuild the `docs_docs` Docker image

		$ docker-compose up --build
		Building docs
		...................................
		... SIMILAR OUTPUT AS LAST TIME ...
		...................................
		Successfully built 2cb4c62c63e9
		Successfully tagged docs_docs:latest
		Recreating docs_docs_1 ... done
		Attaching to docs_docs_1
		docs_1  | Serving docs site locally...
		docs_1  | Goto http://localhost:4567 to see the site; press Ctrl+C to kill this.
		docs_1  | Downloading Policy List
		docs_1  | Done.

## Common Workflow for Making Doc Updates

The below steps outline the common workflow for editing and publishing docs to the docs website. Only the process is outlined below, since the actions required differ depending on whether you're using GitHub Desktop or the `git` commandline tool directly.

1. Checkout the latest changes on the main/master branch
2. Create a feature branch. We typically name feature branches with the following format:

		<JIRA-Ticket-ID>_<Description>

	For example:

		IND-321_add_docs_for_azure_mca

3. Ensure you are checked out on the feature branch
4. Make your desired doc updates.
5. Commit your changes to your feature branch. As you make updates to the docs, it is good to commit your changes often and multiple commits are encouraged.
6. Push your changes to GitHub and open a PR (Pull Request). Here is [an example](https://github.com/rightscale/docs/pull/1598) of a GitHub Pull Request.
7. Ask someone to review your PR in GitHub.
8. Address any feedback from the reviewer by making changes and comitting and pushing them to Github.
9. Ask the reviewer to review again and approve if okay.
10. Once approved, merge to the main/master branch.

## Previewing Docs with surge

Once you have your docker-based development environment setup and you've made your changes on a feature branch, you can build and publish a preview of your docs using surge. This will allow other stakeholders to easily preview your changes.

1. Follow the instructions for [Starting the Middleman Docs Server](#starting-the-middleman-docs-server).
1. Wait until your docker image is built and running
1. Execute `docker exec -it docs_docs_1 bash`
1. Execute `bundle exec middleman build`
1. Execute `cd build && rm CNAME` (**very** important, otherwise you'll try to publish to docs.rightscale.com and fail)
1. Execute `surge login` and enter Flexera email and password
1. (If new account) Go to your Flexera email and verify your email address with Surge (check spam if you don't see a verification email)
1. Once your email is verified, execute the `surge` command:

		(node:125) Warning: Accessing non-existent property 'padLevels' of module exports inside circular dependency
		(Use `node --trace-warnings ...` to show where the warning was created)
		   Running as jgaylor@flexera.com (Student)

		        project: /srv/build/
		         domain: bloody-basin.surge.sh
		         upload: [====================] 100% eta: 0.0s (3248 files, 150309456 bytes)
		            CDN: [====================] 100%

		             IP: 138.197.235.123

		   Success! - Published to bloody-basin.surge.sh
1. Share to the URL (https://bloody-basin.surge.sh/ in above example) with others!

## Publishing the Latest Doc Updates

The docs site uses Github Pages and is available at [https://docs.rightscale.com](https://docs.rightscale.com). As soon as you merge your feature branch into the main/master branch, a CI (Continuous Integration) build is kicked off in Travis-CI, and the docs are published automatically.

You can see the latest builds here, along with their status: [https://travis-ci.com/github/rightscale/docs/builds](https://travis-ci.com/github/rightscale/docs/builds)