# Slide 1

> Welcome to a presentation on using command line tools
> for fun and profit. If you scan the QR code on the left
> of the presentation, then you will see the repository
> for the things that I'll be talking about, today. All
> of the commands that I am going to use are listed in
> that directory.

# Slide 2

> As for an agenda, I'm going to be covering a variety of
> command line tools that I use in my own day-to-day work,
> even with available scripting languages like Python
> lying around for me to use. The links to all of these
> are in the README file of the repository. I'm going to
> be showing you different command line utilities and
> programs that potentially can help you unleash the
> power of the command line because, sometimes, there's
> no reason to open up another window. This presentation is
> not for you to walk away an expert, but that you are
> aware of tools that you can use to do interesting things
> without relying on other languages that may not be on
> machines that you interact with, or that you want to
> just work on any Unix-like operating system.

# Slide 3

> The reason this particular subject came about is because
> one of our alum who was in a professional development
> class that I was teaching saw me use some command line
> tools that they'd never seen before. That particular
> lecture was on dynamic programming, an algorithm design
> strategy that can reduce the number of computations from
> exponential to linear. I'm going to show you what I mean.

```
cd code/ackermann
./ackermann.py -h
```

> Here's the definition of a very interesting function in
> algorithm design, one called the Ackermann function. It
> grows really fast based on the first argument. Really,
> really fast. I'm going to have it calculate the Ackermann
> number for 3, 6, which is the largest Ackermann number
> I can calculate using a naive implementation without
> getting a stack overflow error.

```
clear
./ackermann.py 3 6
```

> A rather small total, to be sure. In talking about this
> algorithm, I would like to know what values it calculated.
> I'll do the same but have it print out each calculation
> that it performs.

```
clear
./ackermann.py -v 3 6
```

> Well, that printed out a lot of calculations. I would like
> to know how many calculations were performed. The first
> thing I'm going to do is filter the output so that I get
> only lines that contain Ackermann and not the last line.
> I will use the command line tool `grep` to do that.

```
«don't hit enter, yet»
clear && ./ackermann.py -v 3 6 | ggrep Ackermann
```

# Slide 4

> In case you have never done this on the command line, the
> pipe ("|") operator takes the text printed to the output
> from the program on the left and makes it the standard input
> for the command on the right. It's as if the computer is
> typing the output from the thing on the left as the input for
> the thing on the right. Let me show you an example.

```
«clear the command line»
tput cols
```

> The `tput` utility outputs information about the terminal.
> In this case, I've asked it to report the number of text
> columns in the current terminal. What if I want to calculate
> half of the number of columns in the terminal. There's
> another program called `bc`, which stands for "basic
> calculator". I can type `bc`, and then do math in it.

```
bc
125 / 2
```

> You can see that by typing "125 / 2", the `bc` program
> calculated the quotient.

```
quit
```

> Finally, there a program named `echo` that prints its
> input to the output, literally echoing what it was given.

```
gecho "$(tput cols) / 2"
```

> The dollar-sign-parentheses runs the command and
> interpolates the result into the string. Now, what I'd
> like to do is use the output of one program
> to be the input of another program. I can do that with
> `echo` and `bc`.

```
gecho "$(tput cols) / 2" | bc
```

> And, there we go, we have calculated half of the number
> of columns using the pipe operator. Mind you, there are many
> other ways to do this. I just wanted to make sure you
> understood the pipe operator.

```
clear
«do not hit enter»
./ackermann.py -v 3 6 | grep Ackermann
```

> In this command, the output of the `ackermann.py` program,
> all of the text that you saw for each of the calcs, becomes
> the input of the `grep` program on the right. `grep` only
> returns lines that match the pattern given to it, in this
> case, the word "Ackermann".

```
«hit enter»
```

> You can see that the last line of output which showed the
> Ackermann number did not appear because it did not contain
> the word "Ackermann" in it. Now, I want to get a count of the
> lines. There's a utility for that called `wc` which stands
> for "word count".

```
clear
./ackermann.py -v 3 6 | ggrep Ackermann | gwc -l
```

> When I give the `wc` program the `-l` flag, it tells it to
> count lines rather than words. You can see that it took
> 172,233 calculations for this result. Because of the
> recursive nature of the program, I know that there are
> points when the same calculation is made. I'd like to
> investigate that. What'd I'd like to know is how many
> unique calculations were made. I'm going to use the word
> count utility, again, but add in two new ones: `sort` to
> sort the output, and `uniq` to deduplicate lines. I have to
> sort it because `uniq` only finds duplicate lines that are
> next to each other.

```
clear
./ackermann.py -v 3 6 | ggrep Ackermann | gsort | guniq | gwc -l
```

> Interestingly, of the 172,233 calculations, only 1,277 are
> unique! That's less than 10% of the original number of
> calculations! I can use uniq to count the number of occurrences
> of each unique line, too. So, I'll do that and sort it, again,
> to see how many times each function call gets made.

```
clear
./ackermann.py -v 3 6 | ggrep Ackermann | gsort | guniq -c | gsort
```

> Just take a look at these numbers! The Ackermann function calculates
> the value of Ackermann(0, 1), (0, 2), (1, 0), and (1, 1) each 494
> times! That's a ludicrous amount of processing for something that
> only has 1,277 unique calculations. Of course, we could fix that.
> The idea behind dynamic programming is to cache each of those
> intermediate calculations, so that there's not hundreds of repeat
> calculations, but instead, each calculation is only performed once.
> If I add the `-c` flag to the **ackermann.py** script, it will use
> dynamic programming.

```
clear
./ackermann.py -c -v 3 6 | ggrep Ackermann | gsort | guniq -c | gsort
```

> You can see that it now only calculates each step once. I can make
> sure that the number of calculations is the number of unique steps
> by checking the line count, again, of the output.

```
clear
./ackermann.py -c -v 3 6 | ggrep Ackermann | gwc -l
```

> And, sure enough, only 1,277 calculations were made.

# Slide 5

> So, to check the calculations made by the function, I used `grep`
> to filter, `wc` to count the lines of output, `sort` to sort lines
> of output, and `uniq` to remove duplicate lines, as well as count
> duplicates.

# Slide 6

> You may have noticed that when I typed those utility names on my
> Mac, I prefixed each of them with the letter "g". That's because
> I'm using the GNU utilities installed with Homebrew. Why use
> these instead of the ones that come with my macOS distribution?
> Let's take a look at the manual entries for the `uniq` utility to
> see why.

```
clear
man uniq
```

> If I go to last line of the manual entry, then I can see that this
> version of the unique command was created in December 2009. Now, if
> I look at the one with the "g" prefix,

```
man guniq
```

> I see that it's from September of this year! The GNU utilities are
> almost always ahead of their BSD counterparts. Because of that, I
> install the listed packages over on the left onto my computer. Let's
> take a look at what the Homebrew entry reports for the coreutils
> package.

```
clear
brew info coreutils
```

> There on that line is the message that all of the utilities that
> the package installed are installed with a "g" prefix. They do that
> so that programs that rely on the BSD versions of these utilities
> don't break. That just means typing the extra letter "g" in front
> of each of the programs that I want to use. If you're on Linux, then
> they'll just be the normal names of the programs with no "g" prefix.
> I'm going to use utilities from each of these packages. That's why I
> include their names, here.

# Slide 7

> While I have this brew information open, I'd like to talk just a
> moment about the terminal emulator that I'm using. It's called
> "kitty". I like it a lot. It does some pretty cool things. For
> example, there's a keyboard shortcut to highlight the URLs that are
> in the window.

**Press CTRL+SHIFT+E**

> You can see that the URLs are now highlighted and numbered. I can now
> press the number associated with a URL to open it in the browser.

**Press 2**

**Let the browser window open**

**Go back to terminal**

> I can also click, if I really want to, with my mouse.

**Click the link to open the browser window.**

**Go back to the terminal**

> I know that choosing a terminal emulator is a very personal decision.
> A lot of people like iTerm2 for macOS. A lot of people like Alacrity
> for supporting all modern OSes. I like Kitty which supports macOS and
> Linux. One of the things I like about Kitty is that I can control
> aspects of it from the command line. For example, if I want to change
> the colors of the window for a moment, I can do it with a command.

```
kitty @ set-colors foreground=magenta background=darkgray
```

That's not nice, but it's a drastic example.

```
kitty @ set-colors --reset
```

> Kitty can also allow you to control other aspects of the window. For
> example, I can create a new window in this tab.

```
clear
kitty @ new-window
```

> You can see that there's a new window that contains a new shell. You
> can script things like window visuals, too, like setting the background
> image of the OS window.

```
cd «repo»
kitty @ set-background-image slides/term_bkg.png
CTRL+C
clear
exit
```

> Hello, Sock Puppet and Trash Panda. It also allows me to show images
> inline using its extensibility mechanisms called kittens. It's openly
> scriptable! There's a kitten called "icat" which shows images directly
> in the terminal. That's how I'm showing the slides on the left of this
> presentation, right now.

```
clear
kitty +kitten icat --align left slides/06-slide.png
```

> You can write your own scripts using Python to perform your own
> custom actions in the terminal. For example, there's a built-in file
> diff kitten, too, that does very nice file diffing.

```
clear
kitty +kitten diff data/left.txt data/right.txt
```

> There's a whole lot more to kitty, and I'd recommend investigating
> it if you want to try a different fast and responsive terminal
> emulator. It's time to say good-bye to Sock Puppet and Trash
> Panda.

```
kitty @ set-background-image none
clear
```

# Slide 8

> We saw earlier how to open URLs from kitty into a browser window.
> But, this is the command line; I'd really like to stay in the
> command line. Luckily, there are a couple of text-based browsers
> that runs right here in the terminal. I use one called lynx.

```
lynx
```

> That opens to my homepage, which is the Duck Duck Go search engine.

```
q
y
```

> I can also open a Web page by passing it as a command line argument.

```
lynx curtis.schlak.com
```

> Here, I can read content of the Web site, navigate around, download
> images, and fill out forms and stuff. There's no JavaScript, here,
> and I find it very interesting to see what happens on Web sites that
> use JavaScript.

```
q
y
clear
brew info coreutils
```

> What I'd like to do is have a command line command that gets the first
> URL in the output from the brew info command and open that with lynx.
> I could use `grep` to filter the output, but links may appear anywhere
> in this output, so that's not a robust solution.

```
clear
brew info --help
```

> If I look at the help documentation of `brew info`, I see that there's
> an option to output the help in JSON format. I'm going to take a look at
> that.

```
clear
brew info --json coreutils | bat -l json
```

> Sure enough, it emits structured output that contains the information
> about the formula. I'm using another utility called `bat` that can
> highlight output for a language. You can see that the output represents
> an array that contains an object that has a property named "homepage"
> that contains the URL that I'm looking for.

# Slide 9

> Here's my process. What I want, now, is a way to work with JSON from the
> command line. Thankfully, there is a command line tool for working with
> JSON called `jq`.

```
clear
jq --help | bat
```

> This seems like exactly what I want, a way to interact with JSON on the
> command line. I will pipe the output from the `brew info` into `jq` and
> select the "homepage" property.

```
clear
brew info --json coreutils | jq '.[].homepage'
```

> Now that I have the output, I'd like to use `lynx` to open it. So far,
> I've been using the pipe operator to pass output from one program to
> the input of the next. I'm going to try that with `lynx`.

```
clear
brew info --json coreutils | jq '.[].homepage' | lynx
```

> That didn't work because `lynx` doesn't want the URL as input from the
> program, but as an argument!

# Slide 10

> Instead of input being piped directly into the program, what I really
> want is for the output of one program to become the command line
> argument of the next program. That's where the `xargs` utility comes
> into play.

```
clear
man gxargs
```

> The `xargs` utility takes values piped into it and turns it into command
> line arguments for you.

```
«q»
clear
«do not hit enter»
brew info --json coreutils | jq '.[].homepage' | gxargs lynx
```

> The `xargs` utility will take the output of the `jq` program which is the
> URL that I want to open, and make that the command line argument of the
> command given, in this case, `lynx`.

```
«hit enter»
```

> And, there we are. It now opens `lynx` with the URL of the homepage for
> the brew package. If I wanted to turn this into a program so I didn't
> need to type the full command line every time, I can do that with some
> simple shell scripting.

```
bat ./code/brew-lynx.sh
```

> The first line has something called a hash-bang which tells the shell to
> execute this script with a particular program. In this case, it runs
> `/usr/bin/env sh` to find a shell program and execute it in the user's
> environment. For example, let's take a look at the first line of the
> Ackermann script from earlier in the presentation.

```
clear
bat ./code/ackermann/ackermann.py
```

> You can see the first line of the script uses the `/usr/bin/env` utility
> to find the `python3` program in my environment and run the `ackermann.py`
> script using Python 3. Okay, back to the `brew-lynx.sh` script.

```
clear
bat ./code/brew-lynx.sh
```

> Lines 3 through 8 are just checking to make sure that the first argument
> to the script actually exists. Then, there's the big command on line 9.
> You can see that the term "$1" refers to the first command to the script
> which will be the package name for use by `brew info`. Now, if I add that
> to my path, it will be available anywhere to me.

# Slide 11

> The tools that I used to do this were `jq` for handling JSON-formatted
> output, `xargs` to build command lines from the output of another file,
> `bat` to view the syntax-highlighted contents of text files, ...

# Slide 12

> ... the hashbang syntax to indicate which program should run a script,
> and the $-number syntax to indicate the value of the positional
> command line arguments for the script.

# Slide 13

> Something I'm occasionally interested in doing is seeing the statuses
> of the Git repos I have in my development directory. I could just go
> into each directory and type out the commands, but that takes too much
> time, > especially when I can use the command line tools to do this for
> me. Also, I have Git repositories all over my computer. I'd like to
> just automatically search for them, if possible. With that in mind,
> the first step is to find each of the _.git_ directories because
> where those are, there's a Git repository.

# Slide 14

> Step one is to find all of the .git directories. Luckily, finding
> files and directories by name or pattern is easy with the `find`
> utility.

```
clear
gfind «dir with lots of repos» -type d -name '.git'
```

> The syntax is pretty simple. You tell the `find` utility which
> directory to search in as the first argument, then tell it what
> you're looking for. In my case, I'm searching for things of type
> "d", which means "directory", and with the name ".git". You'll
> notice that it took quite a while to do that. That's because some
> of those projects are Node.js projects, which means there are
> hundreds or thousands of nested directories to search through
> in the "node\_modules" directory. I'd like to tell `find` to
> ignore those directories. To do that, I use the "prune" flag in
> a separate grouping using parentheses.

```
clear
gfind «dir with lots of repos» \( -type d -name 'node_modules' -prune \) -o \( -type d -name '.git' \)
```

> You'll see that runs almost instantly because `find` is pruning
> the search from the "node\_modules" directories. But, it's now
> printing the ".git" and the "node\_modules" directories. I want
> it to only print the ".git" directories. I will add a "-print"
> command to the last clause.

```
clear
gfind «dir with lots of repos» \( -type d -name 'node_modules' -prune \) -o \( -type d -name '.git' -print \)
```

# Slide 15

> Now, that prints just the Git directories which is what I wanted.
> It'd be great to run the `git status` command from those directories
> to get the remote for the repository. Luckily, `find` has an "execdir"
> argument that I can use to do just that.

```
clear
gfind «dir with lots of repos» \( -type d -name 'node_modules' -prune \) -o \( -type d -name '.git' -print \) -execdir git status -s \;
```

> This will run the `git status -s` command in the directories that matched
> the `find` command.

# Slide 16

> If there are modifications in the repository, I'd like to take all of the
> lines and collapse them into a single line. Earlier, I used the `uniq`
> command to remove duplicate lines. What I want to do is take these lines
> that contain the changes and turn them into a single message line. I'm
> going to use a new command to do this, a command called `sed` which means
> "stream editor". It allows you to do complex substitutions on input. Let
> me please provide an example. Here's the content of one of those files
> that I diffed earlier.

```
clear
bat data/sed-example.csv
```

> Here's a file that contains comma separated values. I'm going to open
> it in another program so that we can see it better.

```
sc-im data/sed-example.csv
```

> Here's a tabular view of the data. I'd like to change these "no" and
> "yes" values to 0s and 1s, and remove these weird symbols. I can use
> `sed` to do this.

```
clear
cat data/sed-example.csv | gsed 's/1-Yes/1/g'
```

> This searches each line for the value "1-Yes" and replaces it with "1".
> The "s" means "substitute" and the "g" means "global", which will replace
> all occurrences in the line. Without the "g", it would only replace the
> first match. I can just add another `sed` command for the "No" entries.

```
clear
cat data/sed-example.csv | gsed 's/1-Yes/1/g' | gsed 's/2-No/0/g'
```

> Now, I just want to replace the weird symbol with nothing.

```
clear
cat data/sed-example.csv | gsed 's/1-Yes/1/g' | gsed 's/2-No/0/g' | gsed 's/†//g'
```

> And, now the file is cleaned. I could save this to a new file and
> work with that. I want to do the same thing, replace values in
> lines from the Git statuses.

```
clear
gfind «dir with lots of repos» \( -type d -name 'node_modules' -prune \) -o \( -type d -name '.git' -print \) -execdir git status -s \;
```

> I want to replace all of these status lines with a message so that
> I can use `uniq` to remove the duplicates. When I look at these lines,
> I want to replace any line that begins with a space or a question mark.
> So, I'll use `sed` to find that line using a regular expression, and
> replace it with a standard message.

```
clear
«talk through the regex when you type it»
«don't hit enter»
gfind ~/dev \( -type d -name 'node_modules' -prune \) -o \( -type d -name '.git' -print \) -execdir git status -s \; | gsed 's/^[ ?].*/unmerged/g'
```

> The first caret means look at the beginning of the line. Then, I use
> the square brackets to allow it to choose from one or more different
> characters. I'm going to specify a space or a question mark. Then, I
> want it to select anything to the end of the line, which I can do with
> the period that matches any character, and the asterisk to select zero
> or more occurrences. Then, I specify to take that match and replace it
> with the value "unmerged". Let's take a look at the output.

```
«enter»
```

> I'm going to make sure that I haven't messed anything up, that things
> are properly replaced. I'd like to take the output of the `find` statement
> and save it to a file AND continue to continue passing the output to the
> `sed` statement. I can do that with the `tee` command. This way, I can
> use a diff to make sure that I'm not replacing anything incorrectly.

```
clear
gfind ~/dev \( -type d -name 'node_modules' -prune \) -o \( -type d -name '.git' -print \) -execdir git status -s \; | gtee find-result.txt | gsed 's/^[ ?].*/unmerged/g' | gtee sed-result.txt
ls
```

> Now, you can see that there are find-result.txt and sed-result.txt files.
> I'll run a diff to make sure that the correct lines were replaced.

```
kitty +kitten diff find-result.txt sed-result.txt
```

> You can see the lines that I wanted to replace are now replaced. Now, I'd
> like to remove all of the duplicate "unmerged" lines. I'll save that output
> to a file, too, to make sure that things are getting properly reduced.

```
clear
gfind ~/dev \( -type d -name 'node_modules' -prune \) -o \( -type d -name '.git' -print \) -execdir git status -s \; | gtee find-result.txt | gsed 's/^[ ?].*/unmerged/g' | gtee sed-result.txt | guniq | gtee uniq-result.txt
```

> Now, I'm going to diff the original with the `uniq` result. I do this so
> often, I've aliased this command.

```
clear
kdiff find-result.txt uniq-result.txt
```

> You can see that all of those original messages are now reduced to a
> single message. I'm going to do one more thing, and get rid of that
> "/.git" at the end of each of those directory names. Again, I'll use
> `sed` for that. The command line is starting to get a little long, eh?
> You can use the backslash character to tell the shell that you're going
> to continue the content on the next line. So, let me reformat this and
> add the command to replace the "/.git".

```
clear
gfind ~/dev \( -type d -name 'node_modules' -prune \) -o \( -type d -name '.git' -print \) -execdir git status -s \; | \
    gtee find-result.txt | \
    gsed 's/^[ ?].*/unmerged/g' | \
    gtee sed-result.txt | \
    guniq | \
    gtee uniq-result.txt | \
    gsed 's/\/.git//g'
```

> Because I'm using the forward slash as the delimeter in the `sed`
> replacement, that is the slashes separate the pattern to replace
> and the replacement, I have to escape the forward slash in the
> replacement pattern so that `sed` doesn't get confused. If I ran
> it without the escape, I get an error message.

```
clear
gfind ~/dev \( -type d -name 'node_modules' -prune \) -o \( -type d -name '.git' -print \) -execdir git status -s \; | \
    gtee find-result.txt | \
    gsed 's/^[ ?].*/unmerged/g' | \
    gtee sed-result.txt | \
    guniq | \
    gtee uniq-result.txt | \
    gsed 's//.git//g'
```

> Not a very helpful message. When you see something like that, it
> usually means the slashes are all messed up.

```
clear
gfind ~/dev \( -type d -name 'node_modules' -prune \) -o \( -type d -name '.git' -print \) -execdir git status -s \; | \
    gsed 's/^[ ?].*/unmerged/g' | \
    guniq | \
    gsed 's/\/.git//g'
```

# Slide 17

> Finally, I'd like to print this in a nice way. I'm going to do
> this in two steps, first using `sed` to move the "unmerged"
> lines onto the preceeding lines, and then print it in pretty
> columns. The problems is that `sed` normally works on a
> line-by-line basis and these are multiple lines that I'm dealing
> with. To enable that, I can turn on `sed`'s multiline mode. I'm
> going to do this in stages, so that you can see how to build up
> a command.

```
clear
gfind ~/dev \( -type d -name 'node_modules' -prune \) -o \( -type d -name '.git' -print \) -execdir git status -s \; | \
    gsed 's/^[ ?].*/unmerged/g' | \
    guniq | \
    gsed 's/\/.git//g' | \
    gsed '/$/{N;s/\nunmerged/ unmerged/}'
```

> This worked, kind of. What's going on, here? If I look at one of
> the previous results, I can investigate.

```
bat uniq-result.txt
```

> Ah, it seems that as `sed` was going along, it matched the first
> two lines and combined them. Then, it did the next two and combined
> them. If I keep going by twos, I get to a place, here on line 15,
> where `sed` has skipped over a good match because it's already read
> the previous line. What I need to do is tell `sed` to put back line
> 14 into its scanning buffer so that it can be used on the next line.
> `sed` has some pretty powerful tools to be able to do that, including
> its own minilanguage for branching. That's what I'm going to use, here.

```
clear
«do not hit enter, type as you explain
gfind ~/dev \( -type d -name 'node_modules' -prune \) -o \( -type d -name '.git' -print \) -execdir git status -s \; | \
    gsed 's/^[ ?].*/unmerged/g' | \
    guniq | \
    gsed 's/\/.git//g' | \
    gsed '/$/{N;s/\nunmerged/ unmerged/;P;D}'
```

> I've added two new things, here. These are `sed` instructions. If the
> pattern fails to match, then these extra instructions will run. The
> first instruction, "P", means print out the line that `sed` is currently
> scanning, and the "D" instruction means "put back any extra stuff so that
> you can try to match it on the next round".

```
«hit enter»
```

> That looks right to me! Now, I'd like to get those "unmerged" messages to
> the left side. I'm going to use a new program to do this, `gawk`, which
> breaks apart each line into different pieces that I can then process
> individually. By default, `gawk` splits on whitespace, so I think I've
> set myself up for happiness, here.

```
clear
gfind ~/dev \( -type d -name 'node_modules' -prune \) -o \( -type d -name '.git' -print \) -execdir git status -s \; | \
    gsed 's/^[ ?].*/unmerged/g' | \
    guniq | \
    gsed 's/\/.git//g' | \
    gsed '/$/{N;s/\nunmerged/ unmerged/;P;D}' | \
    gawk '{ printf "%-10s %s\n", $2, $1; }'
```

> I'm using a `printf` statement, here, to do formatted printing. that
> does padding and stuff. I'm almost done, here. I'd like to fill in the
> empty spaces with the word "merged". I can do that with `gawk` because
> it understands conditionals and ternary expressions.

```
clear
gfind ~/dev \( -type d -name 'node_modules' -prune \) -o \( -type d -name '.git' -print \) -execdir git status -s \; | \
    gsed 's/^[ ?].*/unmerged/g' | \
    guniq | \
    gsed 's/\/.git//g' | \
    gsed '/$/{N;s/\nunmerged/ unmerged/;P;D}' | \
    gawk '{ printf "%-10s %s\n", ($2 == "")? "merged" : $2, $1; }'
```

> It'd be really nice if I could add color to this, too. I mention that
> because I can. To make color in a shell, you have to use escape codes.
> It's ugly, but not difficult to understand. I'm going to mark each of
> the unmerged colors as red, and I'll use `sed` to do this.

```
clear
gfind ~/dev \( -type d -name 'node_modules' -prune \) -o \( -type d -name '.git' -print \) -execdir git status -s \; | \
    gsed 's/^[ ?].*/unmerged/g' | \
    guniq | \
    gsed 's/\/.git//g' | \
    gsed '/$/{N;s/\nunmerged/ unmerged/;P;D}' | \
    gawk '{ printf "%-10s %s\n", ($2 == "")? "merged" : $2, $1; }' | \
    gsed '/^unmerged/{s/\(.*\)/\\\\e[31m\\\\e[1m\1\\\\e[0m/}'
```

> This uses more complex regular expressions, which is a topic beyond
> the scope of this presentation, but is a powerful tool when it comes
> to text processing, not only on the command line, but in many text
> editors. What this statement does is for any line that starts with
> the text "unmerged", do a substitution by gathering all of the
> characters, and putting them between the "31m" thing and the "0m"
> escape codes. The "31m" makes it red, the "1m" makes it bold, and
> the "0m" resets everything. Now, to get those turned into colors, I
> need to use `echo` with the `-e` flag.

```
clear
gfind ~/dev \( -type d -name 'node_modules' -prune \) -o \( -type d -name '.git' -print \) -execdir git status -s \; | \
    gsed 's/^[ ?].*/unmerged/g' | \
    guniq | \
    gsed 's/\/.git//g' | \
    gsed '/$/{N;s/\nunmerged/ unmerged/;P;D}' | \
    gawk '{ printf "%-10s %s\n", ($2 == "")? "merged" : $2, $1; }' | \
    gsed '/^unmerged/{s/\(.*\)/\\\\e[31m\\\\e[1m\1\\\\e[0m/}' | \
    gxargs gecho -e
```

> Well, that almost has it. Things are properly colorized, but I've lost
> the newlines. That's because the text that's being passed in isn't
> wrapped in quotes and the shell essentially removes the new lines for
> us. Thanks, shell. I can fix this many ways, but I want to show you how
> to do it with the `xargs` command. Normally, `xargs` just appends whatever
> is coming to the end of the command that it's given. I want to wrap that.
> `xargs` allows me to store the input into a variable and use that in the
> command wherever I want, so that I can truly customize what `xargs` runs.
> I do that with the `-I` flag.

```
clear
gfind ~/dev \( -type d -name 'node_modules' -prune \) -o \( -type d -name '.git' -print \) -execdir git status -s \; | \
    gsed 's/^[ ?].*/unmerged/g' | \
    guniq | \
    gsed 's/\/.git//g' | \
    gsed '/$/{N;s/\nunmerged/ unmerged/;P;D}' | \
    gawk '{ printf "%-10s %s\n", ($2 == "")? "merged" : $2, $1; }' | \
    gsed '/^unmerged/{s/\(.*\)/\\\\e[31m\\\\e[1m\1\\\\e[0m/}' | \
    gxargs -I _ gecho -e "_"
```

> That stores all of the input into a variable named "_", and then I use
> it in the statement by wrapping it in quotation marks. Now, I have a
> script that highlights this for me! This is nice. I can take this and
> wrap it up into an alias for my shell. I'll show you what I mean. First,
> I copy the command that I want to use. Then, I open the file that I use
> to define aliases.

```
«this is custom for my machine»
nvim ~/dev/dotfiles/zsh-custom/aliases.sh
```

> I create a custom function named "git-dir-status" for the command, paste
> it in, do some formatting, save it, close the editor, reload my configuration,
> and now it works for any directory I'm in.

# Slide 18

> The tools used, here, were `find` to be able to find directories and ignore
> other directories. We also used it to run the `git status` command in the
> directories that it found. Then, I used `sed` to manipulate the output, both
> with single lines and doing more complex multiline matching.

# Slide 19

> I used `tee` during the development of the command to make sure that I was
> doing the right thing which can be a powerful debugging tool for you when
> working with the command line. I also used `gawk` to do some sophisticated
> processing of the content of each line, pretty printing it.

# Slide 20

> I used `xargs` with the `-I` flag to be able to place the input properly
> with the `echo` statement. I used the `echo` command with the `-e` flag
> to enable shell escape codes and print things in color.

# Slide 21

> Tabs vs. spaces. That's still a thing. So, I'm going to show you two great
> utilities in case you ever get some files that you want to convert between
> the two. I'm going to use `bat`, again, to show the contents of a file.
> I'm going to use the `--show-all` flag to have it print the white spaces,
> too.

```
clear
bat --show-all ./code/ackermann/ackermann.py
```

> You can see the dots that show the spaces in the file. Each indent is four
> spaces large. Now, there are some people that love tabs, for whatever reason.
> If I were one of them, I can use the `unexpand` utility to unexpand spaces
> back into tabs.

```
clear
man gunexpand
```

> As you can see, it does what I want, converting spaces to tabs. The default
> is eight spaces to one tab. My file has four spaces to one tab, so I need to
> use the `-t` argument to specify four spaces per tab.

```
clear
gunexpand -t 4 ./code/ackermann/ackermann.py
```

> Well, that did _something_. To check to make sure that there are really tabs
> in this instead of spaces, I'll use `bat --show-all` to view the unprintable
> characters.

```
clear
gunexpand -t 4 ./code/ackermann/ackermann.py | bat --show-all
```

> You can see that it now has tabs instead of spaces as shown by these neat
> fences in the output. The `expand` utility would take these tabs and replace
> those with spaces. To save this new output, I would redirect the output to
> a new file.

```
clear
gunexpand -t 4 ./code/ackermann/ackermann.py > ./code/ackermann/ackermann.tabs.py
bat --show-all ./code/ackermann.tabs.py
```

# Slide 22

> So, these are nice utilities to use to handle spaces and tabs, to convert back
> and forth between one another.

# Slide 23

> So, I know that there are a million ways to do all of this. Some may seem
> easier than what I have done, using Node.js, Ruby, Python, or Rust and the
> active ecosystems out there for these things. One thing to note is that
> if you have a Unix-like shell running somewhere, then these utilities are
> likely already installed on that computer. If you spend a lot of time
> working with large text files, the file system, or looking at output of
> programs, then having these tools can come in pretty handy for you.

# Slide 24

> That concludes my presentation. I'm open to take questions or comments from
> all of you that were kind enough to hang out until the end.

