# PhxAssocTest

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## The Problem

There is no clear cut way that I've found to test associations on form data. This repo has 1 failing test pointing to the problem. 

So far I've tried how this is set up at `./test/phx_assoc_test_web/live/list_live_test.exs`, as well as various ways of trying to simulate a click to to simulate the for fields on the form. 

What I would like to achieve is to test adding associated data in forms and saving, and then deleting the data. 
