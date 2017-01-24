# Blog Poster

A ruby script that uses the [Github API][ghapi] to create a pull request and then commit it. Used for [github page hosted sites][ghpages]

It's intended to be run as a cron job once per day. It will get the branches from a specified repository and merge the branch that matches a template (the default looks like "Scheduled(2017-10-10)"). If that branch is found, it will create a pull request and then merge that pull request into the master branch for the pages repository. 

## Reasoning

I've gotten tired to trying to manage my posting schedule. 

One of the problems with github pages is that if you have it configured to [ignore future posts][ignore_future] then Github [will not rebuild them][gh_future] when that time arrives.

I've seen [posts][zapier] on how to do make it so the pages show up using zapier, but they require two different zaps, require a google calendar connection and if you change the format of the date, a paid subscription to zapier. 

That's too much for me to swallow just to get pages to show up when they should.

So, this script was born. It can be scheduled using cron once a day. It connects to github using today's date, checks to see if there is a matching branch and merges the branch into master if it's there.

## Requirements

This script requires ruby 2.4.0 to be installed along with with bundler gem.

## Setup 

1. Clone the repository to a location on the computer that will be running the job every day.

    ```bash
    git clone https://github.com/digitalbias/blog_poster.git
    ```

1. Install the ruby gems for the project

    ```bash
    bundle install
    ```

1. Rename `sample.env` to `.env`

1. Change the values in the new `.env` file.
    `GITHUB_PASSWORD` can be either an oauth token or your password.
    You can change `BRANCH_NAME_TEMPLATE` to whatever you would like. Also if you don't like the default format of `%Y-%m-%d` for the date, you can also update the date format.

    This makes it so you can have a completly different branch format the script looks at instead of `Scheduled(2017-10-10)`

1. Change permissions on the `blog_poster.rb` file so it can be executed by your cron job.

1. Set up cron job.

1. Schedule posts to your hearts content.


[ghapi]: https://developer.github.com/v3/
[ghpages]: https://pages.github.com/
[zapier]: http://www.east5th.co/blog/2014/12/29/scheduling-posts-with-jekyll-github-pages-and-zapier/
[gh_future]: https://github.com/jekyll/jekyll/issues/3174
[ignore_future]: http://www.fizerkhan.com/blog/posts/Working-with-upcoming-posts-in-Jekyll.html