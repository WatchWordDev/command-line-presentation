# Slide 1

Welcome to a presentation on using command line tools. If
you scan the QR code on the left of the presentation, then
you will see the repository for the things that I'll be
talking about, today. All of the commands that I am going to
use are listed in that directory.

```
x
```

The slides for this presentation are on the left, and I'll
advance them as I go through the presentation. This whole
presentation will be done from the command line: no
browsers, no IDEs, no other things. Just the command line.

# Slide 2

As for an agenda, I'm going to be covering a variety of
command line tools that I use in my own day-to-day work,
even with available scripting languages like Python lying
around for me to use. The links to all of these are in the
README file of the repository. I'm going to be showing you
different command line utilities and programs that
potentially can help you unleash the power of the command
line because, sometimes, there's no reason to open up
another window. This presentation is not for you to walk
away an expert, but that you are aware of tools that you can
use to do interesting things without relying on other
languages that may not be on machines that you interact
with, or that you want to just work on any Unix-like
operating system.

# Slide 3

This entire presentation is being run from a terminal
emulator named "kitty". If you're looking for a new terminal
emulator, or just want to try one out, and you're on Linux
or macOS, I would recommend trying out **kitty**. I've been
using it, now, for about a year and really enjoy its
stability, the extensibility, its speed, and its low memory
usage.

# Slide 4

The majority of the command line utilities that I use,
today, are from the GNU project. If you're on Linux, these
come preinstalled. If you're on macOS, you can install these
packages using Homebrew. If you're on Windows, you can use
WSL2 or MinGW. I'm on macOS, right now, so when I type the
commands, I'm going to put the letter "g" in front of them.
That's because macOS has its own outdated version of these
tools. For example,

```
clear
man tail
```

This is the manual page for the tail utility on macOS, the
one that comes with macOS. If I scroll to the bottom, you'll
see that it was last updated in 2006. Now,

```
q
man gtail
```

I'm looking at the help manual for the GNU utility that I
installed using Homebrew. If I scroll to the bottom, you can
see that it was last updated just a couple of months ago.
But, to prevent naming collisions, the Homebrew package
installs the GNU utilities with the "g" prefix.

```
q
```

So, on macOS, I will use the command `gtail` rather than
just `tail`. When I say I'm going to use `tail` and you see
me type `gtail`, that's the reason.


# Slide 5

I just want to spend a moment talking about how the command
line works. Every program has a thing called "standard in"
that can allow a person to type in some input. Every program
has two ways to print out results, one called "standard out"
that prints out results, and one called "standard error"
that prints out errors. Let's see that in action.

```
clear
man rev
```

There's a utility called `rev` that reverses characters in a
file. However, if you read the last sentence in this, it
says "If no files are specified, the standard input is
read." Let's see how that works.

```
q
rev
```

I didn't specify a file, so the program is just waiting for
text from standard in. If I type some text and hit "Enter",
the program reads that value and does something with it.

```
Hello
```

You can see, that the reverse program has done just what the
manual page reported that it would.

```
Good-bye
```

This program is reading from standard in and writing to
standard out.

# Slide 6

The command line allows us to hook up the standard out of
one program to the standard in of another using the pipe
character. Let's see how that works.

```
gecho Hello
```

When I use the command `gecho`, it just echoes what I give
it as an argument.

```
gecho Hello | rev
```

If I follow this with a pipe and the `rev` utility, then the
output from gecho becomes the input for the rev function.
You can see the output of this combined command is just the
output of the last utility, the `rev` command.

# Slide 7

If I add one more `rev` to this, it reverses the reversed
text

```
gecho Hello | rev | rev
```

and gives me back the original message, as you would expect.

The outptut from `echo` becomes the input for the first
`rev` invocation. The output of the first `rev` invocation
becomes the input for the second `rev` invocation. And, the
output of the second `rev` invocation becomes the output
printed to the screen.

# Slide 8

The reason this talk came about was during a lecture that I
gave in an algorithms class, one of our alumni was intrigued
by the commands that I was using to investigate the
performance of Fibonacci calculations. I have an
implementation, here.

```
clear
./code/fibonacci.py -h
```

I'm going to go through those steps, again, to show you the
utilities that I was using because these are some good basic
utilities to have when you want to analyze the debugging
output of a program.

```
clear
./code/fibonacci.py -v 8
```

If I run this utility to calculate the eighth Fibonacci
number and the verbose flag on, it prints out all of the
intermediate calculations that it made. Because there were
so many, the output fills up more than one screen. I'm going
to use a utility function to help output this in a more
reasonable manner.

```
clear
./code/fibonacci.py -v 8 | column
```

Now, I can see all of the calculations that went into the
final calculation.

```
«CTRL+SHIFT+h»
/Fibonacci\(2\)
«UP arrow»
```

If I search for "Fibonacci(2)" in the output, you can see
that the the second Fibonacci number was calculated 13
times. I'd like to figure out how many times each of those
calculations were done and list them. The first thing I'll
do is sort the output using the sort utility.

```
clear
./code/fibonacci.py -v 8 | gsort | column
```

You can see that the output is now sorted. Now, I'd like to
just see the unique lines with a count of how many times
they appear. There's a utility for that, too, the `uniq`
utility.

```
clear
./code/fibonacci.py -v 8 | gsort | guniq | column
```

You can see that the `uniq` utility removed all of the
duplicate lines. Let's look at the manual page for it,
really quick.

```
man guniq
```

An important thing to note, here, is that it only removes
adjacent matching lines. If I didn't sort the output, ...

```
clear
./code/fibonacci.py -v 8 | guniq | column
```

... then there are no adjacent matching lines, so the `uniq`
utility doesn't remove anything. Back to the good output,
...

```
clear
./code/fibonacci.py -v 8 | gsort | guniq | column
```

... this shows the unique calculations that were performed,
but not the count. But, because this is such a common thing
to do, the `uniq` utility has a command line argument, `-c`,
which counts the repeated lines that it's removing.

```
clear
./code/fibonacci.py -v 8 | gsort | guniq -c | column
```

Now, I can see the number of times that each of those lines
appeared. I can see that the first Fibonacci number was
calculated 21 times, and the third Fibonacci number was
calculated eight times. If I increase the Fibonacci number
that I'm calculating...

```
clear
./code/fibonacci.py -v 12 | gsort | guniq -c | column
```

Now, I can see that the third Fibonacci number was
calculated 55 times. If I want to know the total number of
calculations that it takes...

```
clear
./code/fibonacci.py -v 12 | wc -l
./code/fibonacci.py -v 12 | gsort | guniq -c | column
```

I can use the `wc` utility which, when given the `-l`
command argument, counts the number of lines that was output
by a program. There were 465 calculations to figure out the
twelfth Fibonacci number. It's one less than 466 because the
result 144 is also counted as part of the output. I can use
another utility called `grep` which searches for patterns
and, if they match, will only print the lines that match. I
only want the lines of the output that contain the word
"Fibonacci" in them, so I can use `grep` to filter only
those lines.

```
./code/fibonacci.py -v 12 | ggrep Fibonacci | wc -l
./code/fibonacci.py -v 12 | ggrep Fibonacci | gsort | guniq -c | column
```

Now, that extra line that contained only the result is gone,
I get the correct number of calculations, and I see only the
calculations without the result.

# Slide 9

You can use these utilities to filter files, counte how many
times things occur in them, remove duplicate lines, and sort
the lines. These are all really handy utilities. I used
`grep` to filter, `wc` to count the lines of output, `sort`
to sort lines of output, and `uniq` to remove duplicate
lines, as well as count duplicates.

# Slide 10

Because I'm on a Mac, I use Homebrew to manage the packages
on my computer. If you're on Linux, you likely use your
distro's package manager or Homebrew or some other package
manager. If you're on Windows, who knows what you use,
though Windows 11 has an okay solution. When I want the
information about a package, I can use the Homebrew package
manager to tell me about it. For example, I installed a fun
utility named `figlet` that produces ASCII art from words.

```
figlet Hello
```

If I want information about `figlet`, I use the `brew info`
command.

```
brew info figlet
```

In that information, I can see the homepage URL, figlet.org.
Because I'm in **kitty**, I can just click on the link and
it'll open in my default browser. The `brew info` command
will also open the GitHub Web page that contains the Ruby
script that will install the package.

```
brew info --github figlet
```

That's fine and all, but what I really want is a command to
open the homepage so I can read documentation and stuff. If
I look at the help for the `brew info` command, ...

```
brew info --help
```

I see that there is a `--json` flag that will output the
information for the package formatted as JSON. Let's see
what that produces.

```
brew info --json figlet
```

When something spits out a lot of text like this, I will
turn to a program called "a pager" that shows the output
one screen at a time. A lot of you probably know about
`less`.

```
brew info --json figlet | less
```

This page allows me to scroll around and whatnot. However,
there are more modern alternatives that do things like
syntax highlighting. I'm going to use one called `bat`.

```
q
brew info --json figlet | bat -l json
```

Now, I get colors for different kinds of values, and line
numbers! I see what I want, so one moment, please.

```
q
clear
brew info --json figlet | bat -l json -H 15
```

The `bat` utility also supports highlighting lines, which is
really neat. You can see, here, that the homepage for the
package is the value of the homepage property of this
object. And, if you look at line 1, you'll see that the JSON
top-level object is an array.

# Slide 11

Now that I know there's a structured JSON output that I can
use, here's my plan on the command that I'd like to write.
There is a utility that understands JSON on the command
line, and its name is `jq` which stands for "JSON query".

```
q
clear
brew info --json figlet | jq
```

I can use `jq` to select the object from the first value in
the array, then select the "homepage" property from it using
dot notation.

```
clear
brew info --json figlet | jq '.[0].homepage'
```

There we go. Now, I have just the URL for the package. What
I'd like now, is to open that in a browser. On macOS,
there's the `open` command; on Linux, there's the `xdg-open`
command; and, on Windows, there's the `start` command. So,
I'll use the `open` command for this.

```
brew info --json figlet | jq '.[0].homepage' | open
```

But, when I do this, I get an error.

# Slide 12

The `open` command does not read from standard in. In
expects the URL to be a command line argument. So, I need
another utility to intercept the input from standard in and
create a command line for me.

# Slide 13

Again, because this is such a common problem, that utility
exists and is called `xargs` which stands for "execute with
arguments". Here, the output of `brew info` is JSON which
gets piped to `jq` which selects the homepage and outputs
the URL. When that is fed into `xargs`, it takes what comes
in via standard in and makes that the command line arguments
for whatever other command you tell it to run. That's exactly
what I need, take the URL from the `jq` output and make that
the command line argument to the `open` command.

```
brew info --json figlet | jq '.[0].homepage' | gxargs open
```

And, now, I have a command that can open the homepage for
me. While that's great, and all, it's not very reusable. To
make it reusable, I could turn it into a script file or a
shell function. As a matter of fact, I already have it!

```
«open the aliases file that contains `brew-show()`»
```

You can see the function, here, which is exactly what I had
on the command line. These backslashes allow me to continue
a command on the next line. The "$1" is the first parameter
given the function. So, I can use this in my shell, now,
after I load it.

```
q
clear
brew-show figlet
```

# Slide 14

Here are the tools that I used in this section. I used `jq`
to parse and manipulate the JSON. I used `xargs` to build a
command for a utility that needs command line arguments. I
used `bat` to view output and files with syntax
highlighting.

# Slide 15

Something I'm occasionally interested in doing is seeing the
statuses of the Git repos I have in my development
directory. I could just go into each directory and type out
the commands, but that takes too much time, > especially
when I can use the command line tools to do this for me.
Also, I have Git repositories all over my computer. I'd like
to just automatically search for them, if possible. With
that in mind, the first step is to find each of the _.git_
directories because where those are, there's a Git
repository.

# Slide 16

Step one is to find all of the .git directories. Luckily,
finding files and directories by name or pattern is easy
with the `find` utility.

```
clear
gfind dir -type d -name '.git'
```

The syntax is pretty simple. You tell the `find` utility
which directory to search in as the first argument, then
tell it what you're looking for. In my case, I'm searching
for things of type "d", which means "directory", and with
the name ".git". You'll notice that it took quite a while to
do that. That's because some of those projects are Node.js
projects, which means there are hundreds or thousands of
nested directories to search through in the "node\_modules"
directory. I'd like to tell `find` to ignore those
directories. To do that, I use the "prune" flag in a
separate grouping using parentheses.

```
clear
gfind dir \( -type d -name 'node_modules' -prune \) \
        -o \( -type d -name '.git' \)
```

You'll see that runs almost instantly because `find` is
pruning the search from the "node\_modules" directories.
But, it's now printing the ".git" and the "node\_modules"
directories. I want it to only print the ".git" directories.
I will add a "-print" command to the last clause.

```
clear
gfind dir \( -type d -name 'node_modules' -prune \) \
        -o \( -type d -name '.git' -print \)
```

# Slide 17

Now, that prints just the Git directories which is what I
wanted. It'd be great to run the `git status` command from
those directories to get the remote for the repository.
Luckily, `find` has an "execdir" argument that I can use to
do just that.

```
clear
gfind dir \( -type d -name 'node_modules' -prune \) \
        -o \( -type d -name '.git' -print \) \
        -execdir git status -s \;
```

This will run the `git status -s` command in the directories
that matched the `find` command.

# Slide 18

If there are modifications in the repository, I'd like to
take all of the lines and collapse them into a single line.
Earlier, I used the `uniq` command to remove duplicate
lines. What I want to do is take these lines that contain
the changes and turn them into a single message line. I'm
going to use a new command to do this, a command called
`sed` which means "stream editor". It allows you to do
complex substitutions on input. Let me please provide an
example. Here's the content of one of those files that I
diffed earlier. `sed` can do substitutions pretty easily.

```
clear
gecho 'Hello, Curtis.' | gsed 's/Curtis/Brittany/g'
```

The syntax is "s" for substitution, then a slash, then the
pattern to match, then a slash, then what you want to
replace it with, then a slash, and I add the "g" to mean
replace _all_ occurrences. In this case, the output from
`echo`, the message "Hello, Curtis.", was the input for
`sed` which replaced all occurrences of "Curtis" with
"Brittany". This can also work on patterns using a
regular expressions language.

```
gecho "Hello, Curtis." | gsed 's/H[a-z]*/Ahoj/g'
```

In this case, it matches anything that begins with a capital
"H" followed by zero or more lower case letters. What ever
it matches, it replaces it with "Ahoj". If I add more to the
string,

```
gecho "Hello, Curtis Hero." | gsed 's/H[a-z]*/Ahoj/g'
```

It replaces both of the words that begin with capital "H". I
can use this pattern matching to match the status lines.

```
clear
gfind dir \( -type d -name 'node_modules' -prune \) \
        -o \( -type d -name '.git' -print \) \
        -execdir git status -s \;
```

I want to replace all of these status lines with a message
so that I can use `uniq` to remove the duplicates. When I
look at these lines, I want to replace any line that does
not begin with a forward slash.


```
clear
«do not hit enter»
gfind dir \( -type d -name 'node_modules' -prune \) \
        -o \( -type d -name '.git' -print \) \
        -execdir git status -s \; | \
    gsed 's/^[^\/].*/unmerged/g'
```

Regular expressions are a thing unto themselves, but the
pattern that I created matches any line that does not begin
with a slash and replaces that whole line with the word
"unmerged".

```
«hit enter»
```

I'm going to make sure that I haven't messed anything up,
that things are properly replaced. I'd like to take the
output of the `find` statement and save it to a file AND
continue to continue passing the output to the `sed`
statement. I can do that with the `tee` command. The `tee`
command saves the input it receives to a file _and_ prints
it out unchanged.

```
clear
gfind dir \( -type d -name 'node_modules' -prune \) \
        -o \( -type d -name '.git' -print \) \
        -execdir git status -s \; | \
    gtee status-results.txt | \
    gsed 's/^[^\/].*/unmerged/g' | \
    gtee sed-results.txt
```

Everything still printed out, but you can see that there are
status-results.txt and sed-results.txt files. I'll run a
diff to make sure that the correct lines were replaced.

```
kdiff status-result.txt sed-results.txt
```

You can see the lines that I wanted to replace are now
replaced. Now, I'd like to remove all of the duplicate
"unmerged" lines. I'll save that output to a file, too, to
make sure that things are getting properly reduced.

```
clear
gfind dir \( -type d -name 'node_modules' -prune \) \
        -o \( -type d -name '.git' -print \) \
        -execdir git status -s \; | \
    gsed 's/^[^\/].*/unmerged/g' | \
    guniq
```

You can see that all of those original messages are now
reduced to a single message. I'm going to do one more thing,
and get rid of that "/.git" at the end of each of those
directory names. Again, I'll use `sed` for that.

```
clear
gfind dir \( -type d -name 'node_modules' -prune \) \
        -o \( -type d -name '.git' -print \) \
        -execdir git status -s \; | \
    gsed 's/^[^\/].*/unmerged/g' | \
    guniq | \
    gsed 's/\/.git$//g'
```

# Slide 19

Finally, I'd like to print this in a nice way. I'm going to
do this in two steps, first using `sed` to combine the
"unmerged" lines onto the preceeding lines, and then print
it in pretty columns. The problems is that `sed` normally
works on a line-by-line basis and these are multiple lines
that I'm dealing with. To enable that, I can turn on `sed`'s
multiline mode which gets a little archaic, but if you like
`sed`, it's worth reading about.

```
clear
gfind dir \( -type d -name 'node_modules' -prune \) \
        -o \( -type d -name '.git' -print \) \
        -execdir git status -s \; | \
    gsed 's/^[^\/].*/unmerged/g' | \
    guniq | \
    gsed 's/\/.git$//g' | \
    gsed '/$/{N;s/\nunmerged/ unmerged/;P;D}'
```

That looks right to me! Now, I'd like to get those
"unmerged" messages to the left side. I'm going to use a new
program to do this, `gawk`, which breaks apart each line
into different pieces that I can then process individually.
By default, `gawk` splits on whitespace, so I think I've set
myself up for happiness, here.

```
clear
gfind ~/dev \( -type d -name 'node_modules' -prune \) -o \( -type d -name '.git' -print \) -execdir git status -s \; | \
    gsed 's/^[ ?].*/unmerged/g' | \
    guniq | \
    gsed 's/\/.git//g' | \
    gsed '/$/{N;s/\nunmerged/ unmerged/;P;D}' | \
    gawk '{ printf "%-10s %s\n", $2, $1; }'
```

I'm using a `printf` statement, here, to do formatted
printing. that does padding and stuff. I'm almost done,
here. I'd like to fill in the empty spaces with the word
"merged". I can do that with `gawk` because it understands
conditionals and ternary expressions.

```
clear
gfind ~/dev \( -type d -name 'node_modules' -prune \) -o \( -type d -name '.git' -print \) -execdir git status -s \; | \
    gsed 's/^[ ?].*/unmerged/g' | \
    guniq | \
    gsed 's/\/.git//g' | \
    gsed '/$/{N;s/\nunmerged/ unmerged/;P;D}' | \
    gawk '{ printf "%-10s %s\n", ($2 == "")? "clean" : $2, $1; }'
```

It'd be really nice if I could add color to this, too. I
mention that because I can. To make color in a shell, you
have to use escape codes. It's ugly, but not difficult to
understand. I'm going to mark each of the unmerged colors as
red, and I'll use `sed` to do this.

```
clear
gfind ~/dev \( -type d -name 'node_modules' -prune \) -o \( -type d -name '.git' -print \) -execdir git status -s \; | \
    gsed 's/^[ ?].*/unmerged/g' | \
    guniq | \
    gsed 's/\/.git//g' | \
    gsed '/$/{N;s/\nunmerged/ unmerged/;P;D}' | \
    gawk '{ printf "%-10s %s\n", ($2 == "")? "clean" : $2, $1; }' | \
    gsed '/^unmerged/{s/\(.*\)/\\\\e[31m\\\\e[1m\1\\\\e[0m/}'
```

This uses shell escape codes, putting the content of a line
that begins with "unmerged" between the "31m" thing and the
"0m" escape codes. The "31m" makes it red, the "1m" makes it
bold, and the "0m" resets everything. Now, to get those
turned into colors, I need to use `echo` with the `-e` flag
and to wrap the whole thing in quotation marks.

```
clear
gfind ~/dev \( -type d -name 'node_modules' -prune \) -o \( -type d -name '.git' -print \) -execdir git status -s \; | \
    gsed 's/^[ ?].*/unmerged/g' | \
    guniq | \
    gsed 's/\/.git//g' | \
    gsed '/$/{N;s/\nunmerged/ unmerged/;P;D}' | \
    gawk '{ printf "%-10s %s\n", ($2 == "")? "clean" : $2, $1; }' | \
    gsed '/^unmerged/{s/\(.*\)/\\\\e[31m\\\\e[1m\1\\\\e[0m/}' | \
    gxargs -I _ gecho -e "_"
```

And, in much the same way I built a shell function to
contain all of this.

# Slide 20

The tools used, here, were `find` to be able to find
directories and ignore other directories. We also used it to
run the `git status` command in the directories that it
found. Then, I used `sed` to manipulate the output, both
with single lines and doing more complex multiline matching.

# Slide 21

I used `tee` during the development of the command to make
sure that I was doing the right thing which can be a
powerful debugging tool for you when working with the
command line. I also used `gawk` to do some sophisticated
processing of the content of each line, pretty printing it.

# Slide 22

I used `xargs` with the `-I` flag to be able to place the
input properly with the `echo` statement. I used the `echo`
command with the `-e` flag to enable shell escape codes and
print things in color.

# Slide 23

So, I know that there are a million ways to do all of this.
Some may seem easier than what I have done, using Node.js,
Ruby, Python, or Rust and the active ecosystems out there
for these things. One thing to note is that if you have a
Unix-like shell running somewhere, then these utilities are
likely already installed on that computer. If you spend a
lot of time working with large text files, the file system,
or looking at output of programs, then having these tools
can come in pretty handy for you.

# Slide 24

That concludes my presentation. I'm open to take questions
or comments from all of you that were kind enough to hang
out until the end.
