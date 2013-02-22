Fat Fingers
===========

Oooh, hey. It's now a gem!

Fat Fingers is a gem. It gives you an easy, tested method that fixes e-mail typos. (When "joe@gmail.com" enters in "joe@gmal.cmo", fix it for him.)

### How to install it:

If you use a Gemfile, just add `gem "fat_fingers"` to it.

If you want to just download it onto your system, run `gem install fat_fingers`.

You can see the latest version number at [rubygems.org](https://rubygems.org/gems/fat_fingers).

### How to use it, in one line:

This would be in, say, a Rails app, where you've just passed in a new User:

    @user.email = params[:user][:email].clean_up_typoed_email

Or, maybe, you'd prefer the four-line version:

    $ gem install fat_fingers
    $ irb
    > require 'fat_fingers'
        => true
    > "joe@gmali.cm".clean_up_typoed_email
        => "joe@gmail.com"

## What's this all about, then?

### Let's help our users!

Just a few minutes ago, I got a "message failed to deliver" e-mail. Why? The user had entered in their e-mail address incorrectly. something@something.cm. I mean, really. "cm"? So, now there's a bit of a hassle, where I have to fix their e-mail in the system, then re-initiate whatever process sent them that e-mail.

That's needless work.

**Fat Fingers is simply a Ruby gem with a single method that cleans up e-mail typos.**

It extends String objects with a method called `clean_up_typoed_email`.

All you need to do is attach that method to the user's e-mail address before you save them in the system.

For example, when you're creating a new user, you'll clean up the e-mail with something like this:

    @user.email = params[:email].clean_up_typoed_email

    


### Aren't we disenfranchising users with this?

There's a similar tool, called [Mailcheck.js](https://github.com/Kicksend/mailcheck). It offers suggestions to the user, to check the e-mail they entered to make sure it's legit.

Fat Fingers is different, in that it does the work silently, without checking with the user. It also has a more focused use-case. All we're trying to do is to eliminate *clearly* wrong e-mail addresses.

Perhaps you want to roll with their approach. That's cool, and you'd be in good company. For my own projects, I'd rather not bother the user with something that's obviously wrong, if I can fix it on my own.

Put in other words, **there's absolutely no reason why a webapp should allow a user to register with the e-mail "@gmali.com", or "@gmail.ocm", or anything else that's clearly wrong.** And we shouldn't add friction to the signup process by asking them "are you sure you spelled your e-mail correctly?" (especially since they'll probably just say "of *course* I spelled my e-mail correctly", without actually checking it).


### Are there tests for this code? How can I know it won't false-positive something legitimate, like "@something.co"? ###

There *is* a full test suite for this code, baked right in. Just look at the [code](https://github.com/charliepark/fat_fingers/blob/master/tests/test_fat_fingers.rb) and you'll see the unit tests. You can also just clone / fork the gem to your machine and run `rake` or `rake test` and the tests will run.

They should all pass. Let me know if they don't.

Alternately, if there's a test case that we haven't written yet, just open up an "issue" here on the GitHub repo, and we'll get right on it. Or, if you want to write your own and send a pull request, that's cool, too.


### What failing e-mails does Fat Fingers catch? ###

It's a moderately-long list, mostly centered around the kinds of e-mail providers that have lots of users (and lots of users prone to typo their e-mail providers' names). Your 'Yaho's, your 'Hotmali's, your 'Gmial's. That sort of thing.

To see the full list of what Fat Fingers will catch, check out [the tests](https://github.com/charliepark/fat_fingers/blob/master/tests/test_fat_fingers.rb).


### A quick note for users running this on Ruby < 1.9

For simplicity's sake, I've set the minimum Ruby version for this to 1.9.2. There's a very good chance it'll work on 1.8 or other Rubies. If you're interested in testing it out on a different Ruby version and letting me know how it works for you, I'd love to know.


### Code Climate!

[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/charliepark/fat_fingers)

## Make it better!

I'd love to hear suggestions, critiques, and improvements. Feel free to fork it, ask me to pull in changes, and so on. I'd also love any test improvements, of course.