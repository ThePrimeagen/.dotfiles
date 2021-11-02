### Day 1 Netflix
* I got to use my new thread ripper!  It was so awesome...
* But unfortunately I just got hosed on some permissions + remembering all the
  things.

* But it was pretty easy to get it up and running! (show segfault)

#### What is my first task.
* What is my first task?  Well my first task is to understand better real time
  javascript and how to best measure it.

* show Network
* show WebGPU

#### What is the fundamental problem.
* We have a function that exists, we need to measure it and find out what is
  slowing it down.  In some sense it is a lot like game programming problems.
  * [[ draw the picture ]]
  * What is the cost of thread jumping?
  * What is the cost of garbage collection?
  * Lock Contention?
  * Other unknowns?

#### Where are we expecting to solve this problem.
* We need the IC to be able to measure and solve any new problems.
* automation?

#### The Tools
* So the tool that I am exploring, one of two, will be Telemetry, a tool by
  radgametools.

* The other tools of course will be v8's set of tools provided via the debugger
  protocol.  There are advantages of each.  They both take very different
  approaches to performance.

#### Pros and cons
* Telemetry just seems like a better fit for real time, hard deadlines.  It
  should give us clear message as to what is going wrong.

* v8 will give us better insight into v8 itself, so if the problem is v8, it
  will be best to view it from their tools.  Deep integration is effectively on
  the "no" side of things.

#### So heres to the week
This week hopefully I will have a better idea of what to do next, but for, its
just exploring time and understanding people's perspectives!

#### My goal of this series.
Provide some engineering life updates every few weeks.  Hopefully you enjoy
this and hopefully I can keep making some great content!  As always, discord,
twitch.  You just got to be there, its in the comments, you don't have an
excuse.

Comment, like, sub, whatever.  Just get the job done, let that algo know who is
boss.

### books
* Think and Grow rich - napolean hill

### WebGPU webgpu
* build widget-js
  * npm i, npm run build, npm run serve
* run with webgpu
  * --inject-js=http://localhost:8080/dist/index.new.js

#### C++ files
* src/platform/gibbon/webgpu
* src/platform/gibbon/graphics/opengl/webgpu
* src/platform/gibbon/graphics/vulkan/webgpu
* src/platform/gibbon/bridge/gibbon/webgpu

### Telemetery
* Bad frame threshold.  Very cool feature of telemetry.  Seems like this aligns
  well with real time applications.
* Time spans seem great to relate some various independent actions (garbage
  collection)
* Synchronization of graphs and execution : https://youtu.be/-UY424SHxIU?t=429
* Message view to zone view was incredible.

### TOMORROW
* Meeting with monument health
* check in with teddy on refactoring
* merge any prs with harpoon
* tabnine getting started

### TabNine
* So at first it seemed not to work.  I was a bit confused....
* Now its completing everything
* This has been pretty good.  It actually works fairly well with lua.  Lua's
  language server just, likely is my guess, ever be that powerful.  Tabnine
  definitely seems to make a big difference here.

#### Day 1 at work.
* I haven't been able to do anything, I am just spending my time dealing with
  new computer.


### STARTING WORK
### TODOs
* Learn telemetry
  - build custom markers and try things out.
  - Build release (don't be a fool)

### Links
* go/telemetrytool
  - To get started using telemetry

### Kevin C.
key points on perf
**All the transit costs (js taxes)**
* Fragment assembly c++ vs js
  * Event loop cost
* Data from Stage 2 -> Stage 3
  * Bridge transit time
  * Is there an event loop involved?
  * Timings on that.

#### Later thing
* If you were to port jitter buffer, what added extra costs?

### Gustavo

#### Reporting on saturation levels
- report green, yellow, red (dropping frames) levels of cpu.

#### Start with c++ measurements
* ping pong of rtp is a good example of starting with c++

#### Running with JSC would work out of the box.
- This could be a great way to spike out what is happening.

### Sam M.
* Instrumentation feeds into telemetry and could be the thing to use.
  * Pulled from c++ or js.
  * Instrumentation.h -- start here
    * Areas are the thing you are instrumenting
    * Macros are used to give all the information (start, stop, etc etc)


### Aleksei
* Sampling Profiler in chrome does the distributive sampling across the users
  to get the correct picture in production

* Aleksei chrome tool seems the best.






















### Using rg
Using grep can be a pain because it is slow, but riggrep on the other hand is
amazing.  Oh you haven't heard of ripgrep, well let me tell you this.  It is
created with rust.

* Rust is a statically-typed programming language designed for performance and
  safety, especially safe concurrency and memory management

* Rust uses optional types to prevent null exceptions that is common in
  prehistoric programming paradigms.

* Rust strives to have as many zero cost abstractions as possible whereas
  previous system languages mire you in the nitty gritty details.

* Rusts was designed for a 40 year horizon, allowing for backwards
  compatibility and stability.

* Automatic idiomatic formatting is available via rustfmt.

* Rust has a vibrant and welcoming community

* Rust has its own tooling and package manager called Cargo















### Front end dev
* emmet great for tag generation and selection movement
  * upgrade emmet to consider js/svelte/whatever to be html capable files.
* it / at for motions = awesome.  Better than emmet























###
* ABlaze enable test (done)
* TVUI update to make policy a boolean or config (pr)
  * Get the URL for the build so anders can test it (done)
* Remove the frozen ui (done)




### More Vim Remaps
chmod file
!chmod +x %






### Alacritty
* Colors are nice.  That opengl
  (phffffftfftftftftftftftft not
  even vulkan) looks good


### Saga
I don't like the smart saga scroll.  I don't want another scroller.  The preview window feels hampered
Its pretty
renaming seems neeter, as its a pop up opposed to prompt
float term?






































## TODO
### Waiting
* jump into fx2 system's test slack and talk about warm start qoe
  * "Is this the same metric that is messing with fx2?"
  * waiting to hear back
* ftl probes
  * waiting to hear back

### Need to pursue
* What is the AppTTR impact of Milo?
  * Talk to yongjian
* productionize the rest of tvui code base and test it.
* Finish up backport 20.1
  * working on the last bits.
  * really need to improve harpoon for better git-worktree workflow
* Sam Crash report meeting.
* Anders hand off
  * create a document with all the step by steps
  * What am I seeing? (with qoe)
  * What changes do I need to make for baked in Milo?
    * What is it going to take to get this into production?
    * Where should we put milo's actual loading?
  * Talk to Ben about how we want to change the data structure?
    * What does releases look like?
  * Talk to Iaroslav / yongjian TTR
  * We don't have a canary process (how do we do this?) (Minal's team) [2022 Q1]
    * talk to vache
* App QoE

{
}

### Done
* Allocate 31548 500k.
  * waiting on deallocation for the 9th time...

## Frozen ubilds
first go to jenkins: https://ui.builds.test.netflix.net/view/QL/job/Darwin-Master/16553/
* https://ui.builds.test.netflix.net/job/QL-OPS-CreateBuildJob/build?delay=0sec Put the build number in the field
* Once you press build, you will then create a patch branch
  * https://ui.builds.test.netflix.net/job/QL-darwin-patch-20210316_16553/

-- For viewing webpack builds
* https://www.spinnaker.mgmt.netflix.net/#/applications/tvui_deploy_ql/executions?pipeline=Fast%20QL%20Webpack%20Productionize%20(Params)


## Make
1. Several modes.
  * swapping commands??
      * You want to build
      * You want to test
  * "What people don't understand is that :make was made in a
    different time" - Bill Joy - ThePrimeagen



























### Milo
#### HTTP3
* TLS, there is lots of yavascript required handshaking...
* https://tools.ietf.org/html/draft-ietf-quic-http-34#section-3.2
  * 3.2.  Connection Establishment -- Have Anders take a look.
  * 3.3.  Connection Reuse -- retaining certificates?
    * Lots of bits here, not sure how much control we have of TLS from javascript.
  * 4.1.1.  Field Formatting and Compression
    * This means no more field name case insensitive searching.
  * 4.1.1.2.  Field Compression
    * Cookie separation is a great idea.


























#### Artifact testing
* Vache and I will set up the pipeline Q1

#### Images
* Get the data correct with milo tags!

* AB Report once we have run this long enough - talk to JSON
  * 3 days to start with
  * 50K for QA, 500K for full Allocation.
    * Any visible discrepencies, reach out to JSON
* Realtimeqoe
  * Empty Boxart Rate
  * Image decode time (for this to be enabled, you must add to fast properties)
    * Talk to JSON if you ever need to do it again.
  * go/realtimeqoe_v2 custom TVUI view
  * go/tvuimemory
  * go/tvuiperflogging
  * go/tvuiimages
  * More Image Links: https://lumen.prod.netflix.net/show/TVUI%20Perf%20Logging%20Dashboard
  * http://es_tribe_ocftl_ssd_6x.us-west-2.dynprod.netflix.net:7103/goto/42a7cdca9ad8aeaff793724c3113ec66
  * milo Ratio: http://es_tribe_ocftl_ssd_6x.us-west-2.dynprod.netflix.net:7103/goto/c9b74787a51723925e385cc23d5aadc1

#### Other stuffs

* AppBoot
  * Tie could potentially make the change in December.
  * TODO: I may have to make the change, determine that this year.

### Inspector
* Check DMs from Sebstian

### Puppeteer
* Take care of the issues
* Open issue about clearing all cookies
* MDX???

#### Lower priority
* V1 https://jira.netflix.net/browse/NRDAPP-12070

## Notes
* Talk to sergey about testing milo ab test.
    * Systems test for verification.

* Automation for releasing.  We have no way of releasing milo automatically.
  * ab test properties updates (remains manual)
  * cdn should be automatically uploaded to repository
  * spinnaker job automatically released

## Meetings
### 11-02
#### Sam / Michael Crash Reporting
* Where do I see the kibana dashboards?
  * Javascript Exception Rates: http://es_tribe_ayuda5.us-east-1.dynprod.netflix.net:7103/app/kibana#/dashboard/AXTql2byU3lbhSjdrLDS?_g=h@5034921&_a=h@a4cf014
* Bridge adapter captures errors.  Logs -> classifies error

### --jsc-enable-heap-sampling nrdp exception

* Mattia> @mpaulson I am trying both nrdp-opengl-debug-20.1.5@739 and
  nrdp-opengl-debug-20.2.0@797 with --jsc-enable-heap-sampling --devtools
  --disk-cache-capacity=0 and they crash at startup. Any idea?
  * Resolution: Not fixing.
   - The reason is that this only happens on debug builds.  Don't perf test on
     non debug builds.


## Lookups
### Realtime QoE, realtimeqoe realtime memory qoe
memory: go/tvuimemory
new qoe: go/realtimeqoe_v2
new qoe quick link: go/abqoe/<test_id>

### Milo milo
cdn: https://secure.netflix.com/us/nrdjs/milo/1.0.0/milo.release.js?v=1

### Crash Reporting crashreporting crashReporting crash reporting
Javascript Exception Rates: http://es_tribe_ayuda5.us-east-1.dynprod.netflix.net:7103/app/kibana#/dashboard/AXTql2byU3lbhSjdrLDS?_g=h@5034921&_a=h@a4cf014
GoLink: go/nrdpandroidcrashes

### Device device_id deviceId
go/dex for device ids

### Big Data
* logblobs - vault.scl_uncurated_f

### FTL probes Probes
go/ftl-access-logs
* For probe dashboard

### Ablaze
#### Reports
* When running reports, make sure your allocation dates are correct.  If you
  allocate a new set, and just rerun you may not get the actual new set of
  users.


