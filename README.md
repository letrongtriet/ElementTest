# ElementTest

## First thing first
Edit or change content of `input.txt` file for changing the config file

## Secondly
Navigate to this project root folder (looking like `../ElementTest`)

For running the command line tools, please follow below
```
cat input.txt | swift run ElementTest 'HH:mm'
```

## Demo
```
cat input.txt | swift run ElementTest 20:0
Building for debugging...
[3/3] Linking ElementTest
Build complete! (0.41s)
Example syntax: 

======================
swift run ElementTest 16:10
======================


Your config 

30 1 /bin/run_me_daily
45 * /bin/run_me_hourly
* * /bin/run_me_every_minute
* 19 /bin/run_me_sixty_times


Your simulated time 

20:00


Here is your outputs 

1:30 tomorrow - /bin/run_me_daily
20:45 today - /bin/run_me_hourly
20:00 today - /bin/run_me_every_minute
19:00 tomorrow - /bin/run_me_sixty_times

```
