---
title: "This Month with Nim"
author: Jason Beetham
excerpt: "I will be starting a monthly blog post for community showcase entitled 'This Month with Nim'."
---

<div class="sidebarblock">
  <div class="content">
    <div class="title">Guest post</div>
    <div class="paragraph">
      This is a guest post by Jason Beetham. If you would like to publish articles as a guest author on nim-lang.org then get in touch with us via
      <a href="https://twitter.com/nim_lang">Twitter</a> or <a href="https://nim-lang.org/community.html">otherwise</a>.
    </div>
  </div>
</div>

I will be starting a monthly blog post for community showcase entitled "This Month with Nim".

This will be a method for developers in the Nim community to publish a small part of a blog post showing off what Nim is capable of and what people are working on. A brief example of what a post might look like is below.


## January's Month With Nim

### Discord Bot

Author: Jason Beetham

Hello everyone, my current project is a Discord bot that utilizes a DSL to create an easily extendible bot. This DSL generates an `async` procedure so you only have to write the body, reducing the repetitive task of matching a procedure signature. To add a command users just have to make a Nim file in the `command` folder then replicate the following code.
```nim
import command
command:
  name: hello
  description: "This command sends hello"
  body:
    discard await discord.api.sendMessage(discordMsg.channelID, "hello")
```
This automatically subscribes the command, and thanks to a macro all files in the `command` folder are imported so nothing else is required.
If you care to check it out you can look [here.](https://github.com/GaryM-exkage/GDGW-Maverick-Bot)


## Want to see your project here next month?

[Follow these instructions](https://github.com/beef331/website#adding-your-project-to-month-with-nim) to add your project to the next month's blog post.
