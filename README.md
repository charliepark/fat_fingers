Fat Fingers
===========

A regex for fixing e-mail typos. (When "joe@gmail.com" enters in "joe@gmai.cm", fix it for him.)

### Let's help our users!

Just a few minutes ago, I got a "message failed to deliver" e-mail. Why? The user had entered in their e-mail address incorrectly. something@something.cm. So, now there's a bit of a hassle, where I have to fix their e-mail in the system, then re-initiate whatever process sent them that e-mail.

That's needless work.

**Fat Fingers is simply a Ruby method for cleaning up e-mail typos.**

It extends String objects with a method called `clean_up_typoed_email`.

All you need to do is attach that method to the user's e-mail address before you save them in the system.

There are some more instructions in the file itself, but it's really straightforward.

### Testing!

Fat Fingers has its own tests.

Once you've cloned it to your system, just run `ruby fat_fingers.rb` and you'll see the output of the tests.

### Make it better!

I'd love to hear suggestions, critiques, and improvements. Feel free to fork it, ask me to pull in changes, and so on. I'd also love any test improvements.