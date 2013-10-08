Fat Fingers
===========

Oooh, hey. It's now a gem!

Fat Fingers is a gem. It gives you an easy, tested method that fixes email typos. (When "joe@gmail.com" enters in "joe@gmal.cmo", fix it for him.)

### How to install it:

If you use a Gemfile, just add `gem "fat_fingers"` to it and run `bundle install`.

If you want to just download it onto your system, run `gem install fat_fingers`.

You can see the latest version number at [rubygems.org](https://rubygems.org/gems/fat_fingers).

### How to use it, in one line:

This would be in, say, a Rails app, where you've just passed in a new User, who has an email address:

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

Just a few minutes ago, I got a "message failed to deliver" email. Why? The user had entered in their email address incorrectly. something@something.cm. I mean, really. "cm"? Whatever. It happens.

So, now there's a bit of a hassle, where I have to fix their email in the system, then re-initiate whatever process sent them that email.

That's needless work.

**Fat Fingers is simply a Ruby gem with a single method that cleans up email typos.**

It extends String objects with a method called `clean_up_typoed_email`.

All you need to do is attach that method to the user's email address before you save them in the system.

For example, when you're creating a new user, you'll clean up the email with something like this:

    @user.email = params[:email].clean_up_typoed_email

    


### Aren't we disenfranchising users with this?

There's a similar tool, called [Mailcheck.js](https://github.com/Kicksend/mailcheck). It offers suggestions to the user, to check the email they entered to make sure it's legit.

Fat Fingers is different, in that it does the work silently, without checking with the user. It also has a more focused use-case. All we're trying to do is to eliminate *clearly* wrong email addresses.

Perhaps you want to roll with their approach. That's cool, and you'd be in good company. For my own projects, I'd rather not bother the user with something that's obviously wrong, if I can fix it on my own.

Put in other words, **there's absolutely no reason why a webapp should allow a user to register with the email "@gmali.com", or "@gmail.ocm", or anything else that's clearly wrong.** And we shouldn't add friction to the signup process by asking them "are you sure you spelled your email correctly?" (especially since they'll probably just say "of *course* I spelled my email correctly", without actually checking it).


### Are there tests for this code? How can I know it won't false-positive something legitimate, like "@something.co"? ###

There *is* a full test suite for this code, baked right in. Over 430 tests! Just look at the [code](https://github.com/charliepark/fat_fingers/blob/master/test/test_fat_fingers.rb) and you'll see the unit tests. You can also just clone / fork the gem to your machine and run `rake` or `rake test` and the tests will run.

They should all pass. Let me know if they don't.

Alternately, if there's a test case that we haven't written yet, just open up an "issue" here on the GitHub repo, and we'll get right on it. Or, if you want to write your own and send a pull request, that's cool, too.


### What failing emails does Fat Fingers catch? ###

It's a moderately-long list, mostly centered around the kinds of email providers that have lots of users (and lots of users prone to typo their email providers' names). Your 'Yaho's, your 'Hotmali's, your 'Gmial's. That sort of thing.

Also, just about every incorrect permutation of '.cm', '.cmo', 'comn', and all the other invalid TLDs that you think "there's no way someone could *possibly* type that in" (and yet, they do).

To see the full list of what Fat Fingers will catch, check out [the tests](https://github.com/charliepark/fat_fingers/blob/master/test/test_fat_fingers.rb).

### Are there any TLDs that Fat Fingers doesn't handle elegantly?

There are a few: .cm .et .ne .om. Basically, TLDs that are one character off of legit .com and .net addresses. Fat Fingers will convert those to .net and .com addresses.

To be honest, though, they're far more likely to be typos than actual, valid addresses. For example, **it's more likely your users are mis-typing ".com" than that they're Cameroonian (".cm").**

Fat Fingers elegantly handles all of the TLDs recognized by Google as "[generic TLDs](https://support.google.com/webmasters/answer/1347922?hl=en)", including .co, .fm, .io, and .me. In fact, apart from those four we listed at the top of this section (.cm, .et, .ne, .om), Fat Fingers gracefully handles every TLD in the world.

### A quick note for users running this on Ruby < 1.9

For simplicity's sake, I've set the minimum Ruby version for this to 1.9.2. There's a very good chance it'll work on 1.8 or other Rubies. If you're interested in testing it out on a different Ruby version and letting me know how it works for you, I'd love to know.


### Code Climate!

[![Code Climate](https://codeclimate.com/github/charliepark/fat_fingers.png)](https://codeclimate.com/github/charliepark/fat_fingers)

## Make it better!

I'd love to hear suggestions, critiques, and improvements. Feel free to fork it, ask me to pull in changes, and so on. I'd also love any test improvements, of course.