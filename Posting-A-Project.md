We maintain a list of projects that use ev3dev on [ev3dev.org](http://ev3dev.org). Each project gets a dedicated page for the author to explain what they have been working on, along with provide videos, pictures, build instructions, code, and any other media that pertains to the project. This is where we explain how you can submit your project page to be hosted on the site.

##Overview
For those of you familiar with git, just reading the overview should be enough for you to get started.

All the posts on the website are stored in the [posts folder](https://github.com/ev3dev/ev3dev.github.io/tree/master/_posts). Each post is saved as a Markdown file, and is automagically converted to HTML when you publish your changes (read more about Markdown [here](https://help.github.com/articles/markdown-basics)). To submit a page, all you need to do is add a markdown file in that folder and submit a pull request. We recommend that you start with a copy of the [template project](https://github.com/ev3dev/ev3dev.github.io/blob/master/_posts/2014-03-21-Example-Project.md). You can see the example file live on [the website](http://www.ev3dev.org/projects/2014/03/21/Example-Project/).

##Step 1: Getting a Copy of the Website Source
The first step to submitting your project is forking and cloning the source code of the website. To do this, open a browser and navigate to the [website repository](http://github.com/ev3dev/ev3dev.github.io) on GitHub. Make sure that you are signed in to your GitHub account, and then click the "fork" button in the upper-right corner.

<img src="https://github-images.s3.amazonaws.com/help/repository/fork_button.jpg" style="max-width: 300px;"  /> 

It should take a second, but when GitHub finishes processing your request you should be at a page very similar to where you started, except now you are looking at your own copy.

Now that you have forked the repo, you have to download the code. Make sure that you have git installed (see: [Setting Up Git](https://help.github.com/articles/set-up-git), and then run this command in the terminal: `git clone https://github.com/<username>/ev3dev.github.io` (remember to replace `<username>` with your GitHub username).
Now you have downloaded your own copy of the website. The files should be in a folder called `ev3dev.github.io`, which will be located wherever you were when you executed the above command.



##Step 2: Adding Your Page
Now that you have downloaded the site, it's time to create your page. To start, make a copy of the example project file in the `_posts` folder. Name it `year-month-day-`, followed by the name of your project wth dashes instead of spaces. Open up the new file in the text editor of your chosing.

The format for pages is pretty simple. In between the "---"s, there are properties that describe your project. Fill out as many as you can, and delete the lines of the ones you can't fill out. After the properties, you can type your description text, which is later parsed as [Markdown](https://help.github.com/articles/markdown-basics).

##Step 3: Submitting Your Changes
Once you are happy with your new page, you need to submit your changes for review. Make sure that you have saved your changes, and then open up the same shell you used earlier and navigate inside the folder that we created. To save the changes up on GitHub, run the following commands: `git add .`, followed by `git commit -a -m "<message>"`, replacing `<message>` with a brief explanation of what you added. Then run `git push` to push your changes to the server.

Open a browser and navigate to "https://github.com/<user>/ev3dev.github.io". Click the green "Compare, review and pull request" button.

<img src="https://github-images.s3.amazonaws.com/help/pull_requests/pull-request-start-review-button.png" style="max-width: 300px;" />

Then click "Create pull request," and enter a title and brief description of your changes before clicking the button that says "Create pull request" again to submit your changes. The project maintainers will be notified automatically that you have submitted edits, and will review and merge your changes when they get the chance.
