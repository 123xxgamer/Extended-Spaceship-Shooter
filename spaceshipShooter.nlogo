globals [rhealth rlives difficulty lvl-countdown score over? win?]

breed [raidens raiden]
breed [raidenspawns raidenspawn]
breed [bullets-red1 bullet-red1]
breed [bullets-red2 bullet-red2]
breed [bullets-blue0 bullet-blue0]
breed [bullets-blue1 bullet-blue1]
breed [bullets-blue2 bullet-blue2]
breed [bullets-blue3 bullet-blue3]
breed [bullets-violet0 bullet-violet0]
breed [bullets-violet1 bullet-violet1]
breed [bullets-violet2 bullet-violet2]
breed [bullets-violet3 bullet-violet3]
breed [missiles-normal missile-normal]
breed [missiles-homing missile-homing]

breed [enemy-pellets-yellow enemy-pellet-yellow]
breed [enemy-pellets-green enemy-pellet-green]
breed [enemy-bullets-gold enemy-bullet-gold]
breed [enemy-charges enemy-charge]
breed [enemy-lasers-gold enemy-laser-gold]

breed [enemies enemy]

breed [powerups-weapon powerup-weapon]
breed [powerups-missile powerup-missile]
breed [powerups-max powerup-max]

breed [explosions explosion]
breed [bullet-hits bullet-hit]
breed [letters letter]

turtles-own [missile-countdown]

raidens-own [weapontype missiletype i-countdown invincible?]
bullets-red1-own [grabbed?]
bullets-red2-own [grabbed?]
bullets-blue0-own [grabbed?]
bullets-blue1-own [grabbed?]
bullets-blue2-own [grabbed?]
bullets-blue3-own [grabbed?]
bullets-violet0-own [grabbed?]
bullets-violet1-own [grabbed?]
bullets-violet2-own [grabbed?]
bullets-violet3-own [grabbed?]
missiles-normal-own [grabbed?]
missiles-homing-own [grabbed?]
explosions-own [grabbed?]

powerups-weapon-own [grabbed?]
powerups-missile-own [grabbed?]
powerups-max-own [grabbed?]

enemies-own [health btargetted? mtargetted? grabbed? fired? cooldown tracking-countdown left? weapontype]
enemy-pellets-yellow-own [grabbed?]
enemy-pellets-green-own [grabbed?]
enemy-bullets-gold-own [grabbed?]
enemy-lasers-gold-own [grabbed?]

to setup
;; (for this model to work with NetLogo's new plotting features,
  ;; __clear-all-and-reset-ticks should be replaced with clear-all at
  ;; the beginning of your setup procedure and reset-ticks at the end
  ;; of the procedure.)
  __clear-all-and-reset-ticks
create-raidens 1
ask turtles [set missile-countdown 5]
ask raidens
  [set heading 0
  set rlives 10
  set rhealth 10
  set size 3
  set shape "raiden"
  set color red
  set ycor (min-pycor - 0) / 2
  set difficulty 1
  set weapontype 00
  set missiletype 00
  set lvl-countdown 102
  set invincible? false
  set over? false]
end

to go-left
ask raidens with [xcor > min-pxcor + 2][set xcor xcor - 1]
end

to go-right
ask raidens with [xcor < max-pxcor - 2][set xcor xcor + 1]
end

to go-front
if (difficulty >= 4)
  [ask raidens with [ycor < (max-pycor - 10)][fd 1]]
if (difficulty <= 3)
  [ask raidens with [ycor < max-pycor - 2][fd 1]]
end

to go-back
ask raidens with [ycor > min-pycor + 2][bk 1]
end

to wiggle
every 0.2[
if (xcor > (max-pxcor - 3))[set heading 270 fd .5]
if (ycor > (max-pycor - 3))[set heading 180 fd .5]
if (xcor < (min-pxcor + 3))[set heading 90 fd .5]
if (ycor < (min-pycor + 3))[set heading 0 fd .5]
if (xcor <= (max-pxcor - 3) and xcor >= (min-pxcor + 3)
      and ycor <= (max-pycor - 3) and ycor >= (min-pycor + 3))
[rt random 45 - random 45
fd .5]]
end

to fire
ask turtles [set missile-countdown missile-countdown - 1]
ask raidens
  [if (weapontype = 00 and count bullets-red2 <= 10)
    [hatch 1[bullet-red-convert-double set ycor ycor + 1.5]]
  if (weapontype = 01 and count bullets-red2 <= 10)
    [hatch 1[bullet-red-convert-double set ycor ycor + 1.5]
    hatch 1[bullet-red-convert-single set xcor xcor + 1 set ycor ycor + 1.5]
    hatch 1[bullet-red-convert-single set xcor xcor - 1 set ycor ycor + 1.5]]
  if (weapontype = 02 and count bullets-red2 <= 30 and count bullets-red1 <= 20)
    [hatch 1[bullet-red-convert-double set ycor ycor + 1.5]
    hatch 1[bullet-red-convert-single set xcor xcor + 1 set ycor ycor + 1.5]
    hatch 1[bullet-red-convert-single set xcor xcor - 1 set ycor ycor + 1.5]
    hatch 1[bullet-red-convert-double set heading 15 set xcor xcor + 1 set ycor ycor + 1.5]
    hatch 1[bullet-red-convert-double set heading -15 set xcor xcor - 1 set ycor ycor + 1.5]]
  if (weapontype = 03 and count bullets-red2 <= 60 and count bullets-red1 <= 20)
    [hatch 1[bullet-red-convert-double set ycor ycor + 1.5]
    hatch 1[bullet-red-convert-single set xcor xcor + 1 set ycor ycor + 1.5]
    hatch 1[bullet-red-convert-single set xcor xcor - 1 set ycor ycor + 1.5]
    hatch 1[bullet-red-convert-double set heading 15 set xcor xcor + 1 set ycor ycor + 1.5]
    hatch 1[bullet-red-convert-double set heading -15 set xcor xcor - 1 set ycor ycor + 1.5]
    hatch 1[bullet-red-convert-double set heading 30 set xcor xcor + 2 set ycor ycor + 1]
    hatch 1[bullet-red-convert-double set heading -30 set xcor xcor - 2 set ycor ycor + 1]]
  if (weapontype = 10 and count bullets-blue0 <= 10)
    [hatch 1[bullet-blue0-convert set ycor ycor + 2]]
  if (weapontype = 11 and count bullets-blue1 <= 10)
    [hatch 1[bullet-blue1-convert set ycor ycor + 2]]
  if (weapontype = 12 and count bullets-blue2 <= 10)
    [hatch 1[bullet-blue2-convert set ycor ycor + 2]]
  if (weapontype = 13 and count bullets-blue3 <= 10)
    [hatch 1[bullet-blue3-convert set ycor ycor + 2]]
  if (weapontype = 20)
    [let a1 one-of enemies with [btargetted? = false]
      if (a1 != nobody and count enemies with [btargetted? = true] = 0)
      [ask a1 [set btargetted? true]]
    hatch 1[bullet-violet0-convert set ycor ycor + 2]]
  if (weapontype = 21)
    [let a1 one-of enemies with [btargetted? = false]
      if (a1 != nobody and count enemies with [btargetted? = true] = 0)
      [ask a1 [set btargetted? true]]
    hatch 1[bullet-violet1-convert set ycor ycor + 2]]
  if (weapontype = 22)
    [let a1 one-of enemies with [btargetted? = false]
      if (a1 != nobody and count enemies with [btargetted? = true] = 0)
      [ask a1 [set btargetted? true]]
    hatch 1[bullet-violet2-convert set ycor ycor + 2]]
  if (weapontype = 23)
    [let a1 one-of enemies with [btargetted? = false]
      if (a1 != nobody and count enemies with [btargetted? = true] = 0)
      [ask a1 [set btargetted? true]]
    hatch 1[bullet-violet3-convert set ycor ycor + 2]]
  if (missiletype = 00 and missile-countdown <= 0)
    [set missile-countdown 5]
  if (missiletype = 10 and missile-countdown <= 0)
    [hatch 1[missile-normal-convert set ycor ycor + 2 set xcor xcor + .5]
    hatch 1[missile-normal-convert set ycor ycor + 2 set xcor xcor - .5]
    set missile-countdown 5]
  if (missiletype = 11 and missile-countdown <= 0)
    [hatch 1[missile-normal-convert set ycor ycor + 2 set xcor xcor + .5]
    hatch 1[missile-normal-convert set ycor ycor + 2 set xcor xcor - .5]
    hatch 1[missile-normal-convert set ycor ycor + 1.25 set xcor xcor + 1.25]
    hatch 1[missile-normal-convert set ycor ycor + 1.25 set xcor xcor - 1.25]
    set missile-countdown 5]
  if (missiletype = 12 and missile-countdown <= 0)
    [hatch 1[missile-normal-convert set ycor ycor + 2 set xcor xcor + .5]
    hatch 1[missile-normal-convert set ycor ycor + 2 set xcor xcor - .5]
    hatch 1[missile-normal-convert set ycor ycor + 1.25 set xcor xcor + 1.25]
    hatch 1[missile-normal-convert set ycor ycor + 1.25 set xcor xcor - 1.25]
    hatch 1[missile-normal-convert set ycor ycor + .5 set xcor xcor + 2.0]
    hatch 1[missile-normal-convert set ycor ycor + .5 set xcor xcor - 2.0]
    set missile-countdown 5]
  if (missiletype = 20 and missile-countdown <= 0)
    [let a1 one-of enemies with [mtargetted? = false]
      if (a1 != nobody and count enemies with [mtargetted? = true] = 0)
      [ask a1 [set mtargetted? true]]
    hatch 1[missile-homing-convert set heading 15 set ycor ycor + 1.5 set xcor xcor + 1]
    hatch 1[missile-homing-convert set heading -15 set ycor ycor + 1.5 set xcor xcor - 1]
    set missile-countdown 5]
  if (missiletype = 21 and missile-countdown <= 0)
    [let a1 one-of enemies with [mtargetted? = false]
      if (a1 != nobody and count enemies with [mtargetted? = true] = 0)
      [ask a1 [set mtargetted? true]]
    hatch 1[missile-homing-convert set heading 15 set ycor ycor + 1.5 set xcor xcor + 1]
    hatch 1[missile-homing-convert set heading -15 set ycor ycor + 1.5 set xcor xcor - 1]
    hatch 1[missile-homing-convert set heading 30 set ycor ycor + 1.5 set xcor xcor + 1.5]
    hatch 1[missile-homing-convert set heading -30 set ycor ycor + 1.5 set xcor xcor - 1.5]
    set missile-countdown 5]
  if (missiletype = 22 and missile-countdown <= 0)
    [let a1 one-of enemies with [mtargetted? = false]
      if (a1 != nobody and count enemies with [mtargetted? = true] = 0)
      [ask a1 [set mtargetted? true]]
    hatch 1[missile-homing-convert set heading 15 set ycor ycor + 1.5 set xcor xcor + 1]
    hatch 1[missile-homing-convert set heading -15 set ycor ycor + 1.5 set xcor xcor - 1]
    hatch 1[missile-homing-convert set heading 30 set ycor ycor + 1.5 set xcor xcor + 1.5]
    hatch 1[missile-homing-convert set heading -30 set ycor ycor + 1.5 set xcor xcor - 1.5]
    hatch 1[missile-homing-convert set heading 45 set ycor ycor + 1.5 set xcor xcor + 2]
    hatch 1[missile-homing-convert set heading -45 set ycor ycor + 1.5 set xcor xcor - 2]
    set missile-countdown 5]
    ]
end

to bullet-red-convert-single
set breed bullets-red1
set shape "bullets-red1"
set size 2
set grabbed? false
end
to bullet-red-convert-double
set breed bullets-red2
set shape "bullets-red2"
set size 2
set grabbed? false
end

to bullet-blue0-convert
set breed bullets-blue0
set shape "bullets-blue0"
set size 2
set grabbed? false
end
to bullet-blue1-convert
set breed bullets-blue1
set shape "bullets-blue1"
set size 2
set grabbed? false
end
to bullet-blue2-convert
set breed bullets-blue2
set shape "bullets-blue2"
set size 2
set grabbed? false
end
to bullet-blue3-convert
set breed bullets-blue3
set shape "bullets-blue3"
set size 3
set grabbed? false
end

to bullet-violet0-convert
set breed bullets-violet0
set shape "bullets-violet0"
set color violet + 2
set size 1.8
set grabbed? false
end
to bullet-violet1-convert
set breed bullets-violet1
set shape "bullets-violet0"
set color violet + 2
set size 2.1
set grabbed? false
end
to bullet-violet2-convert
set breed bullets-violet2
set shape "bullets-violet0"
set color violet + 2
set size 2.4
set grabbed? false
end
to bullet-violet3-convert
set breed bullets-violet3
set shape "bullets-violet0"
set color violet + 2
set size 2.7
set grabbed? false
end

to missile-normal-convert
set breed missiles-normal
set shape "missiles-normal"
set color gray - 3
set size 2
set grabbed? false
end

to missile-homing-convert
set breed missiles-homing
set shape "missiles-homing"
set color gray - 3
set size 1.5
set grabbed? false
end

to bullet-red-move
ask bullets-red2
  [fd 1.5
  if (ycor >= max-pycor - 0.5 or xcor >= max-pxcor - 0.5 or xcor <= min-pxcor + 0.5) [die]]
ask bullets-red1
  [fd 1.5
  if (ycor >= max-pycor - 0.5 or xcor >= max-pxcor - 0.5 or xcor <= min-pxcor + 0.5) [die]]
end

to bullet-blue-move
ask bullets-blue0
  [fd 2
  if (ycor >= max-pycor - 0.5 or xcor >= max-pxcor - 0.5 or xcor <= min-pxcor + 0.5) [die]]
ask bullets-blue1
  [fd 2
  if (ycor >= max-pycor - 0.5 or xcor >= max-pxcor - 0.5 or xcor <= min-pxcor + 0.5) [die]]
ask bullets-blue2
  [fd 2
  if (ycor >= max-pycor - 0.5 or xcor >= max-pxcor - 0.5 or xcor <= min-pxcor + 0.5) [die]]
ask bullets-blue3
  [fd 2
  if (ycor >= max-pycor - 0.5 or xcor >= max-pxcor - 0.5 or xcor <= min-pxcor + 0.5) [die]]
end

to missile-move
ask missiles-normal
  [fd 3
  if (ycor >= max-pycor - 0.5 or xcor >= max-pxcor - 0.5 or xcor <= min-pxcor + 0.5) [die]]
ask missiles-homing
  [if (count enemies with [mtargetted? = true] > 0)
      [face one-of enemies with [mtargetted? = true]]
      fd 1.5 if (ycor >= max-pycor - 0.5 or xcor >= max-pxcor - 0.5 or xcor <= min-pxcor + 0.5 or ycor <= min-pycor + 0.5)[die]
      if (count enemies with [mtargetted? = true] > 1)[ask enemies [set mtargetted? false]]]
end

to bullets-violet-move
ask bullets-violet0
  [if (count enemies with [btargetted? = true] > 0)
      [face one-of enemies with [btargetted? = true]]
      fd 1.5 if (ycor >= max-pycor - 0.5 or xcor >= max-pxcor - 0.5 or xcor <= min-pxcor + 0.5 or ycor <= min-pycor + 0.5)[die]
      if (count enemies with [btargetted? = true] > 1)[ask enemies [set btargetted? false]]]
ask bullets-violet1
  [if (count enemies with [btargetted? = true] > 0)
      [face one-of enemies with [btargetted? = true]]
      fd 1.75 if (ycor >= max-pycor - 0.5 or xcor >= max-pxcor - 0.5 or xcor <= min-pxcor + 0.5 or ycor <= min-pycor + 0.5)[die]
      if (count enemies with [btargetted? = true] > 1)[ask enemies [set btargetted? false]]]
ask bullets-violet2
  [if (count enemies with [btargetted? = true] > 0)
      [face one-of enemies with [btargetted? = true]]
      fd 2 if (ycor >= max-pycor - 0.5 or xcor >= max-pxcor - 0.5 or xcor <= min-pxcor + 0.5 or ycor <= min-pycor + 0.5)[die]
      if (count enemies with [btargetted? = true] > 1)[ask enemies [set btargetted? false]]]
ask bullets-violet3
  [if (count enemies with [btargetted? = true] > 0)
      [face one-of enemies with [btargetted? = true]]
      fd 2.25 if (ycor >= max-pycor - 0.5 or xcor >= max-pxcor - 0.5 or xcor <= min-pxcor + 0.5 or ycor <= min-pycor + 0.5)[die]
      if (count enemies with [btargetted? = true] > 1)[ask enemies [set btargetted? false]]]
end

to powerup-spawn
every 3[
ask patches with [pycor = max-pycor]
[if (random 100 < 1
and count powerups-weapon >= 2
and count powerups-missile >= 2
and count powerups-max >= 2)
  [ifelse (random 200 < 1)
    [sprout-powerups-max 1
    [powerup-max-convert]]
  [ifelse (random 100 < 60)
    [sprout-powerups-missile 1
    [powerup-missile-convert]]
    [sprout-powerups-weapon 1
    [powerup-weapon-convert]]]]]]
end

to powerup-weapon-convert
set grabbed? false
set size 1.5
set shape "powerup-weapon"
set color item random 3 [blue red violet]
end
to powerup-weapon-change
every 4
[ask powerups-weapon
  [if (color = violet)[set color red + 1]
  if (color = blue)[set color violet]
  if (color = red)[set color blue]
  if (color = red + 1)[set color red]
  ]]
end

to powerup-missile-convert
set grabbed? false
set size 1.5
set shape item random 2 ["powerup-missile-homing" "powerup-missile-normal"]
end
to powerup-missile-change
every 6
[ask powerups-missile
  [if (shape = "powerup-missile-homing")[set shape "truck"]
  if (shape = "powerup-missile-normal")[set shape "powerup-missile-homing"]
  if (shape = "truck")[set shape "powerup-missile-normal"]]]
end

to powerup-max-convert
set grabbed? false
set size 1.5
set shape "powerup-max"
set color blue
end
to powerup-max-change
every 0.1
[ask powerups-max
  [set color item random 2[blue white]]]
end

to colorchange
ask raidens
  [if (weapontype = 00 or weapontype = 01 or weapontype = 02 or weapontype = 03)
    [set color red]
  if (weapontype = 10 or weapontype = 11 or weapontype = 12 or weapontype = 13)
    [set color blue]
  if (weapontype = 20 or weapontype = 21 or weapontype = 22 or weapontype = 23)
    [set color violet]
  ]
end

to maxup
let p one-of powerups-max in-radius 2 with [grabbed? = false]
if (p != nobody)
   [if (weapontype = 00 or weapontype = 01 or weapontype = 02 or weapontype = 03)
     [ask p [set grabbed? true]
     set weapontype 03]]
if (p != nobody)
   [if (weapontype = 10 or weapontype = 11 or weapontype = 12 or weapontype = 13)
     [ask p [set grabbed? true]
     set weapontype 13]]
if (p != nobody)
   [if (weapontype = 20 or weapontype = 21 or weapontype = 22 or weapontype = 23)
     [ask p [set grabbed? true]
     set weapontype 23]]
let r one-of powerups-max in-radius 2 with [grabbed? = true]
if (r != nobody)
   [if (missiletype = 00)
     [ask r [set grabbed? false die]]]
if (r != nobody)
   [if (missiletype = 10 or missiletype = 11 or missiletype = 12)
     [ask r [set grabbed? false die]
     set missiletype 12]]
if (r != nobody)
   [if (missiletype = 20 or missiletype = 21 or missiletype = 22)
     [ask r [set grabbed? false die]
     set missiletype 22]]
end

to missileup
let p one-of powerups-missile in-radius 2 with [grabbed? = false]
if (p != nobody)
   [if (missiletype = 00 and [shape] of p = "powerup-missile-normal")
     [ask p [set grabbed? true die]
     set missiletype 10]]
if (p != nobody)
   [if (missiletype = 00 and [shape] of p = "powerup-missile-homing")
     [ask p [set grabbed? true die]
     set missiletype 20]]
if (p != nobody)
   [if (missiletype = 10 and [shape] of p = "powerup-missile-normal")
     [ask p [set grabbed? true die]
     set missiletype 11]]
if (p != nobody)
   [if (missiletype = 20 and [shape] of p = "powerup-missile-homing")
     [ask p [set grabbed? true die]
     set missiletype 21]]
if (p != nobody)
   [if (missiletype = 21 and [shape] of p = "powerup-missile-normal")
     [ask p [set grabbed? true die]
     set missiletype 11]]
if (p != nobody)
   [if (missiletype = 11 and [shape] of p = "powerup-missile-homing")
     [ask p [set grabbed? true die]
     set missiletype 21]]
if (p != nobody)
   [if (missiletype = 11 and [shape] of p = "powerup-missile-normal")
     [ask p [set grabbed? true die]
     set missiletype 12]]
if (p != nobody)
   [if (missiletype = 21 and [shape] of p = "powerup-missile-homing")
     [ask p [set grabbed? true die]
     set missiletype 22]]
if (p != nobody)
   [if (missiletype = 22 and [shape] of p = "powerup-missile-normal")
     [ask p [set grabbed? true die]
     set missiletype 12]]
if (p != nobody)
   [if (missiletype = 12 and [shape] of p = "powerup-missile-homing")
     [ask p [set grabbed? true die]
     set missiletype 22]]
if (p != nobody)
   [if (missiletype = 12 and [shape] of p = "powerup-missile-normal")
     [ask p [set grabbed? true die]
     set score score + 100]]
if (p != nobody)
   [if (missiletype = 22 and [shape] of p = "powerup-missile-homing")
     [ask p [set grabbed? true die]
     set score score + 100]]
end

to weaponup
let p one-of powerups-weapon in-radius 2 with [grabbed? = false]
if (p != nobody)
   [if (weapontype = 00 or weapontype = 20 and [color] of p = blue)
     [ask p [set grabbed? true die]
     set weapontype 10]]
if (p != nobody)
   [if (weapontype = 00 or weapontype = 10 and [color] of p = violet)
     [ask p [set grabbed? true die]
     set weapontype 20]]
if (p != nobody)
   [if (weapontype = 10 or weapontype = 20 and [color] of p = red)
     [ask p [set grabbed? true die]
     set weapontype 00]]
if (p != nobody)
   [if (weapontype = 00 and [color] of p = red)
     [ask p [set grabbed? true die]
     set weapontype 01]]
if (p != nobody)
   [if (weapontype = 10 and [color] of p = blue)
     [ask p [set grabbed? true die]
     set weapontype 11]]
if (p != nobody)
   [if (weapontype = 20 and [color] of p = violet)
     [ask p [set grabbed? true die]
     set weapontype 21]]
if (p != nobody)
   [if (weapontype = 01 or weapontype = 21 and [color] of p = blue)
     [ask p [set grabbed? true die]
     set weapontype 11]]
if (p != nobody)
   [if (weapontype = 01 or weapontype = 11 and [color] of p = violet)
     [ask p [set grabbed? true die]
     set weapontype 21]]
if (p != nobody)
   [if (weapontype = 11 or weapontype = 21 and [color] of p = red)
     [ask p [set grabbed? true die]
     set weapontype 01]]
if (p != nobody)
   [if (weapontype = 01 and [color] of p = red)
     [ask p [set grabbed? true die]
     set weapontype 02]]
if (p != nobody)
   [if (weapontype = 11 and [color] of p = blue)
     [ask p [set grabbed? true die]
     set weapontype 12]]
if (p != nobody)
   [if (weapontype = 21 and [color] of p = violet)
     [ask p [set grabbed? true die]
     set weapontype 22]]
if (p != nobody)
   [if (weapontype = 02 or weapontype = 22 and [color] of p = blue)
     [ask p [set grabbed? true die]
     set weapontype 12]]
if (p != nobody)
   [if (weapontype = 02 or weapontype = 12 and [color] of p = violet)
     [ask p [set grabbed? true die]
     set weapontype 22]]
if (p != nobody)
   [if (weapontype = 12 or weapontype = 22 and [color] of p = red)
     [ask p [set grabbed? true die]
     set weapontype 02]]
if (p != nobody)
   [if (weapontype = 02 and [color] of p = red)
     [ask p [set grabbed? true die]
     set weapontype 03]]
if (p != nobody)
   [if (weapontype = 12 and [color] of p = blue)
     [ask p [set grabbed? true die]
     set weapontype 13]]
if (p != nobody)
   [if (weapontype = 22 and [color] of p = violet)
     [ask p [set grabbed? true die]
     set weapontype 23]]
if (p != nobody)
   [if (weapontype = 03 or weapontype = 23 and [color] of p = blue)
     [ask p [set grabbed? true die]
     set weapontype 13]]
if (p != nobody)
   [if (weapontype = 03 or weapontype = 13 and [color] of p = violet)
     [ask p [set grabbed? true die]
     set weapontype 23]]
if (p != nobody)
   [if (weapontype = 13 or weapontype = 23 and [color] of p = red)
     [ask p [set grabbed? true die]
     set weapontype 03]]
if (p != nobody)
   [if (weapontype = 03 and [color] of p = red)
     [ask p [set grabbed? true die]
     set score score + 100]]
if (p != nobody)
   [if (weapontype = 13 and [color] of p = blue)
     [ask p [set grabbed? true die]
     set score score + 100]]
if (p != nobody)
   [if (weapontype = 23 and [color] of p = violet)
     [ask p [set grabbed? true die]
     set score score + 100]]
end

to do-damage
ask enemies with [size = 1.5]
[let a2 one-of bullets-red2 in-radius .75 with [grabbed? = false]
let a1 one-of bullets-red1 in-radius .75 with [grabbed? = false]
let b0 one-of bullets-blue0 in-radius .75 with [grabbed? = false]
let b1 one-of bullets-blue1 in-radius .75 with [grabbed? = false]
let b2 one-of bullets-blue2 in-radius .75 with [grabbed? = false]
let b3 one-of bullets-blue3 in-radius 1.25 with [grabbed? = false]
let v0 one-of bullets-violet0 in-radius .75 with [grabbed? = false]
let v1 one-of bullets-violet1 in-radius .75 with [grabbed? = false]
let v2 one-of bullets-violet2 in-radius .75 with [grabbed? = false]
let v3 one-of bullets-violet3 in-radius .75 with [grabbed? = false]
let n0 one-of missiles-normal in-radius 1 with [grabbed? = false]
let h0 one-of missiles-homing in-radius .75 with [grabbed? = false]
  if (a1 != nobody) [ask a1 [set grabbed? true hit-red1 die]set health health - 1]
  if (a2 != nobody) [ask a2 [set grabbed? true hit-red2 die]set health health - 2]
  if (b0 != nobody) [ask b0 [set grabbed? true hit-blue0 die]set health health - 3]
  if (b1 != nobody) [ask b1 [set grabbed? true hit-blue1 die]set health health - 6]
  if (b2 != nobody) [ask b2 [set grabbed? true hit-blue2 die]set health health - 9]
  if (b3 != nobody) [ask b3 [set grabbed? true hit-blue3 die]set health health - 12]
  if (v0 != nobody) [ask v0 [set grabbed? true die]set health health - .75]
  if (v1 != nobody) [ask v1 [set grabbed? true die]set health health - 1.5]
  if (v2 != nobody) [ask v2 [set grabbed? true die]set health health - 2.25]
  if (v3 != nobody) [ask v3 [set grabbed? true die]set health health - 3]
  if (n0 != nobody) [ask n0 [set grabbed? true explode 2]set health health - 3]
  if (h0 != nobody) [ask h0 [set grabbed? true explode 1.5]set health health - 1.5]
  ]
ask enemies with [size = 3]
[let a2 one-of bullets-red2 in-radius 1.5 with [grabbed? = false]
let a1 one-of bullets-red1 in-radius 1.5 with [grabbed? = false]
let b0 one-of bullets-blue0 in-radius 1.5 with [grabbed? = false]
let b1 one-of bullets-blue1 in-radius 1.5 with [grabbed? = false]
let b2 one-of bullets-blue2 in-radius 1.5 with [grabbed? = false]
let b3 one-of bullets-blue3 in-radius 2.5 with [grabbed? = false]
let v0 one-of bullets-violet0 in-radius 1.5 with [grabbed? = false]
let v1 one-of bullets-violet1 in-radius 1.5 with [grabbed? = false]
let v2 one-of bullets-violet2 in-radius 1.5 with [grabbed? = false]
let v3 one-of bullets-violet3 in-radius 1.5 with [grabbed? = false]
let n0 one-of missiles-normal in-radius 2 with [grabbed? = false]
let h0 one-of missiles-homing in-radius 1.5 with [grabbed? = false]
  if (a1 != nobody) [ask a1 [set grabbed? true hit-red1 die]set health health - 1]
  if (a2 != nobody) [ask a2 [set grabbed? true hit-red2 die]set health health - 2]
  if (b0 != nobody) [ask b0 [set grabbed? true hit-blue0 die]set health health - 3]
  if (b1 != nobody) [ask b1 [set grabbed? true hit-blue1 die]set health health - 6]
  if (b2 != nobody) [ask b2 [set grabbed? true hit-blue2 die]set health health - 9]
  if (b3 != nobody) [ask b3 [set grabbed? true hit-blue3 die]set health health - 12]
  if (v0 != nobody) [ask v0 [set grabbed? true die]set health health - .75]
  if (v1 != nobody) [ask v1 [set grabbed? true die]set health health - 1.5]
  if (v2 != nobody) [ask v2 [set grabbed? true die]set health health - 2.25]
  if (v3 != nobody) [ask v3 [set grabbed? true die]set health health - 3]
  if (n0 != nobody) [ask n0 [set grabbed? true explode 2]set health health - 3]
  if (h0 != nobody) [ask h0 [set grabbed? true explode 1.5]set health health - 1.5]
  ]
ask enemies with [size = 5]
[let a2 one-of bullets-red2 in-radius 2.5 with [grabbed? = false]
let a1 one-of bullets-red1 in-radius 2.5 with [grabbed? = false]
let b0 one-of bullets-blue0 in-radius 2.5 with [grabbed? = false]
let b1 one-of bullets-blue1 in-radius 2.5 with [grabbed? = false]
let b2 one-of bullets-blue2 in-radius 2.5 with [grabbed? = false]
let b3 one-of bullets-blue3 in-radius 3.5 with [grabbed? = false]
let v0 one-of bullets-violet0 in-radius 2.5 with [grabbed? = false]
let v1 one-of bullets-violet1 in-radius 2.5 with [grabbed? = false]
let v2 one-of bullets-violet2 in-radius 2.5 with [grabbed? = false]
let v3 one-of bullets-violet3 in-radius 2.5 with [grabbed? = false]
let n0 one-of missiles-normal in-radius 3 with [grabbed? = false]
let h0 one-of missiles-homing in-radius 2.5 with [grabbed? = false]
  if (a1 != nobody) [ask a1 [set grabbed? true hit-red1 die]set health health - 1]
  if (a2 != nobody) [ask a2 [set grabbed? true hit-red2 die]set health health - 2]
  if (b0 != nobody) [ask b0 [set grabbed? true hit-blue0 die]set health health - 3]
  if (b1 != nobody) [ask b1 [set grabbed? true hit-blue1 die]set health health - 6]
  if (b2 != nobody) [ask b2 [set grabbed? true hit-blue2 die]set health health - 9]
  if (b3 != nobody) [ask b3 [set grabbed? true hit-blue3 die]set health health - 12]
  if (v0 != nobody) [ask v0 [set grabbed? true die]set health health - .75]
  if (v1 != nobody) [ask v1 [set grabbed? true die]set health health - 1.5]
  if (v2 != nobody) [ask v2 [set grabbed? true die]set health health - 2.25]
  if (v3 != nobody) [ask v3 [set grabbed? true die]set health health - 3]
  if (n0 != nobody) [ask n0 [set grabbed? true explode 2]set health health - 3]
  if (h0 != nobody) [ask h0 [set grabbed? true explode 1.5]set health health - 1.5]
  ]
ask enemies with [size = 18]
[let a2 one-of bullets-red2 in-radius 4 with [grabbed? = false]
let a1 one-of bullets-red1 in-radius 4 with [grabbed? = false]
let b0 one-of bullets-blue0 in-radius 4 with [grabbed? = false]
let b1 one-of bullets-blue1 in-radius 4 with [grabbed? = false]
let b2 one-of bullets-blue2 in-radius 4 with [grabbed? = false]
let b3 one-of bullets-blue3 in-radius 4 with [grabbed? = false]
let v0 one-of bullets-violet0 in-radius 4 with [grabbed? = false]
let v1 one-of bullets-violet1 in-radius 4 with [grabbed? = false]
let v2 one-of bullets-violet2 in-radius 4 with [grabbed? = false]
let v3 one-of bullets-violet3 in-radius 4 with [grabbed? = false]
let n0 one-of missiles-normal in-radius 4 with [grabbed? = false]
let h0 one-of missiles-homing in-radius 4 with [grabbed? = false]
  if (a1 != nobody) [ask a1 [set grabbed? true hit-red1 die]set health health - 1]
  if (a2 != nobody) [ask a2 [set grabbed? true hit-red2 die]set health health - 2]
  if (b0 != nobody) [ask b0 [set grabbed? true hit-blue0 die]set health health - 3]
  if (b1 != nobody) [ask b1 [set grabbed? true hit-blue1 die]set health health - 6]
  if (b2 != nobody) [ask b2 [set grabbed? true hit-blue2 die]set health health - 9]
  if (b3 != nobody) [ask b3 [set grabbed? true hit-blue3 die]set health health - 12]
  if (v0 != nobody) [ask v0 [set grabbed? true die]set health health - .75]
  if (v1 != nobody) [ask v1 [set grabbed? true die]set health health - 1.5]
  if (v2 != nobody) [ask v2 [set grabbed? true die]set health health - 2.25]
  if (v3 != nobody) [ask v3 [set grabbed? true die]set health health - 3]
  if (n0 != nobody) [ask n0 [set grabbed? true explode 2]set health health - 3]
  if (h0 != nobody) [ask h0 [set grabbed? true explode 1.5]set health health - 1.5]
  ]
ask enemies with [size = 20]
[let a2 one-of bullets-red2 in-radius 8 with [grabbed? = false]
let a1 one-of bullets-red1 in-radius 8 with [grabbed? = false]
let b0 one-of bullets-blue0 in-radius 8 with [grabbed? = false]
let b1 one-of bullets-blue1 in-radius 8 with [grabbed? = false]
let b2 one-of bullets-blue2 in-radius 8 with [grabbed? = false]
let b3 one-of bullets-blue3 in-radius 9.5 with [grabbed? = false]
let v0 one-of bullets-violet0 in-radius 8 with [grabbed? = false]
let v1 one-of bullets-violet1 in-radius 8 with [grabbed? = false]
let v2 one-of bullets-violet2 in-radius 8 with [grabbed? = false]
let v3 one-of bullets-violet3 in-radius 8 with [grabbed? = false]
let n0 one-of missiles-normal in-radius 8.5 with [grabbed? = false]
let h0 one-of missiles-homing in-radius 8 with [grabbed? = false]
  if (a1 != nobody) [ask a1 [set grabbed? true hit-red1 die]set health health - 1]
  if (a2 != nobody) [ask a2 [set grabbed? true hit-red2 die]set health health - 2]
  if (b0 != nobody) [ask b0 [set grabbed? true hit-blue0 die]set health health - 3]
  if (b1 != nobody) [ask b1 [set grabbed? true hit-blue1 die]set health health - 6]
  if (b2 != nobody) [ask b2 [set grabbed? true hit-blue2 die]set health health - 9]
  if (b3 != nobody) [ask b3 [set grabbed? true hit-blue3 die]set health health - 12]
  if (v0 != nobody) [ask v0 [set grabbed? true die]set health health - .75]
  if (v1 != nobody) [ask v1 [set grabbed? true die]set health health - 1.5]
  if (v2 != nobody) [ask v2 [set grabbed? true die]set health health - 2.25]
  if (v3 != nobody) [ask v3 [set grabbed? true die]set health health - 3]
  if (n0 != nobody) [ask n0 [set grabbed? true explode 2]set health health - 3]
  if (h0 != nobody) [ask h0 [set grabbed? true explode 1.5]set health health - 1.5]
  ]
end

to kill-enemy
ask enemies with [shape = "turtle"][if (health <= 0)
   [set score score + ((rlives * 10) + 1000 + floor (-5 * (-105 - lvl-countdown)))
   set difficulty 2 set lvl-countdown 103 explode 20]]
ask enemies with [shape = "boss2"][if (health <= 0)
   [set score score + ((rlives * 20) + 2000 + floor (-5 * (-105 - lvl-countdown)))
   set difficulty 3 set lvl-countdown 103 explode 5]]
ask enemies with [size = 18][if (health <= 0)
   [set score score + ((rlives * 30) + 3000 + floor (-5 * (-105 - lvl-countdown)))
   set difficulty 4 set lvl-countdown 0 explode 18]]
ask enemies with [shape = "enemy-boss-raiden"][if (health <= 0)
   [set score score + ((rlives * 50) + 5000 + floor (-5 * (-105 - lvl-countdown)))
   set difficulty 5 set lvl-countdown 0 explode 3]]
ask enemies with [shape = "enemy-fang"][if (health <= 0)[set score score + 10 explode 3]]
ask enemies with [shape = "enemy-assaultship"][if (health <= 0)
   [if (random 100 < 60)
   [hatch-powerups-weapon 1 [powerup-weapon-convert]] set score score + 50 explode 4]]
ask enemies with [shape = "enemy-bomber"][if (health <= 0)
   [if (random 100 < 40) [hatch-powerups-missile 1 [powerup-missile-convert]] set score score + 60 explode 4]]
ask enemies with [shape = "enemy-fighter1"][if (health <= 0)[set score score + 30 explode 3]]
ask enemies with [shape = "enemy-suicidal"][if (health <= 0)[set score score + 30 explode 3]]
ask enemies with [shape = "enemy-suicidal2"][if (health <= 0)
   [if (one-of raidens != nobody)
   [hatch 1 [enemy-pellet-yellow-convert face one-of raidens set xcor xcor + .5]]
   hatch 1 [enemy-pellet-yellow-convert face one-of raidens set xcor xcor - .5]
   set score score + 40 explode 3]]
ask enemies with [shape = "asteriod1" or shape = "asteriod2" or shape = "asteriod3"]
  [if (health <= 0)[set score score + 20 explode 3]]
ask enemies with [shape = "enemy-missile-homing"][if (health <= 0)[set score score + 1 explode 1.5]]
end

to spawn-enemy [x]
every 0.5[
ask patches with [pycor = max-pycor and pxcor < (max-pxcor - 1) and pxcor > (min-pxcor + 1)]
[if (random 100 < x)[sprout-enemies 1
  [set shape item random 3 ["asteriod1" "asteriod2" "asteriod3"]
  set color gray + 2
  set size 3
  set health (2 * (difficulty + 3))
  set btargetted? false
  set mtargetted? false
  set grabbed? false]]]
]
end

to enemy-move
ask enemies with [shape = "asteriod1" or shape = "asteriod2" or shape = "asteriod3"]
  [rt 5 set ycor ycor - .3
  if (ycor <= min-pycor + 1) [die]]
end

to spawn-enemy-fighter [x]
every 0.5[
ask patches with [pycor = max-pycor and pxcor < (max-pxcor - 1) and pxcor > (min-pxcor + 1)]
[if (random 100 < x and count enemies with [shape = "enemy-fighter1"] < 6)[sprout-enemies 1
  [set shape "enemy-fighter1"
  set color brown + 1
  set size 3
  set health 4
  set btargetted? false
  set mtargetted? false
  set grabbed? false
  set fired? false]]]
]
end

to enemy-fighter-move
ask enemies with [shape = "enemy-fighter1" and fired? = true]
  [set heading 0 fd ((difficulty + 7) * .1)
  if (ycor >= max-pycor - 0.5 or xcor >= max-pxcor - 0.5 or xcor <= min-pxcor + 0.5) [die]]
ask enemies with [shape = "enemy-fighter1" and fired? = false]
  [set heading 180 fd ((difficulty + 7) * .1)
  if (one-of raidens != nobody)
  [if (distance one-of raidens <= 10 or ycor < (0 + min-pycor) / 4)
  [face one-of raidens
  hatch 1 [enemy-pellet-yellow-convert]
  set fired? true fd 1]]
  ]
end

to spawn-enemy-assaultship [x]
every 3[
ask patches with [pycor = max-pycor and pxcor < (max-pxcor - 1) and pxcor > (min-pxcor + 1)]
[if (random 100 < x and count enemies with [shape = "enemy-assaultship"] < difficulty)[sprout-enemies 1
  [set shape "enemy-assaultship"
  set color brown - 2
  set size 5
  set health 30
  set btargetted? false
  set mtargetted? false
  set grabbed? false
  set fired? false]]]
]
end

to enemy-assaultship-move
ask enemies with [shape = "enemy-assaultship" and cooldown > 0 and fired? = true]
  [set cooldown cooldown - 1]
ask enemies with [shape = "enemy-assaultship" and cooldown <= 0 and fired? = true]
  [if (one-of raidens != nobody)
  [face one-of raidens
  hatch 1 [enemy-pellet-yellow-convert]
  hatch 1 [rt 30 enemy-pellet-yellow-convert]
  hatch 1 [lt 30 enemy-pellet-yellow-convert]
  set cooldown 40]]
ask enemies with [shape = "enemy-assaultship" and fired? = false]
  [set heading 180 fd .5
  if (one-of raidens != nobody)
  [if (ycor <= (([ycor] of one-of raidens) + 10) or ycor <= (0 + max-pycor) / 4)
  [hatch 1 [enemy-pellet-yellow-convert]
  hatch 1 [rt 30 enemy-pellet-yellow-convert]
  hatch 1 [lt 30 enemy-pellet-yellow-convert]
  set fired? true set cooldown 40]]
  ]
end


to spawn-enemy-bomber [x]
every 3[
ask patches with [pycor = max-pycor and pxcor < (max-pxcor - 1) and pxcor > (min-pxcor + 1)]
[if (random 100 < x and count enemies with [shape = "enemy-bomber"] < 1)[sprout-enemies 1
  [set shape "enemy-bomber"
  set color gray - 2
  set size 5
  set health 30
  set btargetted? false
  set mtargetted? false
  set grabbed? false
  set fired? false]]]
]
end

to enemy-bomber-move
ask enemies with [shape = "enemy-bomber"]
  [set heading 180 fd .8
  if (ycor <= min-pycor + 0.5 or xcor >= max-pxcor - 0.5 or xcor <= min-pxcor + 0.5) [die]]
ask enemies with [shape = "enemy-bomber"
and ycor <= ((0 + max-pycor) / 4) and ycor >= ((0 + min-pycor) / 4)]
  [if (one-of raidens != nobody)
  [hatch 1 [enemy-pellet-green-convert set xcor xcor + 2 face one-of raidens]
  hatch 1 [enemy-pellet-green-convert set xcor xcor - 2 face one-of raidens]]]
end

to spawn-enemy-suicidal [x]
every 3[
ask patches with [pycor = max-pycor and pxcor < (max-pxcor - 1) and pxcor > (min-pxcor + 1)]
[if (random 100 < x and count enemies with [shape = "enemy-suicidal"] < 3)[sprout-enemies 1
  [set shape "enemy-suicidal"
  set color gray - 2
  set size 3
  set health 2
  set btargetted? false
  set mtargetted? false
  set grabbed? false
  set fired? false]]]
]
end

to enemy-suicidal-move
ask enemies with [shape = "enemy-suicidal" and tracking-countdown <= 0 and fired? = false]
  [set heading 180 fd 1
  if (ycor <= min-pycor + 0.5 or xcor >= max-pxcor - 0.5 or xcor <= min-pxcor + 0.5) [die]]
ask enemies with [shape = "enemy-suicidal" and ycor <= ((0 + max-pycor) / 4) and fired? = false]
  [set tracking-countdown 5 set fired? true]
ask enemies with [shape = "enemy-suicidal" and tracking-countdown > 0 and fired? = true]
  [set tracking-countdown tracking-countdown - 1
  if (one-of raidens != nobody)
  [face one-of raidens fd 1.5]]
ask enemies with [shape = "enemy-suicidal" and tracking-countdown <= 0 and fired? = true]
  [fd 1.5 if (ycor <= min-pycor + 0.5 or xcor >= max-pxcor - 0.5 or xcor <= min-pxcor + 0.5) [die]]
end

to spawn-enemy-suicidal2 [x]
every 3[
ask patches with [pycor = max-pycor and pxcor < (max-pxcor - 1) and pxcor > (min-pxcor + 1)]
[if (random 100 < x and count enemies with [shape = "enemy-suicidal2"] < 3)[sprout-enemies 1
  [set shape "enemy-suicidal2"
  set color gray - 2
  set size 3
  set health 4
  set btargetted? false
  set mtargetted? false
  set grabbed? false
  set fired? false]]]
]
end

to enemy-suicidal2-move
ask enemies with [shape = "enemy-suicidal2" and tracking-countdown <= 0 and fired? = false]
  [set heading 180 fd 1
  if (ycor <= min-pycor + 0.5 or xcor >= max-pxcor - 0.5 or xcor <= min-pxcor + 0.5) [die]]
ask enemies with [shape = "enemy-suicidal2" and ycor <= ((0 + max-pycor) / 4) and fired? = false]
  [set tracking-countdown 5 set fired? true]
ask enemies with [shape = "enemy-suicidal2" and tracking-countdown > 0 and fired? = true]
  [set tracking-countdown tracking-countdown - 1
  if (one-of raidens != nobody)
  [face one-of raidens fd 1.5]]
ask enemies with [shape = "enemy-suicidal2" and tracking-countdown <= 0 and fired? = true]
  [fd 1.5 if (ycor <= min-pycor + 0.5 or xcor >= max-pxcor - 0.5 or xcor <= min-pxcor + 0.5) [die]]
end

to spawn-boss-turtle
ask patches with [pycor = max-pycor and pxcor = 0]
[sprout-enemies 1
  [set heading 180
  set shape "turtle"
  set color gray
  set size 20
  set health 400
  set btargetted? false
  set mtargetted? false
  set grabbed? false
  set fired? false]]
end

to boss-turtle-move
ask enemies with [shape = "turtle" and pycor != 0]
[fd 1]
ask enemies with [shape = "turtle" and pycor = 0]
[if (one-of raidens != nobody)[face one-of raidens
hatch 1 [enemy-pellet-yellow-convert]
hatch 1 [enemy-pellet-yellow-convert fd 1 rt 72]
hatch 1 [enemy-pellet-yellow-convert rt 144]
hatch 1 [enemy-pellet-yellow-convert lt 144]
hatch 1 [enemy-pellet-yellow-convert fd 1 lt 72]
set grabbed? false]]
end

to spawn-boss-UFO
ask patches with [pycor = max-pycor and pxcor = 0]
[sprout-enemies 1
  [set heading 180
  set shape "boss2"
  set color gray
  set size 5
  set health 400
  set btargetted? false
  set mtargetted? false
  set grabbed? false
  set fired? false
  set cooldown 20]]
end

to boss-UFO-move
ask enemies with [shape = "boss2"]
[
if (xcor > (max-pxcor - 3))[set heading 270 fd .5]
if (ycor > (max-pycor - 3))[set heading 180 fd .5]
if (xcor < (min-pxcor + 3))[set heading 90 fd .5]
if (ycor < (min-pycor + 3))[set heading 0 fd .5]
if (xcor <= (max-pxcor - 3) and xcor >= (min-pxcor + 3)
      and ycor <= (max-pycor - 3) and ycor >= (min-pycor + 3))
[rt random 45 - random 45
fd 1 set cooldown cooldown - 1]]
ask enemies with [shape = "boss2" and cooldown <= 5 and cooldown > 0]
[if (one-of raidens != nobody)
[hatch 1 [enemy-pellet-green-convert face one-of raidens]]]
ask enemies with [shape = "boss2" and cooldown <= 0]
[set cooldown 20]
end

to spawn-boss-alvatorre
ask patches with [pycor = max-pycor and pxcor = 0]
[sprout-enemies 1
  [set heading 180
  set shape "alvatorre"
  set color yellow - 1
  set size 18
  set health 1000
  set btargetted? false
  set mtargetted? false
  set grabbed? false
  set fired? false
  set cooldown 35]]
end

to boss-alvatorre-move
ask enemies with [size = 18 and pycor != ceiling(max-pycor * .75)]
  [fd 1]
ask enemies with [size = 18 and pycor = ceiling(max-pycor * .75)]
  [set cooldown cooldown - 0.5 set grabbed? false]
every 0.3[
ask enemies with [size = 18 and pycor = ceiling(max-pycor * .75) and cooldown > 10 and fired? = false]
  [hatch 3 [enemy-bullet-gold-convert set ycor ycor - 1 set xcor xcor + (5 + random 10) set heading (170 + random 21)]
  hatch 3 [enemy-bullet-gold-convert set ycor ycor - 1 set xcor xcor - (5 + random 10) set heading (170 + random 21)]
  ]]
ask enemies with [size = 18 and pycor = ceiling(max-pycor * .75)
  and cooldown <= 14 and fired? = false]
    [laser-charge]
ask enemies with [size = 18 and fired? = true]
  [laser-fire hatch 1 [enemy-laser-gold-convert]]
ask enemies with [size = 18 and fired? = true and cooldown < 5]
  [if (count enemies with [shape = "enemy-fang"] = 0)
    [set fired? false set cooldown 40 set shape "alvatorre"]]
ask enemies with [size = 18 and fired? = true and cooldown <= 7
  and count enemies with [shape = "enemy-fang"] < 1]
  [hatch 6 [enemy-fang-convert set ycor ycor + 3]]
end

to laser-fire
ask enemies with [shape = "alvatorre-charge8.7"]
  [set shape "alvatorre-charge9"]
ask enemies with [shape = "alvatorre-charge8.6"]
  [set shape "alvatorre-charge8.7"]
ask enemies with [shape = "alvatorre-charge8.5"]
  [set shape "alvatorre-charge8.6"]
ask enemies with [shape = "alvatorre-charge8.2"]
  [set shape "alvatorre-charge8.5"]
ask enemies with [shape = "alvatorre-charge8.1"]
  [set shape "alvatorre-charge8.2"]
ask enemies with [shape = "alvatorre-charge8"]
  [set shape "alvatorre-charge8.1"]
end

to laser-charge
ask enemies with [shape = "alvatorre-charge8"]
  [set fired? true]
ask enemies with [shape = "alvatorre-charge7.5"]
  [set shape "alvatorre-charge8"]
ask enemies with [shape = "alvatorre-charge7"]
  [set shape "alvatorre-charge7.5"]
ask enemies with [shape = "alvatorre-charge6.5"]
  [set shape "alvatorre-charge7"]
ask enemies with [shape = "alvatorre-charge6"]
  [set shape "alvatorre-charge6.5"]
ask enemies with [shape = "alvatorre-charge5"]
  [set shape "alvatorre-charge6"]
ask enemies with [shape = "alvatorre-charge4.5"]
  [set shape "alvatorre-charge5"]
ask enemies with [shape = "alvatorre-charge4"]
  [set shape "alvatorre-charge4.5"]
ask enemies with [shape = "alvatorre-charge3.5"]
  [set shape "alvatorre-charge4"]
ask enemies with [shape = "alvatorre-charge3"]
  [set shape "alvatorre-charge3.5"]
ask enemies with [shape = "alvatorre-charge2"]
  [set shape "alvatorre-charge3"]
ask enemies with [shape = "alvatorre-charge1.5"]
  [set shape "alvatorre-charge2"]
ask enemies with [shape = "alvatorre-charge1"]
  [set shape "alvatorre-charge1.5"]
ask enemies with [shape = "alvatorre-charge0.5"]
  [set shape "alvatorre-charge1"]
ask enemies with [shape = "alvatorre-charge0"]
  [set shape "alvatorre-charge0.5"]
ask enemies with [shape = "alvatorre"]
  [set shape "alvatorre-charge0"]
end

to enemy-fang-convert
set breed enemies
set shape "enemy-fang"
set health 4
set size 3
set color orange - 2
set grabbed? false
set fired? false
end

to enemy-fang-move
ask enemies with [shape = "enemy-fang" and fired? = false]
[
if (xcor > (max-pxcor - 3))[set heading 270 fd .5]
if (ycor > (max-pycor - 3))[set heading 180 fd .5]
if (xcor < (min-pxcor + 3))[set heading 90 fd .5]
if (ycor < (min-pycor + 3))[set heading 0 fd .5]
if (xcor <= (max-pxcor - 3) and xcor >= (min-pxcor + 3)
      and ycor <= (max-pycor - 3) and ycor >= (min-pycor + 3))
[rt random 45 - random 45
fd 1]
  if (one-of raidens != nobody)
  [if (distance one-of raidens <= 15)
  [face one-of raidens
  hatch 1 [enemy-pellet-yellow-convert]
  set fired? true]]
  ]
ask enemies with [shape = "enemy-fang" and fired? = true]
  [if (one-of enemies with [size = 18] != nobody)
  [face one-of enemies with [size = 18]
    fd ((distance (one-of enemies with [size = 18])) / 5)
  if (distance (one-of enemies with [size = 18]) < 1)[set fired? false]]]
end

to spawn-boss-raiden
ask patches with [pycor = max-pycor and pxcor = 0]
[sprout-enemies 1
  [set heading 180
  set shape "enemy-boss-raiden"
  set color yellow - 2
  set size 3
  set health 500
  set btargetted? false
  set mtargetted? false
  set grabbed? false
  set fired? false
  set cooldown 25
  set left? false
  set weapontype 2]]
end

to boss-raiden-move
ask enemies with [shape = "enemy-boss-raiden" and pycor != ceiling(max-pycor * .75)]
  [fd 1]
ask enemies with [shape = "enemy-boss-raiden" and pycor = ceiling(max-pycor * .75)]
  [set cooldown cooldown - 1 set grabbed? false]
ask enemies with [shape = "enemy-boss-raiden" and pycor = ceiling(max-pycor * .75) and left? = false]
  [set xcor xcor + 1
  if (xcor > (max-pxcor - 2))
    [set left? true]
  ]
ask enemies with [shape = "enemy-boss-raiden" and pycor = ceiling(max-pycor * .75) and left? = true]
  [set xcor xcor - 1
  if (xcor < (min-pxcor + 2))
    [set left? false]
  ]
ask enemies with [shape = "enemy-boss-raiden" and cooldown = 10]
  [ifelse (random 3 < 1)
    [set weapontype 0]
    [ifelse (random 2 < 1)
      [set weapontype 1]
      [set weapontype 2]
  ]]
ask enemies with [shape = "enemy-boss-raiden" and cooldown <= 10 and weapontype = 0]
  [hatch 1[enemy-laser-gold-convert2]]
ask enemies with [shape = "enemy-boss-raiden" and cooldown <= 10 and weapontype = 1]
  [hatch 1[enemy-bullet-gold-convert2 set xcor xcor - .5]
   hatch 1[enemy-bullet-gold-convert2 set xcor xcor + .5]
   hatch 1[enemy-bullet-gold-convert2 rt 30 set xcor xcor - 1]
   hatch 1[enemy-bullet-gold-convert2 lt 30 set xcor xcor + 1]
   hatch 1[enemy-bullet-gold-convert2 rt 60 set xcor xcor - 1.5]
   hatch 1[enemy-bullet-gold-convert2 lt 60 set xcor xcor + 1.5]]
ask enemies with [shape = "enemy-boss-raiden" and cooldown <= 10 and weapontype = 2]
  [hatch 1[enemy-homing-convert] set cooldown cooldown - 1]
ask enemies with [shape = "enemy-boss-raiden" and cooldown <= 0]
  [set cooldown 25]
end

to enemy-homing-convert
set shape "enemy-missile-homing"
set color gray - 2
set size 1.5
set health 2
set btargetted? false
set mtargetted? false
set grabbed? false
end

to enemy-homing-move
ask enemies with [shape = "enemy-missile-homing"]
  [if (one-of raidens != nobody)
  [face one-of raidens fd .75]
  if (ycor <= min-pycor + 0.5 or xcor >= max-pxcor - 0.5 or xcor <= min-pxcor + 0.5) [die]]
end

to enemy-pellet-yellow-convert
set breed enemy-pellets-yellow
set shape "enemy-pellet-yellow"
set size 2
set color yellow
set grabbed? false
end

to enemy-pellet-green-convert
set breed enemy-pellets-green
set shape "enemy-pellet-green"
set size 2
set color green + 2
set grabbed? false
end

to enemy-bullet-gold-convert
set breed enemy-bullets-gold
set shape "enemy-bullets-gold"
set size 2
set color orange
set grabbed? false
end

to enemy-bullet-gold-convert2
set breed enemy-bullets-gold
set shape "enemy-bullet-gold"
set size 1.5
set color orange
set grabbed? false
end

to enemy-laser-gold-convert
set breed enemy-lasers-gold
set shape "enemy-laser-gold"
set size 6
set color orange
set grabbed? false
end

to enemy-laser-gold-convert2
set breed enemy-lasers-gold
set shape "enemy-laser-gold"
set size 4
set color orange
set grabbed? false
end

to enemy-pellet-move
ask enemy-pellets-yellow
  [fd 1
  if (ycor <= min-pycor + 0.5 or ycor >= max-pycor - 0.5 or xcor >= max-pxcor - 0.5 or xcor <= min-pxcor + 0.5) [die]]
ask enemy-pellets-green
  [fd 1.25
  if (ycor <= min-pycor + 0.5 or ycor >= max-pycor - 0.5 or xcor >= max-pxcor - 0.5 or xcor <= min-pxcor + 0.5) [die]]
ask enemy-bullets-gold
  [fd 1.5
  if (ycor <= min-pycor + 0.5 or ycor >= max-pycor - 0.5 or xcor >= max-pxcor - 0.5 or xcor <= min-pxcor + 0.5) [die]]
ask enemy-lasers-gold
  [fd 2
  if (ycor <= min-pycor + 0.5 or ycor >= max-pycor - 0.5 or xcor >= max-pxcor - 0.5 or xcor <= min-pxcor + 0.5) [die]]
end

to hit-red1
hatch 1 [set breed bullet-hits set shape "fire-red" set size 1.25 set color red - 2]
end

to hit-red2
hatch 1 [rt 90 fd .3 set breed bullet-hits set shape "fire-red" set size 1.25 set color red - 2]
hatch 1 [lt 90 fd .3 set breed bullet-hits set shape "fire-red" set size 1.25 set color red - 2]
end

to hit-blue0
hatch 1 [set breed bullet-hits set shape "fire-blue" set size 1.25]
end
to hit-blue1
hatch 1 [rt 90 fd .5 set breed bullet-hits set shape "fire-blue" set size 1.25]
hatch 1 [lt 90 fd .5 set breed bullet-hits set shape "fire-blue" set size 1.25]
end
to hit-blue2
hatch 1 [set breed bullet-hits set shape "fire-blue" set size 1.25]
hatch 1 [rt 90 fd .7 set breed bullet-hits set shape "fire-blue" set size 1.25]
hatch 1 [lt 90 fd .7 set breed bullet-hits set shape "fire-blue" set size 1.25]
end
to hit-blue3
hatch 1 [rt 90 fd .4 set breed bullet-hits set shape "fire-blue" set size 2.5]
hatch 1 [lt 90 fd .4 set breed bullet-hits set shape "fire-blue" set size 2.5]
hatch 1 [rt 90 fd 1.2 set breed bullet-hits set shape "fire-blue" set size 2.5]
hatch 1 [lt 90 fd 1.2 set breed bullet-hits set shape "fire-blue" set size 2.5]
end

to hit-animate
ask bullet-hits
[if (size = 1)
[die]
if (size = 1.5)
[set size 1]
if (size = 1.25)
[set size 1.5]
  if (size = 2)
  [die]
  if (size = 3)
  [set size 2]
  if (size = 2.5)
  [set size 3]]
end

to explode [x]
set breed explosions set shape "explosion1" set size x
end

to explode-animate
ask explosions
[if (shape = "explosion6")
[die]
if (shape = "explosion5")
[set shape "explosion6"]
if (shape = "explosion4")
[set shape "explosion5"]
if (shape = "explosion3")
[set shape "explosion4"]
if (shape = "explosion2")
[set shape "explosion3"]
if (shape = "explosion1")
[set shape "explosion2"]]
end

to get-damage
ask raidens
[let a1 one-of enemies with [shape = "turtle"] in-radius 6 with [grabbed? = false]
  if (a1 != nobody) [ask a1 [set grabbed? true]set rhealth rhealth - 10]]
ask raidens
[let a1 one-of enemies with [shape = "boss2"] in-radius 2.75 with [grabbed? = false]
  if (a1 != nobody) [ask a1 [set grabbed? true]set rhealth rhealth - 2]
let a2 one-of enemies with [shape = "boss2"] in-radius 2.75 with [grabbed? = true]
  if (a2 = nobody and one-of enemies with [shape = "boss2"] != nobody)
    [ask one-of enemies with [shape = "boss2"] [set grabbed? false]]]
ask raidens
[let a1 one-of enemies with [size = 18] in-radius 7 with [grabbed? = false]
  if (a1 != nobody) [ask a1 [set grabbed? true]set rhealth rhealth - 10]]
ask raidens
[let a1 one-of enemies with [size = 3] in-radius 1.75 with [grabbed? = false]
  if (a1 != nobody) [ask a1 [set grabbed? true die]set rhealth rhealth - 2]]
ask raidens
[let a1 one-of enemies with [size = 5] in-radius 2.75 with [grabbed? = false]
  if (a1 != nobody) [ask a1 [set grabbed? true die]set rhealth rhealth - 2]]
ask raidens
[let epy1 one-of enemy-pellets-yellow in-radius 1.5 with [grabbed? = false]
  if (epy1 != nobody) [ask epy1 [set grabbed? true die]set rhealth rhealth - 1]
  ]
ask raidens
[let epg1 one-of enemy-pellets-green in-radius 1.5 with [grabbed? = false]
  if (epg1 != nobody) [ask epg1 [set grabbed? true die]set rhealth rhealth - 1]
  ]
ask raidens
[let ebg1 one-of enemy-bullets-gold in-radius 1.5 with [grabbed? = false]
  if (ebg1 != nobody) [ask ebg1 [set grabbed? true die]set rhealth rhealth - 1]
  ]
ask raidens
[let elg1 one-of enemy-lasers-gold with [size = 6] in-radius 3.5 with [grabbed? = false]
  if (elg1 != nobody) [ask elg1 [set grabbed? true]set rhealth rhealth - 2]
  ]
ask raidens
[let elg1 one-of enemy-lasers-gold with [size = 4] in-radius 2.5 with [grabbed? = false]
  if (elg1 != nobody) [ask elg1 [set grabbed? true]set rhealth rhealth - 4]
  ]
ask raidens
[let a1 one-of enemies with [size = 1.5] in-radius 1 with [grabbed? = false]
  if (a1 != nobody) [ask a1 [set grabbed? true explode 1.5]set rhealth rhealth - 1]]
end

to get-killed
ask raidens
[if (rhealth <= 0)[set rlives rlives - 1
ifelse (random 100 < 1)
    [hatch-powerups-max 1
    [powerup-max-convert]]
  [ifelse (random 100 < 60)
    [hatch-powerups-missile 1
    [powerup-missile-convert]]
    [hatch-powerups-weapon 1
    [powerup-weapon-convert]]]
hatch-powerups-weapon 1
    [powerup-weapon-convert]
hatch-powerups-weapon 1
    [powerup-weapon-convert]
    wait 0.5 respawn explode 3]]
end

to respawn
hatch-raidens 1
  [set rhealth 999
  set size 3
  set shape "raiden"
  set color gray
  set xcor 0
  set ycor (min-pycor - 0) / 2
  set invincible? true
  set i-countdown 20
  set weapontype 99
  set missiletype 00]
end

to rebirth
ask raidens with [i-countdown > 0 and invincible? = true]
  [set i-countdown i-countdown - 1]
ask raidens with [i-countdown > 0 and invincible? = true and color = red]
  [set color gray - 1]
ask raidens with [i-countdown > 0 and invincible? = true and color = gray]
  [set color red]
ask raidens with [i-countdown > 0 and invincible? = true and color = gray - 1]
  [set color gray]
ask raidens with [i-countdown <= 0 and invincible? = true]
  [set breed raidens
  set rhealth 10
  set size 3
  set shape "raiden"
  set color red
  set weapontype 00
  set missiletype 00
  set invincible? false]
end

to gameover
ask raidens
[if (rlives <= 0)[set over? true set win? false die]]
if (over? = true)
  [ct
  if (win? = true)[crt 1
    ask turtles [set size 20 set shape "face happy" set color yellow stop]]
  if (win? = false)[crt 1
    ask turtles [set size 20 set shape "face sad" set color red stop]]]
end

to level
set lvl-countdown lvl-countdown - .05
if (difficulty = 1 and lvl-countdown < 100 and lvl-countdown > 75)
  [spawn-enemy-fighter .75 spawn-enemy-assaultship .375]
if (difficulty = 1 and lvl-countdown < 75 and lvl-countdown > 50)
  [spawn-enemy 1.5]
if (difficulty = 1 and lvl-countdown < 50 and lvl-countdown > 25)
  [spawn-enemy 1 spawn-enemy-fighter .75]
if (difficulty = 1 and lvl-countdown < 25 and lvl-countdown > 0)
  [spawn-enemy .75 spawn-enemy-fighter .75 spawn-enemy-assaultship 0.375]
if (difficulty = 1 and lvl-countdown <= -5 and lvl-countdown >= -5.05)
  [spawn-boss-turtle]
if (difficulty = 2 and lvl-countdown < 100 and lvl-countdown > 75)
  [spawn-enemy-suicidal .75 spawn-enemy-fighter 1.5 spawn-enemy-assaultship .75 spawn-enemy-bomber 0.375]
if (difficulty = 2 and lvl-countdown < 75 and lvl-countdown > 50)
  [spawn-enemy 2 spawn-enemy-fighter 1.5]
if (difficulty = 2 and lvl-countdown < 50 and lvl-countdown > 25)
  [spawn-enemy 1.5 spawn-enemy-fighter 1.5 spawn-enemy-assaultship .75]
if (difficulty = 2 and lvl-countdown < 25 and lvl-countdown > 0)
  [spawn-enemy 1 spawn-enemy-fighter 1.5 spawn-enemy-assaultship .75 spawn-enemy-bomber 0.375 spawn-enemy-suicidal .75]
if (difficulty = 2 and lvl-countdown <= -5 and lvl-countdown >= -5.05)
  [spawn-boss-UFO]
if (difficulty = 3 and lvl-countdown < 100 and lvl-countdown > 75)
  [spawn-enemy-suicidal2 1.5 spawn-enemy-fighter 2 spawn-enemy-assaultship 1 spawn-enemy-bomber 0.75]
if (difficulty = 3 and lvl-countdown < 75 and lvl-countdown > 50)
  [spawn-enemy 4 spawn-enemy-fighter 2.5]
if (difficulty = 3 and lvl-countdown < 50 and lvl-countdown > 25)
  [spawn-enemy 3 spawn-enemy-fighter 2 spawn-enemy-assaultship 1.25]
if (difficulty = 3 and lvl-countdown < 25 and lvl-countdown > 0)
  [spawn-enemy 2 spawn-enemy-fighter 2 spawn-enemy-assaultship 1 spawn-enemy-bomber 0.75 spawn-enemy-suicidal2 1.5]
if (difficulty = 3 and lvl-countdown <= -5 and lvl-countdown >= -5.05)
  [spawn-boss-alvatorre]
if (difficulty = 4 and lvl-countdown <= -5 and lvl-countdown >= -5.05)
  [spawn-boss-raiden]
if (difficulty = 5 and lvl-countdown <= -2 and lvl-countdown >= -2.05)
  [set over? true set win? true]
end

to go
bullet-red-move
bullet-blue-move
bullets-violet-move
missile-move
do-damage
kill-enemy
explode-animate
hit-animate
get-damage
get-killed
rebirth
gameover
powerup-spawn
ask powerups-weapon [wiggle]
ask powerups-missile [wiggle]
ask powerups-max [wiggle]
level
enemy-move
enemy-fighter-move
enemy-assaultship-move
enemy-bomber-move
enemy-suicidal-move
enemy-suicidal2-move
boss-turtle-move
boss-UFO-move
boss-alvatorre-move
enemy-fang-move
boss-raiden-move
enemy-homing-move
enemy-pellet-move
if (random 100 < 20) [powerup-weapon-change powerup-missile-change]
powerup-max-change
ask raidens [weaponup missileup maxup]
colorchange
wait 0.1
end
@#$#@#$#@
GRAPHICS-WINDOW
303
10
721
429
-1
-1
10.0
1
10
1
1
1
0
0
0
1
-20
20
-20
20
0
0
1
ticks
30.0

BUTTON
26
30
99
63
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
25
73
88
106
NIL
Go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
161
29
224
62
Up
go-front
NIL
1
T
OBSERVER
NIL
W
NIL
NIL
1

BUTTON
120
75
183
108
Left
go-left
NIL
1
T
OBSERVER
NIL
A
NIL
NIL
1

BUTTON
205
76
274
109
Right
Go-right
NIL
1
T
OBSERVER
NIL
D
NIL
NIL
1

BUTTON
157
121
229
154
Down
Go-back
NIL
1
T
OBSERVER
NIL
S
NIL
NIL
1

BUTTON
26
114
89
147
NIL
Fire
NIL
1
T
OBSERVER
NIL
K
NIL
NIL
1

MONITOR
19
238
81
283
Health
rhealth
2
1
11

MONITOR
108
238
165
283
Lives
rlives
2
1
11

MONITOR
19
364
114
409
Level Countdown
lvl-countdown
3
1
11

MONITOR
108
296
165
341
Score
score
3
1
11

MONITOR
19
294
81
339
Level
difficulty
3
1
11

@#$#@#$#@
## WHAT IS IT?

Raiden

This is a space-shooter game based on the (now non existent) online flash game "Raiden X," which itself is  based on the original Japanese Raiden arcade games.

## HOW IT WORKS

General:
	This game gives the player control of a single space-fighter and pits them against enemy crafts that spawn from the top of the map, which is done by sprouting them from the top patches. As the game progresses through a level, the types of enemies you face would change and at the end of each level is some sort of boss that would force the player to move around more (as if they have not already). Beating a boss would give the player access to the next level of difficulty, which not only increase the spawn rate of the enemies, but may also contain new ones as well.

The Weapon System:
	There are three different types of main weapons and 4 different levels for each. The types of weapon is indicated by the color of the space-fighter. A red space-fighter can fire mediocre red bullets in increasing amounts as the weapon level increases. A blue space-fighter can fire a powerful blue laser that becomes even stronger as the level increases. Finally, a purple space-fighter can fire a homing laser that targets a random enemy. The player starts out with level 0 red bullets and must collect power-ups to work its way up the weapon system.

	In addition to the standard bullets/lasers, the space-fighter also have a subweapon in the forms of missiles. There are two types of missiles and 3 different levels for each. Recieving a missile power-up with a yellow "M" would result in powerful missiles that travels forward from the space-fighter. Recieving a missile power-up with a green "H" would result in a homing missile that homes in to random enemies. As missile level is increased more missiles would be fired.

## HOW TO USE IT

The controls are fairly straightforward. First set up everything with the button "Setup". Then hit "Go" and the game will commence. The movement control uses the standard WASD (W for Up, A for left, S for down, D for right). Firing bullets uses the button K.

To win, simply defeat as many enemies as you can and defeat all the bosses.

## THINGS TO NOTICE

Obviously, one of the chief things the player should look out for would be the "Health" monitor and the "Lives" monitor. Without those, the player is probably going to have some trouble beating the game as they would not how much more damage they can sustain. "Level" defines which level the player is up to. "Score" is pretty self-explanatory. Finally, "Level Countdown" is the actual time system used to time a level and what enemies appear. In this case, it can be used by the player to know how much longer the level last, as the enemies will only spawn when "Level-Countdown" is between 0 and 100. Don't fret if it reaches the negatives: it is supposed to, for a very special purpose...

## THINGS TO TRY

Beating the game would probably be the first thing that comes to anyone's mind. After that, you could try attaining a higher score by selectively defeating more enemies or picking the same power-ups after you have attained the highest level of your weapon. Following that, you could try beating the game with only a specific weapon or only kill a specific type of enemies. In short, the possibilities is endless... provided that you put some time of thinking new ways to play the game.

## EXTENDING THE MODEL

This section could give some ideas of things to add or change in the procedures tab to make the model more complicated, detailed, accurate, etc.

## NETLOGO FEATURES

This section could point out any especially interesting or unusual features of NetLogo that the model makes use of, particularly in the Procedures tab.  It might also point out places where workarounds were needed because of missing features.

## RELATED MODELS

This section could give the names of models in the NetLogo Models Library or elsewhere which are of related interest.

## CREDITS AND REFERENCES

This section could contain a reference to the model's URL on the web if it has one, as well as any other necessary credits or references.

## HELP

A help section for anyone having trouble with the game
DO NOT READ ANY FURTHER IF YOU DO NOT WISH TO BE SPOILED!

y
o
u

h
a
v
e

b
e
e
n

w
a
r
n
e
d
!

Important enemies:
Assault Ships (Brown, stops and shoots 3 pellets) - 60% chance of dropping a weapon power-up
Bombers (Gray, moves down the screen and shoot a stream of green pellets) - 40% chance of dropping a missile power-up

Defeating the bosses:
Turtle - It turns as fast as you move (since it "faces" the player), so you can get more hits in if you move slower while you are at the bottom of the screen.
UFO - It is preferable to get a homing weapon (both purple laser and homing missile works) for this fight as the UFO moves around a lot and sometimes goes to the bottom of the screen, where you cannot hit it otherwise.
Alvatorre (Giant Yellow Thing) - The only way to stop its giant laser is to defeat all the "remote weapons" that appears. Getting a level 4 Red Bullets will make it much easier while it is shooting its laser. However, if you want to make it even easier, simply get a purple laser (any level) and stay in the upper corner where you can't be hit by its bullets, lasers, or remote weapons.
Raiden (Yourself) - The very top 1/4 of the screen is off-limits, so don't bother trying to move up there. Using level 4 Red Bullets is prefered due to the homing missiles and its fast movements.
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

alvatore4
false
4
Polygon -6459832 true false 270 45 255 75 225 90 180 135 150 150 60 165 15 180 0 195 0 225 15 240 75 255 150 255 154 243 154 255 195 259 229 259 236 266 247 274 260 280 276 283 285 330 285 -15
Circle -1184463 true true 210 135 150
Polygon -6459832 true false 271 135 269 143 285 149 285 131
Polygon -1184463 true true 0 203 16 208 61 198 92 198 120 207 164 205 239 215 229 260 187 259 154 255 75 255 15 240 0 225
Polygon -16777216 false false 228 258 222 249 217 240 214 232 211 222 210 210 211 197 215 182 222 168 240 145 285 165 285 285 277 285 261 281 248 275 237 267
Polygon -16777216 true false 250 134 265 104 277 110 269 144
Polygon -6459832 true false 180 240 225 240 225 270 180 270
Polygon -1184463 true true 135 254 150 284 162 276 171 255 150 223
Polygon -1184463 true true 119 156 123 121 135 105 150 114 159 145 149 150
Polygon -16777216 false false 285 330 270 255 285 248
Line -16777216 false 285 -15 270 45
Line -16777216 false 270 45 255 75
Line -16777216 false 255 75 225 90
Line -16777216 false 225 90 180 135
Line -16777216 false 180 135 150 150
Line -16777216 false 0 195 0 225
Line -16777216 false 0 225 15 240
Line -16777216 false 15 240 75 255
Line -16777216 false 75 255 150 255
Line -16777216 false 150 255 165 210
Line -16777216 false 150 150 165 210
Line -16777216 false 154 243 154 255
Line -16777216 false 154 255 196 259
Line -16777216 false 196 259 229 259
Polygon -16777216 false false 159 187 150 195 120 195 104 190 90 188 74 188 60 188 44 192 29 195 15 198 0 195 15 180 60 165 150 150
Line -16777216 false 30 195 45 180
Line -16777216 false 45 180 210 150
Line -16777216 false 210 150 240 210
Line -16777216 false 240 210 229 259
Line -16777216 false 278 15 285 8
Line -16777216 false 270 45 285 30
Line -6459832 false 300 120 300 0
Line -16777216 false 270 144 285 149
Line -16777216 false 210 150 210 135
Line -16777216 false 210 135 225 105
Line -16777216 false 225 105 270 90
Line -16777216 false 255 95 270 60
Line -16777216 false 15 240 45 236
Line -16777216 false 45 236 76 240
Line -16777216 false 75 240 135 233
Line -16777216 false 136 233 155 239
Line -16777216 false 240 129 270 144
Line -16777216 false 240 129 231 117
Line -16777216 false 231 118 239 100
Line -16777216 false 45 192 30 210
Line -16777216 false 30 210 30 225
Line -16777216 false 30 225 75 255
Line -16777216 false 120 195 135 210
Line -16777216 false 135 210 135 225
Line -16777216 false 135 225 120 235
Line -16777216 false 285 -15 285 255
Line -16777216 false 270 90 285 102
Line -16777216 false 270 60 285 45
Line -16777216 false 270 90 270 75
Line -16777216 false 270 75 285 68
Line -16777216 false 233 196 240 180
Line -16777216 false 240 180 247 210
Line -16777216 false 250 226 248 238
Line -16777216 false 247 238 236 226
Line -16777216 false 247 210 254 180
Line -16777216 false 255 180 265 184
Line -16777216 false 265 184 266 210
Line -16777216 false 272 210 278 180
Line -16777216 false 279 180 285 176
Line -16777216 false 285 240 272 225
Line -16777216 false 266 211 272 211
Line -16777216 false 272 225 266 225
Line -16777216 false 265 226 261 241
Line -16777216 false 250 225 261 241
Line -16777216 false 119 156 123 119
Line -16777216 false 124 119 135 105
Line -16777216 false 135 105 150 114
Line -16777216 false 149 114 160 144
Line -16777216 false 135 255 150 285
Line -16777216 false 170 256 161 276
Line -16777216 false 150 285 161 277
Rectangle -16777216 false false 180 240 225 270
Polygon -16777216 false false 195 270 165 285 240 285 210 270
Rectangle -16777216 false false 195 255 210 270
Line -16777216 false 180 135 218 121
Line -16777216 false 210 105 258 87
Polygon -6459832 true false 210 270 195 270 179 274 165 285 240 285 225 274
Circle -7500403 true false 258 118 13
Polygon -16777216 false false 235 230 240 239 249 250 259 257 272 262 279 263 285 263 278 263 265 260 251 251 241 241 236 232
Polygon -16777216 true false 234 197 241 180 248 210 255 180 266 184 267 209 267 212 273 211 279 181 286 176 286 240 273 225 266 225 262 241 251 225 249 239 237 227 241 210
Polygon -1184463 true true 238 215 211 204 214 189 221 171 240 210
Polygon -1184463 true true 220 170 218 138 235 123 240 131 285 150 285 165 240 145

alvatorre
false
3
Polygon -1184463 true false 301 156 297 121 285 105 270 114 261 145 271 150
Polygon -16777216 false false 302 155 297 120 286 105 272 113 261 144 271 150
Polygon -6459832 true true 165 45 180 75 210 90 255 135 285 150 375 165 420 180 435 195 435 225 420 240 360 255 285 255 281 243 281 255 240 259 206 259 199 266 188 274 175 280 159 283 150 330 150 -15
Polygon -1184463 true false 435 203 419 208 374 198 343 198 315 207 271 205 196 215 206 260 248 259 281 255 360 255 420 240 435 225
Polygon -1184463 true false -1 156 3 121 15 105 30 114 39 145 29 150
Polygon -16777216 false false -2 155 3 120 14 105 28 113 39 144 29 150
Polygon -6459832 true true 135 45 120 75 90 90 45 135 15 150 -75 165 -120 180 -135 195 -135 225 -120 240 -60 255 15 255 19 243 19 255 60 259 94 259 101 266 112 274 125 280 141 283 150 330 150 -15
Polygon -1184463 true false -135 203 -119 208 -74 198 -43 198 -15 207 29 205 104 215 94 260 52 259 19 255 -60 255 -120 240 -135 225
Rectangle -16777216 false false 210 240 255 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 0 254 15 284 27 276 36 255 15 223
Polygon -16777216 false false 0 255 14 284 25 278 34 256 20 256 19 244 14 255
Polygon -16777216 false false -90 191 -105 210 -105 225 -60 255 15 255 30 210 18 160 -90 180 -105 195
Rectangle -16777216 false false 210 240 255 270
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 45 240 90 270
Circle -1184463 true false 75 135 150
Polygon -16777216 true false 201 197 194 180 187 210 180 180 169 184 168 209 168 212 162 211 156 181 149 176 149 240 162 225 169 225 173 241 184 225 186 239 198 227 194 210
Polygon -16777216 false false 207 258 213 249 218 240 221 232 224 222 225 210 224 197 220 182 213 168 195 145 150 165 150 285 158 285 174 281 187 275 198 267
Polygon -16777216 true false 99 197 106 180 113 210 120 180 131 184 132 209 132 212 138 211 144 181 151 176 151 240 138 225 131 225 127 241 116 225 114 239 102 227 106 210
Rectangle -16777216 false false 210 240 255 270
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -1184463 true false 300 254 285 284 273 276 264 255 285 223
Polygon -16777216 false false 390 191 405 210 405 225 360 255 285 255 270 210 282 160 390 180 405 195
Polygon -6459832 true true 164 135 166 143 150 149 150 131
Polygon -16777216 true false 185 134 170 104 158 110 166 144
Line -16777216 false 150 -15 165 45
Line -16777216 false 165 45 180 75
Line -16777216 false 180 75 210 90
Line -16777216 false 210 90 255 135
Line -16777216 false 255 135 285 150
Line -16777216 false 15 255 30 210
Line -16777216 false 15 150 30 210
Polygon -16777216 false false 276 187 285 195 315 195 331 190 345 188 361 188 375 188 391 192 406 195 420 198 435 195 420 180 375 165 285 150
Line -16777216 false 157 15 150 8
Line -16777216 false 165 45 150 30
Line -16777216 false 165 144 150 149
Line -16777216 false 210 150 210 135
Line -16777216 false 210 105 165 90
Line -16777216 false 180 95 165 60
Line -16777216 false 195 129 165 144
Line -16777216 false 195 129 204 117
Line -16777216 false 96 118 104 100
Line -16777216 false 165 90 150 102
Line -16777216 false 165 60 150 45
Line -16777216 false 165 90 165 75
Line -16777216 false 165 75 150 68
Line -16777216 false 225 105 177 87
Circle -7500403 true false 164 118 13
Polygon -16777216 false false 200 230 195 239 186 250 176 257 163 262 156 263 150 263 157 263 170 260 184 251 194 241 199 232
Polygon -1184463 true false 197 215 224 204 221 189 214 171 195 210
Polygon -1184463 true false 215 170 217 138 200 123 195 131 150 150 150 165 195 145
Polygon -16777216 false false 420 240 389 236 360 240 297 233 280 239 285 255 360 255
Polygon -16777216 false false 135 255 150 330 165 255 149 248
Polygon -16777216 false false 24 187 15 195 -15 195 -31 190 -45 188 -61 188 -75 188 -91 192 -106 195 -120 198 -135 195 -120 180 -75 165 15 150
Polygon -6459832 true true 225 270 240 270 256 274 270 285 195 285 210 274
Rectangle -16777216 false false 225 255 240 270
Line -16777216 false 45 135 15 150
Line -16777216 false 90 90 45 135
Line -16777216 false 75 105 123 87
Line -16777216 false 120 75 90 90
Line -16777216 false 135 45 120 75
Line -16777216 false 135 45 150 30
Line -16777216 false 150 -15 135 45
Line -16777216 false 143 15 150 8
Line -16777216 false 135 60 150 45
Line -16777216 false 120 95 135 60
Line -16777216 false 135 75 150 68
Line -16777216 false 135 90 135 75
Line -16777216 false 90 105 135 90
Line -16777216 false 135 90 150 102
Line -16777216 false 96 118 104 100
Polygon -16777216 true false 115 134 130 104 142 110 134 144
Circle -7500403 true false 123 118 13
Line -16777216 false 105 129 96 117
Line -16777216 false 105 129 135 144
Line -16777216 false 135 144 150 149
Polygon -6459832 true true 136 135 134 143 150 149 150 131
Polygon -1184463 true false 85 170 83 138 100 123 105 131 150 150 150 165 105 145
Polygon -16777216 false false 100 230 105 239 114 250 124 257 137 262 144 263 150 263 143 263 130 260 116 251 106 241 101 232
Polygon -6459832 true true 75 270 60 270 44 274 30 285 105 285 90 274
Line -16777216 false 225 150 195 210
Line -16777216 false 195 210 206 260
Polygon -16777216 false false 300 255 286 284 275 278 266 256 280 256 281 244 286 255
Line -16777216 false 75 150 105 210
Rectangle -16777216 false false 225 255 240 270
Polygon -1184463 true false 103 215 76 204 79 189 86 171 105 210
Polygon -16777216 false false 93 258 87 249 82 240 79 232 76 222 75 210 76 197 80 182 87 168 105 145 150 165 150 285 142 285 126 281 113 275 102 267
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 60 255 75 270
Polygon -6459832 true true 135 255 150 330 165 255 148 248
Polygon -16777216 false false -120 240 -89 236 -60 240 3 233 20 239 15 255 -60 255
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Line -16777216 false 150 45 150 -15
Polygon -16777216 false false -90 180 75 150 105 210 93 259 58 259 19 255 19 243 19 239 4 233 -14 235 0 225 0 210 -15 195 -42 188 -77 188 -104 195
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 60 255 75 270
Rectangle -16777216 false false 45 240 90 270
Polygon -6459832 true true 255 240 210 240 210 270 255 270
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 210 240 255 270
Circle -16777216 true false 167 120 8
Circle -16777216 true false 125 120 8
Line -16777216 false 255 135 217 121
Line -16777216 false 120 135 82 121
Line -16777216 false 180 135 218 121
Line -16777216 false 204 118 196 100
Line -16777216 false 45 135 83 121

alvatorre-charge0
false
3
Polygon -1184463 true false -1 156 3 121 15 105 30 114 39 145 29 150
Polygon -16777216 false false -2 155 3 120 14 105 28 113 39 144 29 150
Polygon -6459832 true true 135 45 120 75 90 90 45 135 15 150 -75 165 -120 180 -135 195 -135 225 -120 240 -60 255 15 255 19 243 19 255 60 259 94 259 101 266 112 274 125 280 141 283 150 330 150 -15
Polygon -1184463 true false -135 203 -119 208 -74 198 -43 198 -15 207 29 205 104 215 94 260 52 259 19 255 -60 255 -120 240 -135 225
Rectangle -16777216 false false 210 240 255 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 0 254 15 284 27 276 36 255 15 223
Polygon -16777216 false false 0 255 14 284 25 278 34 256 20 256 19 244 14 255
Polygon -16777216 false false -90 191 -105 210 -105 225 -60 255 15 255 30 210 18 160 -90 180 -105 195
Rectangle -16777216 false false 210 240 255 270
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 301 156 297 121 285 105 270 114 261 145 271 150
Polygon -16777216 false false 302 155 297 120 286 105 272 113 261 144 271 150
Polygon -6459832 true true 165 45 180 75 210 90 255 135 285 150 375 165 420 180 435 195 435 225 420 240 360 255 285 255 281 243 281 255 240 259 206 259 199 266 188 274 175 280 159 283 150 330 150 -15
Circle -1184463 true false 75 135 150
Polygon -16777216 true false 201 197 194 180 187 210 180 180 169 184 168 209 168 212 162 211 156 181 149 176 149 240 162 225 169 225 173 241 184 225 186 239 198 227 194 210
Polygon -16777216 false false 207 258 213 249 218 240 221 232 224 222 225 210 224 197 220 182 213 168 195 145 150 165 150 285 158 285 174 281 187 275 198 267
Polygon -16777216 true false 99 197 106 180 113 210 120 180 131 184 132 209 132 212 138 211 144 181 151 176 151 240 138 225 131 225 127 241 116 225 114 239 102 227 106 210
Rectangle -16777216 false false 210 240 255 270
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -1184463 true false 300 254 285 284 273 276 264 255 285 223
Polygon -1184463 true false 435 203 419 208 374 198 343 198 315 207 271 205 196 215 206 260 248 259 281 255 360 255 420 240 435 225
Polygon -16777216 false false 390 191 405 210 405 225 360 255 285 255 270 210 282 160 390 180 405 195
Polygon -6459832 true true 164 135 166 143 150 149 150 131
Polygon -16777216 true false 185 134 170 104 158 110 166 144
Line -16777216 false 150 -15 165 45
Line -16777216 false 165 45 180 75
Line -16777216 false 180 75 210 90
Line -16777216 false 210 90 255 135
Line -16777216 false 255 135 285 150
Line -16777216 false 15 255 30 210
Line -16777216 false 15 150 30 210
Polygon -16777216 false false 276 187 285 195 315 195 331 190 345 188 361 188 375 188 391 192 406 195 420 198 435 195 420 180 375 165 285 150
Line -16777216 false 157 15 150 8
Line -16777216 false 165 45 150 30
Line -16777216 false 165 144 150 149
Line -16777216 false 210 150 210 135
Line -16777216 false 210 105 165 90
Line -16777216 false 180 95 165 60
Line -16777216 false 195 129 165 144
Line -16777216 false 195 129 204 117
Line -16777216 false 204 118 196 100
Line -16777216 false 165 90 150 102
Line -16777216 false 165 60 150 45
Line -16777216 false 165 90 165 75
Line -16777216 false 165 75 150 68
Line -16777216 false 180 135 218 121
Line -16777216 false 225 105 177 87
Circle -7500403 true false 164 118 13
Polygon -16777216 false false 200 230 195 239 186 250 176 257 163 262 156 263 150 263 157 263 170 260 184 251 194 241 199 232
Polygon -1184463 true false 197 215 224 204 221 189 214 171 195 210
Polygon -1184463 true false 215 170 217 138 200 123 195 131 150 150 150 165 195 145
Polygon -16777216 false false 420 240 389 236 360 240 297 233 280 239 285 255 360 255
Polygon -16777216 false false 135 255 150 330 165 255 149 248
Polygon -16777216 false false 24 187 15 195 -15 195 -31 190 -45 188 -61 188 -75 188 -91 192 -106 195 -120 198 -135 195 -120 180 -75 165 15 150
Polygon -6459832 true true 225 270 240 270 256 274 270 285 195 285 210 274
Rectangle -16777216 false false 225 255 240 270
Line -16777216 false 255 135 217 121
Line -16777216 false 45 135 15 150
Line -16777216 false 90 90 45 135
Line -16777216 false 75 105 123 87
Line -16777216 false 120 75 90 90
Line -16777216 false 135 45 120 75
Line -16777216 false 135 45 150 30
Line -16777216 false 150 -15 135 45
Line -16777216 false 143 15 150 8
Line -16777216 false 135 60 150 45
Line -16777216 false 120 95 135 60
Line -16777216 false 135 75 150 68
Line -16777216 false 135 90 135 75
Line -16777216 false 90 105 135 90
Line -16777216 false 135 90 150 102
Line -16777216 false 96 118 104 100
Polygon -16777216 true false 115 134 130 104 142 110 134 144
Circle -7500403 true false 123 118 13
Line -16777216 false 105 129 96 117
Line -16777216 false 120 135 82 121
Line -16777216 false 105 129 135 144
Line -16777216 false 135 144 150 149
Polygon -6459832 true true 136 135 134 143 150 149 150 131
Polygon -1184463 true false 85 170 83 138 100 123 105 131 150 150 150 165 105 145
Polygon -16777216 false false 100 230 105 239 114 250 124 257 137 262 144 263 150 263 143 263 130 260 116 251 106 241 101 232
Polygon -6459832 true true 75 270 60 270 44 274 30 285 105 285 90 274
Line -16777216 false 225 150 195 210
Line -16777216 false 195 210 206 260
Polygon -16777216 false false 300 255 286 284 275 278 266 256 280 256 281 244 286 255
Line -16777216 false 75 150 105 210
Rectangle -16777216 false false 225 255 240 270
Polygon -1184463 true false 103 215 76 204 79 189 86 171 105 210
Polygon -16777216 false false 93 258 87 249 82 240 79 232 76 222 75 210 76 197 80 182 87 168 105 145 150 165 150 285 142 285 126 281 113 275 102 267
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 60 255 75 270
Polygon -6459832 true true 135 255 150 330 165 255 148 248
Polygon -16777216 false false -120 240 -89 236 -60 240 3 233 20 239 15 255 -60 255
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Line -16777216 false 150 45 150 -15
Polygon -16777216 false false -90 180 75 150 105 210 93 259 58 259 19 255 19 243 19 239 4 233 -14 235 0 225 0 210 -15 195 -42 188 -77 188 -104 195
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 60 255 75 270
Rectangle -16777216 false false 45 240 90 270
Polygon -6459832 true true 255 240 210 240 210 270 255 270
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 210 240 255 270
Circle -16777216 true false 167 120 8
Circle -16777216 true false 125 120 8
Circle -955883 true false 135 120 30
Circle -955883 true false 135 270 30
Circle -955883 true false 210 195 30
Circle -955883 true false 60 195 30
Circle -955883 true false 180 150 30
Circle -955883 true false 90 150 30
Circle -955883 true false 90 240 30
Circle -955883 true false 180 240 30
Line -16777216 false 45 135 83 121

alvatorre-charge0.5
false
3
Polygon -1184463 true false -1 156 3 121 15 105 30 114 39 145 29 150
Polygon -16777216 false false -2 155 3 120 14 105 28 113 39 144 29 150
Polygon -6459832 true true 135 45 120 75 90 90 45 135 15 150 -75 165 -120 180 -135 195 -135 225 -120 240 -60 255 15 255 19 243 19 255 60 259 94 259 101 266 112 274 125 280 141 283 150 330 150 -15
Polygon -1184463 true false -135 203 -119 208 -74 198 -43 198 -15 207 29 205 104 215 94 260 52 259 19 255 -60 255 -120 240 -135 225
Rectangle -16777216 false false 210 240 255 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 0 254 15 284 27 276 36 255 15 223
Polygon -16777216 false false 0 255 14 284 25 278 34 256 20 256 19 244 14 255
Polygon -16777216 false false -90 191 -105 210 -105 225 -60 255 15 255 30 210 18 160 -90 180 -105 195
Rectangle -16777216 false false 210 240 255 270
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 301 156 297 121 285 105 270 114 261 145 271 150
Polygon -16777216 false false 302 155 297 120 286 105 272 113 261 144 271 150
Polygon -6459832 true true 165 45 180 75 210 90 255 135 285 150 375 165 420 180 435 195 435 225 420 240 360 255 285 255 281 243 281 255 240 259 206 259 199 266 188 274 175 280 159 283 150 330 150 -15
Circle -1184463 true false 75 135 150
Polygon -16777216 true false 201 197 194 180 187 210 180 180 169 184 168 209 168 212 162 211 156 181 149 176 149 240 162 225 169 225 173 241 184 225 186 239 198 227 194 210
Polygon -16777216 false false 207 258 213 249 218 240 221 232 224 222 225 210 224 197 220 182 213 168 195 145 150 165 150 285 158 285 174 281 187 275 198 267
Polygon -16777216 true false 99 197 106 180 113 210 120 180 131 184 132 209 132 212 138 211 144 181 151 176 151 240 138 225 131 225 127 241 116 225 114 239 102 227 106 210
Rectangle -16777216 false false 210 240 255 270
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -1184463 true false 300 254 285 284 273 276 264 255 285 223
Polygon -1184463 true false 435 203 419 208 374 198 343 198 315 207 271 205 196 215 206 260 248 259 281 255 360 255 420 240 435 225
Polygon -16777216 false false 390 191 405 210 405 225 360 255 285 255 270 210 282 160 390 180 405 195
Polygon -6459832 true true 164 135 166 143 150 149 150 131
Polygon -16777216 true false 185 134 170 104 158 110 166 144
Line -16777216 false 150 -15 165 45
Line -16777216 false 165 45 180 75
Line -16777216 false 180 75 210 90
Line -16777216 false 210 90 255 135
Line -16777216 false 255 135 285 150
Line -16777216 false 15 255 30 210
Line -16777216 false 15 150 30 210
Polygon -16777216 false false 276 187 285 195 315 195 331 190 345 188 361 188 375 188 391 192 406 195 420 198 435 195 420 180 375 165 285 150
Line -16777216 false 157 15 150 8
Line -16777216 false 165 45 150 30
Line -16777216 false 165 144 150 149
Line -16777216 false 210 150 210 135
Line -16777216 false 210 105 165 90
Line -16777216 false 180 95 165 60
Line -16777216 false 195 129 165 144
Line -16777216 false 195 129 204 117
Line -16777216 false 204 118 196 100
Line -16777216 false 165 90 150 102
Line -16777216 false 165 60 150 45
Line -16777216 false 165 90 165 75
Line -16777216 false 165 75 150 68
Line -16777216 false 180 135 218 121
Line -16777216 false 225 105 177 87
Circle -7500403 true false 164 118 13
Polygon -16777216 false false 200 230 195 239 186 250 176 257 163 262 156 263 150 263 157 263 170 260 184 251 194 241 199 232
Polygon -1184463 true false 197 215 224 204 221 189 214 171 195 210
Polygon -1184463 true false 215 170 217 138 200 123 195 131 150 150 150 165 195 145
Polygon -16777216 false false 420 240 389 236 360 240 297 233 280 239 285 255 360 255
Polygon -16777216 false false 135 255 150 330 165 255 149 248
Polygon -16777216 false false 24 187 15 195 -15 195 -31 190 -45 188 -61 188 -75 188 -91 192 -106 195 -120 198 -135 195 -120 180 -75 165 15 150
Polygon -6459832 true true 225 270 240 270 256 274 270 285 195 285 210 274
Rectangle -16777216 false false 225 255 240 270
Line -16777216 false 255 135 217 121
Line -16777216 false 45 135 15 150
Line -16777216 false 90 90 45 135
Line -16777216 false 75 105 123 87
Line -16777216 false 120 75 90 90
Line -16777216 false 135 45 120 75
Line -16777216 false 135 45 150 30
Line -16777216 false 150 -15 135 45
Line -16777216 false 143 15 150 8
Line -16777216 false 135 60 150 45
Line -16777216 false 120 95 135 60
Line -16777216 false 135 75 150 68
Line -16777216 false 135 90 135 75
Line -16777216 false 90 105 135 90
Line -16777216 false 135 90 150 102
Line -16777216 false 96 118 104 100
Polygon -16777216 true false 115 134 130 104 142 110 134 144
Circle -7500403 true false 123 118 13
Line -16777216 false 105 129 96 117
Line -16777216 false 120 135 82 121
Line -16777216 false 105 129 135 144
Line -16777216 false 135 144 150 149
Polygon -6459832 true true 136 135 134 143 150 149 150 131
Polygon -1184463 true false 85 170 83 138 100 123 105 131 150 150 150 165 105 145
Polygon -16777216 false false 100 230 105 239 114 250 124 257 137 262 144 263 150 263 143 263 130 260 116 251 106 241 101 232
Polygon -6459832 true true 75 270 60 270 44 274 30 285 105 285 90 274
Line -16777216 false 225 150 195 210
Line -16777216 false 195 210 206 260
Polygon -16777216 false false 300 255 286 284 275 278 266 256 280 256 281 244 286 255
Line -16777216 false 75 150 105 210
Rectangle -16777216 false false 225 255 240 270
Polygon -1184463 true false 103 215 76 204 79 189 86 171 105 210
Polygon -16777216 false false 93 258 87 249 82 240 79 232 76 222 75 210 76 197 80 182 87 168 105 145 150 165 150 285 142 285 126 281 113 275 102 267
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 60 255 75 270
Polygon -6459832 true true 135 255 150 330 165 255 148 248
Polygon -16777216 false false -120 240 -89 236 -60 240 3 233 20 239 15 255 -60 255
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Line -16777216 false 150 45 150 -15
Polygon -16777216 false false -90 180 75 150 105 210 93 259 58 259 19 255 19 243 19 239 4 233 -14 235 0 225 0 210 -15 195 -42 188 -77 188 -104 195
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 60 255 75 270
Rectangle -16777216 false false 45 240 90 270
Polygon -6459832 true true 255 240 210 240 210 270 255 270
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 210 240 255 270
Circle -16777216 true false 167 120 8
Circle -16777216 true false 125 120 8
Circle -955883 true false 135 135 30
Circle -955883 true false 135 255 30
Circle -955883 true false 195 195 30
Circle -955883 true false 75 195 30
Circle -955883 true false 172 157 30
Circle -955883 true false 98 157 30
Circle -955883 true false 172 232 30
Circle -955883 true false 98 232 30
Line -16777216 false 45 135 83 121

alvatorre-charge1
false
3
Polygon -1184463 true false -1 156 3 121 15 105 30 114 39 145 29 150
Polygon -16777216 false false -2 155 3 120 14 105 28 113 39 144 29 150
Polygon -6459832 true true 135 45 120 75 90 90 45 135 15 150 -75 165 -120 180 -135 195 -135 225 -120 240 -60 255 15 255 19 243 19 255 60 259 94 259 101 266 112 274 125 280 141 283 150 330 150 -15
Polygon -1184463 true false -135 203 -119 208 -74 198 -43 198 -15 207 29 205 104 215 94 260 52 259 19 255 -60 255 -120 240 -135 225
Rectangle -16777216 false false 210 240 255 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 0 254 15 284 27 276 36 255 15 223
Polygon -16777216 false false 0 255 14 284 25 278 34 256 20 256 19 244 14 255
Polygon -16777216 false false -90 191 -105 210 -105 225 -60 255 15 255 30 210 18 160 -90 180 -105 195
Rectangle -16777216 false false 210 240 255 270
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 301 156 297 121 285 105 270 114 261 145 271 150
Polygon -16777216 false false 302 155 297 120 286 105 272 113 261 144 271 150
Polygon -6459832 true true 165 45 180 75 210 90 255 135 285 150 375 165 420 180 435 195 435 225 420 240 360 255 285 255 281 243 281 255 240 259 206 259 199 266 188 274 175 280 159 283 150 330 150 -15
Circle -1184463 true false 75 135 150
Polygon -16777216 true false 201 197 194 180 187 210 180 180 169 184 168 209 168 212 162 211 156 181 149 176 149 240 162 225 169 225 173 241 184 225 186 239 198 227 194 210
Polygon -16777216 false false 207 258 213 249 218 240 221 232 224 222 225 210 224 197 220 182 213 168 195 145 150 165 150 285 158 285 174 281 187 275 198 267
Polygon -16777216 true false 99 197 106 180 113 210 120 180 131 184 132 209 132 212 138 211 144 181 151 176 151 240 138 225 131 225 127 241 116 225 114 239 102 227 106 210
Rectangle -16777216 false false 210 240 255 270
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -1184463 true false 300 254 285 284 273 276 264 255 285 223
Polygon -1184463 true false 435 203 419 208 374 198 343 198 315 207 271 205 196 215 206 260 248 259 281 255 360 255 420 240 435 225
Polygon -16777216 false false 390 191 405 210 405 225 360 255 285 255 270 210 282 160 390 180 405 195
Polygon -6459832 true true 164 135 166 143 150 149 150 131
Polygon -16777216 true false 185 134 170 104 158 110 166 144
Line -16777216 false 150 -15 165 45
Line -16777216 false 165 45 180 75
Line -16777216 false 180 75 210 90
Line -16777216 false 210 90 255 135
Line -16777216 false 255 135 285 150
Line -16777216 false 15 255 30 210
Line -16777216 false 15 150 30 210
Polygon -16777216 false false 276 187 285 195 315 195 331 190 345 188 361 188 375 188 391 192 406 195 420 198 435 195 420 180 375 165 285 150
Line -16777216 false 157 15 150 8
Line -16777216 false 165 45 150 30
Line -16777216 false 165 144 150 149
Line -16777216 false 210 150 210 135
Line -16777216 false 210 105 165 90
Line -16777216 false 180 95 165 60
Line -16777216 false 195 129 165 144
Line -16777216 false 195 129 204 117
Line -16777216 false 204 118 196 100
Line -16777216 false 165 90 150 102
Line -16777216 false 165 60 150 45
Line -16777216 false 165 90 165 75
Line -16777216 false 165 75 150 68
Line -16777216 false 180 135 218 121
Line -16777216 false 225 105 177 87
Circle -7500403 true false 164 118 13
Polygon -16777216 false false 200 230 195 239 186 250 176 257 163 262 156 263 150 263 157 263 170 260 184 251 194 241 199 232
Polygon -1184463 true false 197 215 224 204 221 189 214 171 195 210
Polygon -1184463 true false 215 170 217 138 200 123 195 131 150 150 150 165 195 145
Polygon -16777216 false false 420 240 389 236 360 240 297 233 280 239 285 255 360 255
Polygon -16777216 false false 135 255 150 330 165 255 149 248
Polygon -16777216 false false 24 187 15 195 -15 195 -31 190 -45 188 -61 188 -75 188 -91 192 -106 195 -120 198 -135 195 -120 180 -75 165 15 150
Polygon -6459832 true true 225 270 240 270 256 274 270 285 195 285 210 274
Rectangle -16777216 false false 225 255 240 270
Line -16777216 false 255 135 217 121
Line -16777216 false 45 135 15 150
Line -16777216 false 90 90 45 135
Line -16777216 false 75 105 123 87
Line -16777216 false 120 75 90 90
Line -16777216 false 135 45 120 75
Line -16777216 false 135 45 150 30
Line -16777216 false 150 -15 135 45
Line -16777216 false 143 15 150 8
Line -16777216 false 135 60 150 45
Line -16777216 false 120 95 135 60
Line -16777216 false 135 75 150 68
Line -16777216 false 135 90 135 75
Line -16777216 false 90 105 135 90
Line -16777216 false 135 90 150 102
Line -16777216 false 96 118 104 100
Polygon -16777216 true false 115 134 130 104 142 110 134 144
Circle -7500403 true false 123 118 13
Line -16777216 false 105 129 96 117
Line -16777216 false 120 135 82 121
Line -16777216 false 105 129 135 144
Line -16777216 false 135 144 150 149
Polygon -6459832 true true 136 135 134 143 150 149 150 131
Polygon -1184463 true false 85 170 83 138 100 123 105 131 150 150 150 165 105 145
Polygon -16777216 false false 100 230 105 239 114 250 124 257 137 262 144 263 150 263 143 263 130 260 116 251 106 241 101 232
Polygon -6459832 true true 75 270 60 270 44 274 30 285 105 285 90 274
Line -16777216 false 225 150 195 210
Line -16777216 false 195 210 206 260
Polygon -16777216 false false 300 255 286 284 275 278 266 256 280 256 281 244 286 255
Line -16777216 false 75 150 105 210
Rectangle -16777216 false false 225 255 240 270
Polygon -1184463 true false 103 215 76 204 79 189 86 171 105 210
Polygon -16777216 false false 93 258 87 249 82 240 79 232 76 222 75 210 76 197 80 182 87 168 105 145 150 165 150 285 142 285 126 281 113 275 102 267
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 60 255 75 270
Polygon -6459832 true true 135 255 150 330 165 255 148 248
Polygon -16777216 false false -120 240 -89 236 -60 240 3 233 20 239 15 255 -60 255
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Line -16777216 false 150 45 150 -15
Polygon -16777216 false false -90 180 75 150 105 210 93 259 58 259 19 255 19 243 19 239 4 233 -14 235 0 225 0 210 -15 195 -42 188 -77 188 -104 195
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 60 255 75 270
Rectangle -16777216 false false 45 240 90 270
Polygon -6459832 true true 255 240 210 240 210 270 255 270
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 210 240 255 270
Circle -16777216 true false 167 120 8
Circle -16777216 true false 125 120 8
Circle -955883 true false 135 150 30
Circle -955883 true false 135 240 30
Circle -955883 true false 180 195 30
Circle -955883 true false 90 195 30
Circle -955883 true false 165 165 30
Circle -955883 true false 105 165 30
Circle -955883 true false 105 225 30
Circle -955883 true false 165 225 30
Line -16777216 false 45 135 83 121

alvatorre-charge1.5
false
3
Polygon -1184463 true false -1 156 3 121 15 105 30 114 39 145 29 150
Polygon -16777216 false false -2 155 3 120 14 105 28 113 39 144 29 150
Polygon -6459832 true true 135 45 120 75 90 90 45 135 15 150 -75 165 -120 180 -135 195 -135 225 -120 240 -60 255 15 255 19 243 19 255 60 259 94 259 101 266 112 274 125 280 141 283 150 330 150 -15
Polygon -1184463 true false -135 203 -119 208 -74 198 -43 198 -15 207 29 205 104 215 94 260 52 259 19 255 -60 255 -120 240 -135 225
Rectangle -16777216 false false 210 240 255 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 0 254 15 284 27 276 36 255 15 223
Polygon -16777216 false false 0 255 14 284 25 278 34 256 20 256 19 244 14 255
Polygon -16777216 false false -90 191 -105 210 -105 225 -60 255 15 255 30 210 18 160 -90 180 -105 195
Rectangle -16777216 false false 210 240 255 270
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 301 156 297 121 285 105 270 114 261 145 271 150
Polygon -16777216 false false 302 155 297 120 286 105 272 113 261 144 271 150
Polygon -6459832 true true 165 45 180 75 210 90 255 135 285 150 375 165 420 180 435 195 435 225 420 240 360 255 285 255 281 243 281 255 240 259 206 259 199 266 188 274 175 280 159 283 150 330 150 -15
Circle -1184463 true false 75 135 150
Polygon -16777216 true false 201 197 194 180 187 210 180 180 169 184 168 209 168 212 162 211 156 181 149 176 149 240 162 225 169 225 173 241 184 225 186 239 198 227 194 210
Polygon -16777216 false false 207 258 213 249 218 240 221 232 224 222 225 210 224 197 220 182 213 168 195 145 150 165 150 285 158 285 174 281 187 275 198 267
Polygon -16777216 true false 99 197 106 180 113 210 120 180 131 184 132 209 132 212 138 211 144 181 151 176 151 240 138 225 131 225 127 241 116 225 114 239 102 227 106 210
Rectangle -16777216 false false 210 240 255 270
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -1184463 true false 300 254 285 284 273 276 264 255 285 223
Polygon -1184463 true false 435 203 419 208 374 198 343 198 315 207 271 205 196 215 206 260 248 259 281 255 360 255 420 240 435 225
Polygon -16777216 false false 390 191 405 210 405 225 360 255 285 255 270 210 282 160 390 180 405 195
Polygon -6459832 true true 164 135 166 143 150 149 150 131
Polygon -16777216 true false 185 134 170 104 158 110 166 144
Line -16777216 false 150 -15 165 45
Line -16777216 false 165 45 180 75
Line -16777216 false 180 75 210 90
Line -16777216 false 210 90 255 135
Line -16777216 false 255 135 285 150
Line -16777216 false 15 255 30 210
Line -16777216 false 15 150 30 210
Polygon -16777216 false false 276 187 285 195 315 195 331 190 345 188 361 188 375 188 391 192 406 195 420 198 435 195 420 180 375 165 285 150
Line -16777216 false 157 15 150 8
Line -16777216 false 165 45 150 30
Line -16777216 false 165 144 150 149
Line -16777216 false 210 150 210 135
Line -16777216 false 210 105 165 90
Line -16777216 false 180 95 165 60
Line -16777216 false 195 129 165 144
Line -16777216 false 195 129 204 117
Line -16777216 false 204 118 196 100
Line -16777216 false 165 90 150 102
Line -16777216 false 165 60 150 45
Line -16777216 false 165 90 165 75
Line -16777216 false 165 75 150 68
Line -16777216 false 180 135 218 121
Line -16777216 false 225 105 177 87
Circle -7500403 true false 164 118 13
Polygon -16777216 false false 200 230 195 239 186 250 176 257 163 262 156 263 150 263 157 263 170 260 184 251 194 241 199 232
Polygon -1184463 true false 197 215 224 204 221 189 214 171 195 210
Polygon -1184463 true false 215 170 217 138 200 123 195 131 150 150 150 165 195 145
Polygon -16777216 false false 420 240 389 236 360 240 297 233 280 239 285 255 360 255
Polygon -16777216 false false 135 255 150 330 165 255 149 248
Polygon -16777216 false false 24 187 15 195 -15 195 -31 190 -45 188 -61 188 -75 188 -91 192 -106 195 -120 198 -135 195 -120 180 -75 165 15 150
Polygon -6459832 true true 225 270 240 270 256 274 270 285 195 285 210 274
Rectangle -16777216 false false 225 255 240 270
Line -16777216 false 255 135 217 121
Line -16777216 false 45 135 15 150
Line -16777216 false 90 90 45 135
Line -16777216 false 75 105 123 87
Line -16777216 false 120 75 90 90
Line -16777216 false 135 45 120 75
Line -16777216 false 135 45 150 30
Line -16777216 false 150 -15 135 45
Line -16777216 false 143 15 150 8
Line -16777216 false 135 60 150 45
Line -16777216 false 120 95 135 60
Line -16777216 false 135 75 150 68
Line -16777216 false 135 90 135 75
Line -16777216 false 90 105 135 90
Line -16777216 false 135 90 150 102
Line -16777216 false 96 118 104 100
Polygon -16777216 true false 115 134 130 104 142 110 134 144
Circle -7500403 true false 123 118 13
Line -16777216 false 105 129 96 117
Line -16777216 false 120 135 82 121
Line -16777216 false 105 129 135 144
Line -16777216 false 135 144 150 149
Polygon -6459832 true true 136 135 134 143 150 149 150 131
Polygon -1184463 true false 85 170 83 138 100 123 105 131 150 150 150 165 105 145
Polygon -16777216 false false 100 230 105 239 114 250 124 257 137 262 144 263 150 263 143 263 130 260 116 251 106 241 101 232
Polygon -6459832 true true 75 270 60 270 44 274 30 285 105 285 90 274
Line -16777216 false 225 150 195 210
Line -16777216 false 195 210 206 260
Polygon -16777216 false false 300 255 286 284 275 278 266 256 280 256 281 244 286 255
Line -16777216 false 75 150 105 210
Rectangle -16777216 false false 225 255 240 270
Polygon -1184463 true false 103 215 76 204 79 189 86 171 105 210
Polygon -16777216 false false 93 258 87 249 82 240 79 232 76 222 75 210 76 197 80 182 87 168 105 145 150 165 150 285 142 285 126 281 113 275 102 267
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 60 255 75 270
Polygon -6459832 true true 135 255 150 330 165 255 148 248
Polygon -16777216 false false -120 240 -89 236 -60 240 3 233 20 239 15 255 -60 255
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Line -16777216 false 150 45 150 -15
Polygon -16777216 false false -90 180 75 150 105 210 93 259 58 259 19 255 19 243 19 239 4 233 -14 235 0 225 0 210 -15 195 -42 188 -77 188 -104 195
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 60 255 75 270
Rectangle -16777216 false false 45 240 90 270
Polygon -6459832 true true 255 240 210 240 210 270 255 270
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 210 240 255 270
Circle -16777216 true false 167 120 8
Circle -16777216 true false 125 120 8
Circle -955883 true false 135 165 30
Circle -955883 true false 135 225 30
Circle -955883 true false 165 195 30
Circle -955883 true false 105 195 30
Circle -955883 true false 150 180 30
Circle -955883 true false 120 180 30
Circle -955883 true false 120 210 30
Circle -955883 true false 150 210 30
Line -16777216 false 45 135 83 121

alvatorre-charge2
false
3
Polygon -1184463 true false -1 156 3 121 15 105 30 114 39 145 29 150
Polygon -16777216 false false -2 155 3 120 14 105 28 113 39 144 29 150
Polygon -6459832 true true 135 45 120 75 90 90 45 135 15 150 -75 165 -120 180 -135 195 -135 225 -120 240 -60 255 15 255 19 243 19 255 60 259 94 259 101 266 112 274 125 280 141 283 150 330 150 -15
Polygon -1184463 true false -135 203 -119 208 -74 198 -43 198 -15 207 29 205 104 215 94 260 52 259 19 255 -60 255 -120 240 -135 225
Rectangle -16777216 false false 210 240 255 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 0 254 15 284 27 276 36 255 15 223
Polygon -16777216 false false 0 255 14 284 25 278 34 256 20 256 19 244 14 255
Polygon -16777216 false false -90 191 -105 210 -105 225 -60 255 15 255 30 210 18 160 -90 180 -105 195
Rectangle -16777216 false false 210 240 255 270
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 301 156 297 121 285 105 270 114 261 145 271 150
Polygon -16777216 false false 302 155 297 120 286 105 272 113 261 144 271 150
Polygon -6459832 true true 165 45 180 75 210 90 255 135 285 150 375 165 420 180 435 195 435 225 420 240 360 255 285 255 281 243 281 255 240 259 206 259 199 266 188 274 175 280 159 283 150 330 150 -15
Circle -1184463 true false 75 135 150
Polygon -16777216 true false 201 197 194 180 187 210 180 180 169 184 168 209 168 212 162 211 156 181 149 176 149 240 162 225 169 225 173 241 184 225 186 239 198 227 194 210
Polygon -16777216 false false 207 258 213 249 218 240 221 232 224 222 225 210 224 197 220 182 213 168 195 145 150 165 150 285 158 285 174 281 187 275 198 267
Polygon -16777216 true false 99 197 106 180 113 210 120 180 131 184 132 209 132 212 138 211 144 181 151 176 151 240 138 225 131 225 127 241 116 225 114 239 102 227 106 210
Rectangle -16777216 false false 210 240 255 270
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -1184463 true false 300 254 285 284 273 276 264 255 285 223
Polygon -1184463 true false 435 203 419 208 374 198 343 198 315 207 271 205 196 215 206 260 248 259 281 255 360 255 420 240 435 225
Polygon -16777216 false false 390 191 405 210 405 225 360 255 285 255 270 210 282 160 390 180 405 195
Polygon -6459832 true true 164 135 166 143 150 149 150 131
Polygon -16777216 true false 185 134 170 104 158 110 166 144
Line -16777216 false 150 -15 165 45
Line -16777216 false 165 45 180 75
Line -16777216 false 180 75 210 90
Line -16777216 false 210 90 255 135
Line -16777216 false 255 135 285 150
Line -16777216 false 15 255 30 210
Line -16777216 false 15 150 30 210
Polygon -16777216 false false 276 187 285 195 315 195 331 190 345 188 361 188 375 188 391 192 406 195 420 198 435 195 420 180 375 165 285 150
Line -16777216 false 157 15 150 8
Line -16777216 false 165 45 150 30
Line -16777216 false 165 144 150 149
Line -16777216 false 210 150 210 135
Line -16777216 false 210 105 165 90
Line -16777216 false 180 95 165 60
Line -16777216 false 195 129 165 144
Line -16777216 false 195 129 204 117
Line -16777216 false 204 118 196 100
Line -16777216 false 165 90 150 102
Line -16777216 false 165 60 150 45
Line -16777216 false 165 90 165 75
Line -16777216 false 165 75 150 68
Line -16777216 false 180 135 218 121
Line -16777216 false 225 105 177 87
Circle -7500403 true false 164 118 13
Polygon -16777216 false false 200 230 195 239 186 250 176 257 163 262 156 263 150 263 157 263 170 260 184 251 194 241 199 232
Polygon -1184463 true false 197 215 224 204 221 189 214 171 195 210
Polygon -1184463 true false 215 170 217 138 200 123 195 131 150 150 150 165 195 145
Polygon -16777216 false false 420 240 389 236 360 240 297 233 280 239 285 255 360 255
Polygon -16777216 false false 135 255 150 330 165 255 149 248
Polygon -16777216 false false 24 187 15 195 -15 195 -31 190 -45 188 -61 188 -75 188 -91 192 -106 195 -120 198 -135 195 -120 180 -75 165 15 150
Polygon -6459832 true true 225 270 240 270 256 274 270 285 195 285 210 274
Rectangle -16777216 false false 225 255 240 270
Line -16777216 false 255 135 217 121
Line -16777216 false 45 135 15 150
Line -16777216 false 90 90 45 135
Line -16777216 false 75 105 123 87
Line -16777216 false 120 75 90 90
Line -16777216 false 135 45 120 75
Line -16777216 false 135 45 150 30
Line -16777216 false 150 -15 135 45
Line -16777216 false 143 15 150 8
Line -16777216 false 135 60 150 45
Line -16777216 false 120 95 135 60
Line -16777216 false 135 75 150 68
Line -16777216 false 135 90 135 75
Line -16777216 false 90 105 135 90
Line -16777216 false 135 90 150 102
Line -16777216 false 96 118 104 100
Polygon -16777216 true false 115 134 130 104 142 110 134 144
Circle -7500403 true false 123 118 13
Line -16777216 false 105 129 96 117
Line -16777216 false 120 135 82 121
Line -16777216 false 105 129 135 144
Line -16777216 false 135 144 150 149
Polygon -6459832 true true 136 135 134 143 150 149 150 131
Polygon -1184463 true false 85 170 83 138 100 123 105 131 150 150 150 165 105 145
Polygon -16777216 false false 100 230 105 239 114 250 124 257 137 262 144 263 150 263 143 263 130 260 116 251 106 241 101 232
Polygon -6459832 true true 75 270 60 270 44 274 30 285 105 285 90 274
Line -16777216 false 225 150 195 210
Line -16777216 false 195 210 206 260
Polygon -16777216 false false 300 255 286 284 275 278 266 256 280 256 281 244 286 255
Line -16777216 false 75 150 105 210
Rectangle -16777216 false false 225 255 240 270
Polygon -1184463 true false 103 215 76 204 79 189 86 171 105 210
Polygon -16777216 false false 93 258 87 249 82 240 79 232 76 222 75 210 76 197 80 182 87 168 105 145 150 165 150 285 142 285 126 281 113 275 102 267
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 60 255 75 270
Polygon -6459832 true true 135 255 150 330 165 255 148 248
Polygon -16777216 false false -120 240 -89 236 -60 240 3 233 20 239 15 255 -60 255
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Line -16777216 false 150 45 150 -15
Polygon -16777216 false false -90 180 75 150 105 210 93 259 58 259 19 255 19 243 19 239 4 233 -14 235 0 225 0 210 -15 195 -42 188 -77 188 -104 195
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 60 255 75 270
Rectangle -16777216 false false 45 240 90 270
Polygon -6459832 true true 255 240 210 240 210 270 255 270
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 210 240 255 270
Circle -16777216 true false 167 120 8
Circle -16777216 true false 125 120 8
Circle -955883 true false 129 189 42
Line -16777216 false 45 135 83 121

alvatorre-charge3
false
3
Polygon -1184463 true false -1 156 3 121 15 105 30 114 39 145 29 150
Polygon -16777216 false false -2 155 3 120 14 105 28 113 39 144 29 150
Polygon -6459832 true true 135 45 120 75 90 90 45 135 15 150 -75 165 -120 180 -135 195 -135 225 -120 240 -60 255 15 255 19 243 19 255 60 259 94 259 101 266 112 274 125 280 141 283 150 330 150 -15
Polygon -1184463 true false -135 203 -119 208 -74 198 -43 198 -15 207 29 205 104 215 94 260 52 259 19 255 -60 255 -120 240 -135 225
Rectangle -16777216 false false 210 240 255 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 0 254 15 284 27 276 36 255 15 223
Polygon -16777216 false false 0 255 14 284 25 278 34 256 20 256 19 244 14 255
Polygon -16777216 false false -90 191 -105 210 -105 225 -60 255 15 255 30 210 18 160 -90 180 -105 195
Rectangle -16777216 false false 210 240 255 270
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 301 156 297 121 285 105 270 114 261 145 271 150
Polygon -16777216 false false 302 155 297 120 286 105 272 113 261 144 271 150
Polygon -6459832 true true 165 45 180 75 210 90 255 135 285 150 375 165 420 180 435 195 435 225 420 240 360 255 285 255 281 243 281 255 240 259 206 259 199 266 188 274 175 280 159 283 150 330 150 -15
Circle -1184463 true false 75 135 150
Polygon -16777216 true false 201 197 194 180 187 210 180 180 169 184 168 209 168 212 162 211 156 181 149 176 149 240 162 225 169 225 173 241 184 225 186 239 198 227 194 210
Polygon -16777216 false false 207 258 213 249 218 240 221 232 224 222 225 210 224 197 220 182 213 168 195 145 150 165 150 285 158 285 174 281 187 275 198 267
Polygon -16777216 true false 99 197 106 180 113 210 120 180 131 184 132 209 132 212 138 211 144 181 151 176 151 240 138 225 131 225 127 241 116 225 114 239 102 227 106 210
Rectangle -16777216 false false 210 240 255 270
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -1184463 true false 300 254 285 284 273 276 264 255 285 223
Polygon -1184463 true false 435 203 419 208 374 198 343 198 315 207 271 205 196 215 206 260 248 259 281 255 360 255 420 240 435 225
Polygon -16777216 false false 390 191 405 210 405 225 360 255 285 255 270 210 282 160 390 180 405 195
Polygon -6459832 true true 164 135 166 143 150 149 150 131
Polygon -16777216 true false 185 134 170 104 158 110 166 144
Line -16777216 false 150 -15 165 45
Line -16777216 false 165 45 180 75
Line -16777216 false 180 75 210 90
Line -16777216 false 210 90 255 135
Line -16777216 false 255 135 285 150
Line -16777216 false 15 255 30 210
Line -16777216 false 15 150 30 210
Polygon -16777216 false false 276 187 285 195 315 195 331 190 345 188 361 188 375 188 391 192 406 195 420 198 435 195 420 180 375 165 285 150
Line -16777216 false 157 15 150 8
Line -16777216 false 165 45 150 30
Line -16777216 false 165 144 150 149
Line -16777216 false 210 150 210 135
Line -16777216 false 210 105 165 90
Line -16777216 false 180 95 165 60
Line -16777216 false 195 129 165 144
Line -16777216 false 195 129 204 117
Line -16777216 false 204 118 196 100
Line -16777216 false 165 90 150 102
Line -16777216 false 165 60 150 45
Line -16777216 false 165 90 165 75
Line -16777216 false 165 75 150 68
Line -16777216 false 180 135 218 121
Line -16777216 false 225 105 177 87
Circle -7500403 true false 164 118 13
Polygon -16777216 false false 200 230 195 239 186 250 176 257 163 262 156 263 150 263 157 263 170 260 184 251 194 241 199 232
Polygon -1184463 true false 197 215 224 204 221 189 214 171 195 210
Polygon -1184463 true false 215 170 217 138 200 123 195 131 150 150 150 165 195 145
Polygon -16777216 false false 420 240 389 236 360 240 297 233 280 239 285 255 360 255
Polygon -16777216 false false 135 255 150 330 165 255 149 248
Polygon -16777216 false false 24 187 15 195 -15 195 -31 190 -45 188 -61 188 -75 188 -91 192 -106 195 -120 198 -135 195 -120 180 -75 165 15 150
Polygon -6459832 true true 225 270 240 270 256 274 270 285 195 285 210 274
Rectangle -16777216 false false 225 255 240 270
Line -16777216 false 255 135 217 121
Line -16777216 false 45 135 15 150
Line -16777216 false 90 90 45 135
Line -16777216 false 75 105 123 87
Line -16777216 false 120 75 90 90
Line -16777216 false 135 45 120 75
Line -16777216 false 135 45 150 30
Line -16777216 false 150 -15 135 45
Line -16777216 false 143 15 150 8
Line -16777216 false 135 60 150 45
Line -16777216 false 120 95 135 60
Line -16777216 false 135 75 150 68
Line -16777216 false 135 90 135 75
Line -16777216 false 90 105 135 90
Line -16777216 false 135 90 150 102
Line -16777216 false 96 118 104 100
Polygon -16777216 true false 115 134 130 104 142 110 134 144
Circle -7500403 true false 123 118 13
Line -16777216 false 105 129 96 117
Line -16777216 false 120 135 82 121
Line -16777216 false 105 129 135 144
Line -16777216 false 135 144 150 149
Polygon -6459832 true true 136 135 134 143 150 149 150 131
Polygon -1184463 true false 85 170 83 138 100 123 105 131 150 150 150 165 105 145
Polygon -16777216 false false 100 230 105 239 114 250 124 257 137 262 144 263 150 263 143 263 130 260 116 251 106 241 101 232
Polygon -6459832 true true 75 270 60 270 44 274 30 285 105 285 90 274
Line -16777216 false 225 150 195 210
Line -16777216 false 195 210 206 260
Polygon -16777216 false false 300 255 286 284 275 278 266 256 280 256 281 244 286 255
Line -16777216 false 75 150 105 210
Rectangle -16777216 false false 225 255 240 270
Polygon -1184463 true false 103 215 76 204 79 189 86 171 105 210
Polygon -16777216 false false 93 258 87 249 82 240 79 232 76 222 75 210 76 197 80 182 87 168 105 145 150 165 150 285 142 285 126 281 113 275 102 267
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 60 255 75 270
Polygon -6459832 true true 135 255 150 330 165 255 148 248
Polygon -16777216 false false -120 240 -89 236 -60 240 3 233 20 239 15 255 -60 255
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Line -16777216 false 150 45 150 -15
Polygon -16777216 false false -90 180 75 150 105 210 93 259 58 259 19 255 19 243 19 239 4 233 -14 235 0 225 0 210 -15 195 -42 188 -77 188 -104 195
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 60 255 75 270
Rectangle -16777216 false false 45 240 90 270
Polygon -6459832 true true 255 240 210 240 210 270 255 270
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 210 240 255 270
Circle -16777216 true false 167 120 8
Circle -16777216 true false 125 120 8
Circle -955883 true false 135 120 30
Circle -955883 true false 135 270 30
Circle -955883 true false 210 195 30
Circle -955883 true false 60 195 30
Circle -955883 true false 180 150 30
Circle -955883 true false 90 150 30
Circle -955883 true false 90 240 30
Circle -955883 true false 180 240 30
Circle -955883 true false 129 189 42
Line -16777216 false 45 135 83 121

alvatorre-charge3.5
false
3
Polygon -1184463 true false -1 156 3 121 15 105 30 114 39 145 29 150
Polygon -16777216 false false -2 155 3 120 14 105 28 113 39 144 29 150
Polygon -6459832 true true 135 45 120 75 90 90 45 135 15 150 -75 165 -120 180 -135 195 -135 225 -120 240 -60 255 15 255 19 243 19 255 60 259 94 259 101 266 112 274 125 280 141 283 150 330 150 -15
Polygon -1184463 true false -135 203 -119 208 -74 198 -43 198 -15 207 29 205 104 215 94 260 52 259 19 255 -60 255 -120 240 -135 225
Rectangle -16777216 false false 210 240 255 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 0 254 15 284 27 276 36 255 15 223
Polygon -16777216 false false 0 255 14 284 25 278 34 256 20 256 19 244 14 255
Polygon -16777216 false false -90 191 -105 210 -105 225 -60 255 15 255 30 210 18 160 -90 180 -105 195
Rectangle -16777216 false false 210 240 255 270
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 301 156 297 121 285 105 270 114 261 145 271 150
Polygon -16777216 false false 302 155 297 120 286 105 272 113 261 144 271 150
Polygon -6459832 true true 165 45 180 75 210 90 255 135 285 150 375 165 420 180 435 195 435 225 420 240 360 255 285 255 281 243 281 255 240 259 206 259 199 266 188 274 175 280 159 283 150 330 150 -15
Circle -1184463 true false 75 135 150
Polygon -16777216 true false 201 197 194 180 187 210 180 180 169 184 168 209 168 212 162 211 156 181 149 176 149 240 162 225 169 225 173 241 184 225 186 239 198 227 194 210
Polygon -16777216 false false 207 258 213 249 218 240 221 232 224 222 225 210 224 197 220 182 213 168 195 145 150 165 150 285 158 285 174 281 187 275 198 267
Polygon -16777216 true false 99 197 106 180 113 210 120 180 131 184 132 209 132 212 138 211 144 181 151 176 151 240 138 225 131 225 127 241 116 225 114 239 102 227 106 210
Rectangle -16777216 false false 210 240 255 270
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -1184463 true false 300 254 285 284 273 276 264 255 285 223
Polygon -1184463 true false 435 203 419 208 374 198 343 198 315 207 271 205 196 215 206 260 248 259 281 255 360 255 420 240 435 225
Polygon -16777216 false false 390 191 405 210 405 225 360 255 285 255 270 210 282 160 390 180 405 195
Polygon -6459832 true true 164 135 166 143 150 149 150 131
Polygon -16777216 true false 185 134 170 104 158 110 166 144
Line -16777216 false 150 -15 165 45
Line -16777216 false 165 45 180 75
Line -16777216 false 180 75 210 90
Line -16777216 false 210 90 255 135
Line -16777216 false 255 135 285 150
Line -16777216 false 15 255 30 210
Line -16777216 false 15 150 30 210
Polygon -16777216 false false 276 187 285 195 315 195 331 190 345 188 361 188 375 188 391 192 406 195 420 198 435 195 420 180 375 165 285 150
Line -16777216 false 157 15 150 8
Line -16777216 false 165 45 150 30
Line -16777216 false 165 144 150 149
Line -16777216 false 210 150 210 135
Line -16777216 false 210 105 165 90
Line -16777216 false 180 95 165 60
Line -16777216 false 195 129 165 144
Line -16777216 false 195 129 204 117
Line -16777216 false 204 118 196 100
Line -16777216 false 165 90 150 102
Line -16777216 false 165 60 150 45
Line -16777216 false 165 90 165 75
Line -16777216 false 165 75 150 68
Line -16777216 false 180 135 218 121
Line -16777216 false 225 105 177 87
Circle -7500403 true false 164 118 13
Polygon -16777216 false false 200 230 195 239 186 250 176 257 163 262 156 263 150 263 157 263 170 260 184 251 194 241 199 232
Polygon -1184463 true false 197 215 224 204 221 189 214 171 195 210
Polygon -1184463 true false 215 170 217 138 200 123 195 131 150 150 150 165 195 145
Polygon -16777216 false false 420 240 389 236 360 240 297 233 280 239 285 255 360 255
Polygon -16777216 false false 135 255 150 330 165 255 149 248
Polygon -16777216 false false 24 187 15 195 -15 195 -31 190 -45 188 -61 188 -75 188 -91 192 -106 195 -120 198 -135 195 -120 180 -75 165 15 150
Polygon -6459832 true true 225 270 240 270 256 274 270 285 195 285 210 274
Rectangle -16777216 false false 225 255 240 270
Line -16777216 false 255 135 217 121
Line -16777216 false 45 135 15 150
Line -16777216 false 90 90 45 135
Line -16777216 false 75 105 123 87
Line -16777216 false 120 75 90 90
Line -16777216 false 135 45 120 75
Line -16777216 false 135 45 150 30
Line -16777216 false 150 -15 135 45
Line -16777216 false 143 15 150 8
Line -16777216 false 135 60 150 45
Line -16777216 false 120 95 135 60
Line -16777216 false 135 75 150 68
Line -16777216 false 135 90 135 75
Line -16777216 false 90 105 135 90
Line -16777216 false 135 90 150 102
Line -16777216 false 96 118 104 100
Polygon -16777216 true false 115 134 130 104 142 110 134 144
Circle -7500403 true false 123 118 13
Line -16777216 false 105 129 96 117
Line -16777216 false 120 135 82 121
Line -16777216 false 105 129 135 144
Line -16777216 false 135 144 150 149
Polygon -6459832 true true 136 135 134 143 150 149 150 131
Polygon -1184463 true false 85 170 83 138 100 123 105 131 150 150 150 165 105 145
Polygon -16777216 false false 100 230 105 239 114 250 124 257 137 262 144 263 150 263 143 263 130 260 116 251 106 241 101 232
Polygon -6459832 true true 75 270 60 270 44 274 30 285 105 285 90 274
Line -16777216 false 225 150 195 210
Line -16777216 false 195 210 206 260
Polygon -16777216 false false 300 255 286 284 275 278 266 256 280 256 281 244 286 255
Line -16777216 false 75 150 105 210
Rectangle -16777216 false false 225 255 240 270
Polygon -1184463 true false 103 215 76 204 79 189 86 171 105 210
Polygon -16777216 false false 93 258 87 249 82 240 79 232 76 222 75 210 76 197 80 182 87 168 105 145 150 165 150 285 142 285 126 281 113 275 102 267
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 60 255 75 270
Polygon -6459832 true true 135 255 150 330 165 255 148 248
Polygon -16777216 false false -120 240 -89 236 -60 240 3 233 20 239 15 255 -60 255
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Line -16777216 false 150 45 150 -15
Polygon -16777216 false false -90 180 75 150 105 210 93 259 58 259 19 255 19 243 19 239 4 233 -14 235 0 225 0 210 -15 195 -42 188 -77 188 -104 195
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 60 255 75 270
Rectangle -16777216 false false 45 240 90 270
Polygon -6459832 true true 255 240 210 240 210 270 255 270
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 210 240 255 270
Circle -16777216 true false 167 120 8
Circle -16777216 true false 125 120 8
Circle -955883 true false 135 135 30
Circle -955883 true false 135 255 30
Circle -955883 true false 195 195 30
Circle -955883 true false 75 195 30
Circle -955883 true false 172 157 30
Circle -955883 true false 98 157 30
Circle -955883 true false 172 232 30
Circle -955883 true false 98 232 30
Circle -955883 true false 129 189 42
Line -16777216 false 45 135 83 121

alvatorre-charge4
false
3
Polygon -1184463 true false -1 156 3 121 15 105 30 114 39 145 29 150
Polygon -16777216 false false -2 155 3 120 14 105 28 113 39 144 29 150
Polygon -6459832 true true 135 45 120 75 90 90 45 135 15 150 -75 165 -120 180 -135 195 -135 225 -120 240 -60 255 15 255 19 243 19 255 60 259 94 259 101 266 112 274 125 280 141 283 150 330 150 -15
Polygon -1184463 true false -135 203 -119 208 -74 198 -43 198 -15 207 29 205 104 215 94 260 52 259 19 255 -60 255 -120 240 -135 225
Rectangle -16777216 false false 210 240 255 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 0 254 15 284 27 276 36 255 15 223
Polygon -16777216 false false 0 255 14 284 25 278 34 256 20 256 19 244 14 255
Polygon -16777216 false false -90 191 -105 210 -105 225 -60 255 15 255 30 210 18 160 -90 180 -105 195
Rectangle -16777216 false false 210 240 255 270
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 301 156 297 121 285 105 270 114 261 145 271 150
Polygon -16777216 false false 302 155 297 120 286 105 272 113 261 144 271 150
Polygon -6459832 true true 165 45 180 75 210 90 255 135 285 150 375 165 420 180 435 195 435 225 420 240 360 255 285 255 281 243 281 255 240 259 206 259 199 266 188 274 175 280 159 283 150 330 150 -15
Circle -1184463 true false 75 135 150
Polygon -16777216 true false 201 197 194 180 187 210 180 180 169 184 168 209 168 212 162 211 156 181 149 176 149 240 162 225 169 225 173 241 184 225 186 239 198 227 194 210
Polygon -16777216 false false 207 258 213 249 218 240 221 232 224 222 225 210 224 197 220 182 213 168 195 145 150 165 150 285 158 285 174 281 187 275 198 267
Polygon -16777216 true false 99 197 106 180 113 210 120 180 131 184 132 209 132 212 138 211 144 181 151 176 151 240 138 225 131 225 127 241 116 225 114 239 102 227 106 210
Rectangle -16777216 false false 210 240 255 270
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -1184463 true false 300 254 285 284 273 276 264 255 285 223
Polygon -1184463 true false 435 203 419 208 374 198 343 198 315 207 271 205 196 215 206 260 248 259 281 255 360 255 420 240 435 225
Polygon -16777216 false false 390 191 405 210 405 225 360 255 285 255 270 210 282 160 390 180 405 195
Polygon -6459832 true true 164 135 166 143 150 149 150 131
Polygon -16777216 true false 185 134 170 104 158 110 166 144
Line -16777216 false 150 -15 165 45
Line -16777216 false 165 45 180 75
Line -16777216 false 180 75 210 90
Line -16777216 false 210 90 255 135
Line -16777216 false 255 135 285 150
Line -16777216 false 15 255 30 210
Line -16777216 false 15 150 30 210
Polygon -16777216 false false 276 187 285 195 315 195 331 190 345 188 361 188 375 188 391 192 406 195 420 198 435 195 420 180 375 165 285 150
Line -16777216 false 157 15 150 8
Line -16777216 false 165 45 150 30
Line -16777216 false 165 144 150 149
Line -16777216 false 210 150 210 135
Line -16777216 false 210 105 165 90
Line -16777216 false 180 95 165 60
Line -16777216 false 195 129 165 144
Line -16777216 false 195 129 204 117
Line -16777216 false 204 118 196 100
Line -16777216 false 165 90 150 102
Line -16777216 false 165 60 150 45
Line -16777216 false 165 90 165 75
Line -16777216 false 165 75 150 68
Line -16777216 false 180 135 218 121
Line -16777216 false 225 105 177 87
Circle -7500403 true false 164 118 13
Polygon -16777216 false false 200 230 195 239 186 250 176 257 163 262 156 263 150 263 157 263 170 260 184 251 194 241 199 232
Polygon -1184463 true false 197 215 224 204 221 189 214 171 195 210
Polygon -1184463 true false 215 170 217 138 200 123 195 131 150 150 150 165 195 145
Polygon -16777216 false false 420 240 389 236 360 240 297 233 280 239 285 255 360 255
Polygon -16777216 false false 135 255 150 330 165 255 149 248
Polygon -16777216 false false 24 187 15 195 -15 195 -31 190 -45 188 -61 188 -75 188 -91 192 -106 195 -120 198 -135 195 -120 180 -75 165 15 150
Polygon -6459832 true true 225 270 240 270 256 274 270 285 195 285 210 274
Rectangle -16777216 false false 225 255 240 270
Line -16777216 false 255 135 217 121
Line -16777216 false 45 135 15 150
Line -16777216 false 90 90 45 135
Line -16777216 false 75 105 123 87
Line -16777216 false 120 75 90 90
Line -16777216 false 135 45 120 75
Line -16777216 false 135 45 150 30
Line -16777216 false 150 -15 135 45
Line -16777216 false 143 15 150 8
Line -16777216 false 135 60 150 45
Line -16777216 false 120 95 135 60
Line -16777216 false 135 75 150 68
Line -16777216 false 135 90 135 75
Line -16777216 false 90 105 135 90
Line -16777216 false 135 90 150 102
Line -16777216 false 96 118 104 100
Polygon -16777216 true false 115 134 130 104 142 110 134 144
Circle -7500403 true false 123 118 13
Line -16777216 false 105 129 96 117
Line -16777216 false 120 135 82 121
Line -16777216 false 105 129 135 144
Line -16777216 false 135 144 150 149
Polygon -6459832 true true 136 135 134 143 150 149 150 131
Polygon -1184463 true false 85 170 83 138 100 123 105 131 150 150 150 165 105 145
Polygon -16777216 false false 100 230 105 239 114 250 124 257 137 262 144 263 150 263 143 263 130 260 116 251 106 241 101 232
Polygon -6459832 true true 75 270 60 270 44 274 30 285 105 285 90 274
Line -16777216 false 225 150 195 210
Line -16777216 false 195 210 206 260
Polygon -16777216 false false 300 255 286 284 275 278 266 256 280 256 281 244 286 255
Line -16777216 false 75 150 105 210
Rectangle -16777216 false false 225 255 240 270
Polygon -1184463 true false 103 215 76 204 79 189 86 171 105 210
Polygon -16777216 false false 93 258 87 249 82 240 79 232 76 222 75 210 76 197 80 182 87 168 105 145 150 165 150 285 142 285 126 281 113 275 102 267
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 60 255 75 270
Polygon -6459832 true true 135 255 150 330 165 255 148 248
Polygon -16777216 false false -120 240 -89 236 -60 240 3 233 20 239 15 255 -60 255
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Line -16777216 false 150 45 150 -15
Polygon -16777216 false false -90 180 75 150 105 210 93 259 58 259 19 255 19 243 19 239 4 233 -14 235 0 225 0 210 -15 195 -42 188 -77 188 -104 195
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 60 255 75 270
Rectangle -16777216 false false 45 240 90 270
Polygon -6459832 true true 255 240 210 240 210 270 255 270
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 210 240 255 270
Circle -16777216 true false 167 120 8
Circle -16777216 true false 125 120 8
Circle -955883 true false 135 150 30
Circle -955883 true false 135 240 30
Circle -955883 true false 180 195 30
Circle -955883 true false 90 195 30
Circle -955883 true false 165 165 30
Circle -955883 true false 105 165 30
Circle -955883 true false 105 225 30
Circle -955883 true false 165 225 30
Circle -955883 true false 129 189 42
Line -16777216 false 45 135 83 121

alvatorre-charge4.5
false
3
Polygon -1184463 true false -1 156 3 121 15 105 30 114 39 145 29 150
Polygon -16777216 false false -2 155 3 120 14 105 28 113 39 144 29 150
Polygon -6459832 true true 135 45 120 75 90 90 45 135 15 150 -75 165 -120 180 -135 195 -135 225 -120 240 -60 255 15 255 19 243 19 255 60 259 94 259 101 266 112 274 125 280 141 283 150 330 150 -15
Polygon -1184463 true false -135 203 -119 208 -74 198 -43 198 -15 207 29 205 104 215 94 260 52 259 19 255 -60 255 -120 240 -135 225
Rectangle -16777216 false false 210 240 255 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 0 254 15 284 27 276 36 255 15 223
Polygon -16777216 false false 0 255 14 284 25 278 34 256 20 256 19 244 14 255
Polygon -16777216 false false -90 191 -105 210 -105 225 -60 255 15 255 30 210 18 160 -90 180 -105 195
Rectangle -16777216 false false 210 240 255 270
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 301 156 297 121 285 105 270 114 261 145 271 150
Polygon -16777216 false false 302 155 297 120 286 105 272 113 261 144 271 150
Polygon -6459832 true true 165 45 180 75 210 90 255 135 285 150 375 165 420 180 435 195 435 225 420 240 360 255 285 255 281 243 281 255 240 259 206 259 199 266 188 274 175 280 159 283 150 330 150 -15
Circle -1184463 true false 75 135 150
Polygon -16777216 true false 201 197 194 180 187 210 180 180 169 184 168 209 168 212 162 211 156 181 149 176 149 240 162 225 169 225 173 241 184 225 186 239 198 227 194 210
Polygon -16777216 false false 207 258 213 249 218 240 221 232 224 222 225 210 224 197 220 182 213 168 195 145 150 165 150 285 158 285 174 281 187 275 198 267
Polygon -16777216 true false 99 197 106 180 113 210 120 180 131 184 132 209 132 212 138 211 144 181 151 176 151 240 138 225 131 225 127 241 116 225 114 239 102 227 106 210
Rectangle -16777216 false false 210 240 255 270
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -1184463 true false 300 254 285 284 273 276 264 255 285 223
Polygon -1184463 true false 435 203 419 208 374 198 343 198 315 207 271 205 196 215 206 260 248 259 281 255 360 255 420 240 435 225
Polygon -16777216 false false 390 191 405 210 405 225 360 255 285 255 270 210 282 160 390 180 405 195
Polygon -6459832 true true 164 135 166 143 150 149 150 131
Polygon -16777216 true false 185 134 170 104 158 110 166 144
Line -16777216 false 150 -15 165 45
Line -16777216 false 165 45 180 75
Line -16777216 false 180 75 210 90
Line -16777216 false 210 90 255 135
Line -16777216 false 255 135 285 150
Line -16777216 false 15 255 30 210
Line -16777216 false 15 150 30 210
Polygon -16777216 false false 276 187 285 195 315 195 331 190 345 188 361 188 375 188 391 192 406 195 420 198 435 195 420 180 375 165 285 150
Line -16777216 false 157 15 150 8
Line -16777216 false 165 45 150 30
Line -16777216 false 165 144 150 149
Line -16777216 false 210 150 210 135
Line -16777216 false 210 105 165 90
Line -16777216 false 180 95 165 60
Line -16777216 false 195 129 165 144
Line -16777216 false 195 129 204 117
Line -16777216 false 204 118 196 100
Line -16777216 false 165 90 150 102
Line -16777216 false 165 60 150 45
Line -16777216 false 165 90 165 75
Line -16777216 false 165 75 150 68
Line -16777216 false 180 135 218 121
Line -16777216 false 225 105 177 87
Circle -7500403 true false 164 118 13
Polygon -16777216 false false 200 230 195 239 186 250 176 257 163 262 156 263 150 263 157 263 170 260 184 251 194 241 199 232
Polygon -1184463 true false 197 215 224 204 221 189 214 171 195 210
Polygon -1184463 true false 215 170 217 138 200 123 195 131 150 150 150 165 195 145
Polygon -16777216 false false 420 240 389 236 360 240 297 233 280 239 285 255 360 255
Polygon -16777216 false false 135 255 150 330 165 255 149 248
Polygon -16777216 false false 24 187 15 195 -15 195 -31 190 -45 188 -61 188 -75 188 -91 192 -106 195 -120 198 -135 195 -120 180 -75 165 15 150
Polygon -6459832 true true 225 270 240 270 256 274 270 285 195 285 210 274
Rectangle -16777216 false false 225 255 240 270
Line -16777216 false 255 135 217 121
Line -16777216 false 45 135 15 150
Line -16777216 false 90 90 45 135
Line -16777216 false 75 105 123 87
Line -16777216 false 120 75 90 90
Line -16777216 false 135 45 120 75
Line -16777216 false 135 45 150 30
Line -16777216 false 150 -15 135 45
Line -16777216 false 143 15 150 8
Line -16777216 false 135 60 150 45
Line -16777216 false 120 95 135 60
Line -16777216 false 135 75 150 68
Line -16777216 false 135 90 135 75
Line -16777216 false 90 105 135 90
Line -16777216 false 135 90 150 102
Line -16777216 false 96 118 104 100
Polygon -16777216 true false 115 134 130 104 142 110 134 144
Circle -7500403 true false 123 118 13
Line -16777216 false 105 129 96 117
Line -16777216 false 120 135 82 121
Line -16777216 false 105 129 135 144
Line -16777216 false 135 144 150 149
Polygon -6459832 true true 136 135 134 143 150 149 150 131
Polygon -1184463 true false 85 170 83 138 100 123 105 131 150 150 150 165 105 145
Polygon -16777216 false false 100 230 105 239 114 250 124 257 137 262 144 263 150 263 143 263 130 260 116 251 106 241 101 232
Polygon -6459832 true true 75 270 60 270 44 274 30 285 105 285 90 274
Line -16777216 false 225 150 195 210
Line -16777216 false 195 210 206 260
Polygon -16777216 false false 300 255 286 284 275 278 266 256 280 256 281 244 286 255
Line -16777216 false 75 150 105 210
Rectangle -16777216 false false 225 255 240 270
Polygon -1184463 true false 103 215 76 204 79 189 86 171 105 210
Polygon -16777216 false false 93 258 87 249 82 240 79 232 76 222 75 210 76 197 80 182 87 168 105 145 150 165 150 285 142 285 126 281 113 275 102 267
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 60 255 75 270
Polygon -6459832 true true 135 255 150 330 165 255 148 248
Polygon -16777216 false false -120 240 -89 236 -60 240 3 233 20 239 15 255 -60 255
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Line -16777216 false 150 45 150 -15
Polygon -16777216 false false -90 180 75 150 105 210 93 259 58 259 19 255 19 243 19 239 4 233 -14 235 0 225 0 210 -15 195 -42 188 -77 188 -104 195
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 60 255 75 270
Rectangle -16777216 false false 45 240 90 270
Polygon -6459832 true true 255 240 210 240 210 270 255 270
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 210 240 255 270
Circle -16777216 true false 167 120 8
Circle -16777216 true false 125 120 8
Circle -955883 true false 135 165 30
Circle -955883 true false 135 225 30
Circle -955883 true false 165 195 30
Circle -955883 true false 105 195 30
Circle -955883 true false 150 180 30
Circle -955883 true false 120 180 30
Circle -955883 true false 120 210 30
Circle -955883 true false 150 210 30
Circle -955883 true false 129 189 42
Line -16777216 false 45 135 83 121

alvatorre-charge5
false
3
Polygon -1184463 true false -1 156 3 121 15 105 30 114 39 145 29 150
Polygon -16777216 false false -2 155 3 120 14 105 28 113 39 144 29 150
Polygon -6459832 true true 135 45 120 75 90 90 45 135 15 150 -75 165 -120 180 -135 195 -135 225 -120 240 -60 255 15 255 19 243 19 255 60 259 94 259 101 266 112 274 125 280 141 283 150 330 150 -15
Polygon -1184463 true false -135 203 -119 208 -74 198 -43 198 -15 207 29 205 104 215 94 260 52 259 19 255 -60 255 -120 240 -135 225
Rectangle -16777216 false false 210 240 255 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 0 254 15 284 27 276 36 255 15 223
Polygon -16777216 false false 0 255 14 284 25 278 34 256 20 256 19 244 14 255
Polygon -16777216 false false -90 191 -105 210 -105 225 -60 255 15 255 30 210 18 160 -90 180 -105 195
Rectangle -16777216 false false 210 240 255 270
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 301 156 297 121 285 105 270 114 261 145 271 150
Polygon -16777216 false false 302 155 297 120 286 105 272 113 261 144 271 150
Polygon -6459832 true true 165 45 180 75 210 90 255 135 285 150 375 165 420 180 435 195 435 225 420 240 360 255 285 255 281 243 281 255 240 259 206 259 199 266 188 274 175 280 159 283 150 330 150 -15
Circle -1184463 true false 75 135 150
Polygon -16777216 true false 201 197 194 180 187 210 180 180 169 184 168 209 168 212 162 211 156 181 149 176 149 240 162 225 169 225 173 241 184 225 186 239 198 227 194 210
Polygon -16777216 false false 207 258 213 249 218 240 221 232 224 222 225 210 224 197 220 182 213 168 195 145 150 165 150 285 158 285 174 281 187 275 198 267
Polygon -16777216 true false 99 197 106 180 113 210 120 180 131 184 132 209 132 212 138 211 144 181 151 176 151 240 138 225 131 225 127 241 116 225 114 239 102 227 106 210
Rectangle -16777216 false false 210 240 255 270
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -1184463 true false 300 254 285 284 273 276 264 255 285 223
Polygon -1184463 true false 435 203 419 208 374 198 343 198 315 207 271 205 196 215 206 260 248 259 281 255 360 255 420 240 435 225
Polygon -16777216 false false 390 191 405 210 405 225 360 255 285 255 270 210 282 160 390 180 405 195
Polygon -6459832 true true 164 135 166 143 150 149 150 131
Polygon -16777216 true false 185 134 170 104 158 110 166 144
Line -16777216 false 150 -15 165 45
Line -16777216 false 165 45 180 75
Line -16777216 false 180 75 210 90
Line -16777216 false 210 90 255 135
Line -16777216 false 255 135 285 150
Line -16777216 false 15 255 30 210
Line -16777216 false 15 150 30 210
Polygon -16777216 false false 276 187 285 195 315 195 331 190 345 188 361 188 375 188 391 192 406 195 420 198 435 195 420 180 375 165 285 150
Line -16777216 false 157 15 150 8
Line -16777216 false 165 45 150 30
Line -16777216 false 165 144 150 149
Line -16777216 false 210 150 210 135
Line -16777216 false 210 105 165 90
Line -16777216 false 180 95 165 60
Line -16777216 false 195 129 165 144
Line -16777216 false 195 129 204 117
Line -16777216 false 204 118 196 100
Line -16777216 false 165 90 150 102
Line -16777216 false 165 60 150 45
Line -16777216 false 165 90 165 75
Line -16777216 false 165 75 150 68
Line -16777216 false 180 135 218 121
Line -16777216 false 225 105 177 87
Circle -7500403 true false 164 118 13
Polygon -16777216 false false 200 230 195 239 186 250 176 257 163 262 156 263 150 263 157 263 170 260 184 251 194 241 199 232
Polygon -1184463 true false 197 215 224 204 221 189 214 171 195 210
Polygon -1184463 true false 215 170 217 138 200 123 195 131 150 150 150 165 195 145
Polygon -16777216 false false 420 240 389 236 360 240 297 233 280 239 285 255 360 255
Polygon -16777216 false false 135 255 150 330 165 255 149 248
Polygon -16777216 false false 24 187 15 195 -15 195 -31 190 -45 188 -61 188 -75 188 -91 192 -106 195 -120 198 -135 195 -120 180 -75 165 15 150
Polygon -6459832 true true 225 270 240 270 256 274 270 285 195 285 210 274
Rectangle -16777216 false false 225 255 240 270
Line -16777216 false 255 135 217 121
Line -16777216 false 45 135 15 150
Line -16777216 false 90 90 45 135
Line -16777216 false 75 105 123 87
Line -16777216 false 120 75 90 90
Line -16777216 false 135 45 120 75
Line -16777216 false 135 45 150 30
Line -16777216 false 150 -15 135 45
Line -16777216 false 143 15 150 8
Line -16777216 false 135 60 150 45
Line -16777216 false 120 95 135 60
Line -16777216 false 135 75 150 68
Line -16777216 false 135 90 135 75
Line -16777216 false 90 105 135 90
Line -16777216 false 135 90 150 102
Line -16777216 false 96 118 104 100
Polygon -16777216 true false 115 134 130 104 142 110 134 144
Circle -7500403 true false 123 118 13
Line -16777216 false 105 129 96 117
Line -16777216 false 120 135 82 121
Line -16777216 false 105 129 135 144
Line -16777216 false 135 144 150 149
Polygon -6459832 true true 136 135 134 143 150 149 150 131
Polygon -1184463 true false 85 170 83 138 100 123 105 131 150 150 150 165 105 145
Polygon -16777216 false false 100 230 105 239 114 250 124 257 137 262 144 263 150 263 143 263 130 260 116 251 106 241 101 232
Polygon -6459832 true true 75 270 60 270 44 274 30 285 105 285 90 274
Line -16777216 false 225 150 195 210
Line -16777216 false 195 210 206 260
Polygon -16777216 false false 300 255 286 284 275 278 266 256 280 256 281 244 286 255
Line -16777216 false 75 150 105 210
Rectangle -16777216 false false 225 255 240 270
Polygon -1184463 true false 103 215 76 204 79 189 86 171 105 210
Polygon -16777216 false false 93 258 87 249 82 240 79 232 76 222 75 210 76 197 80 182 87 168 105 145 150 165 150 285 142 285 126 281 113 275 102 267
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 60 255 75 270
Polygon -6459832 true true 135 255 150 330 165 255 148 248
Polygon -16777216 false false -120 240 -89 236 -60 240 3 233 20 239 15 255 -60 255
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Line -16777216 false 150 45 150 -15
Polygon -16777216 false false -90 180 75 150 105 210 93 259 58 259 19 255 19 243 19 239 4 233 -14 235 0 225 0 210 -15 195 -42 188 -77 188 -104 195
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 60 255 75 270
Rectangle -16777216 false false 45 240 90 270
Polygon -6459832 true true 255 240 210 240 210 270 255 270
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 210 240 255 270
Circle -16777216 true false 167 120 8
Circle -16777216 true false 125 120 8
Circle -955883 true false 120 180 60
Line -16777216 false 45 135 83 121

alvatorre-charge6
false
3
Polygon -1184463 true false -1 156 3 121 15 105 30 114 39 145 29 150
Polygon -16777216 false false -2 155 3 120 14 105 28 113 39 144 29 150
Polygon -6459832 true true 135 45 120 75 90 90 45 135 15 150 -75 165 -120 180 -135 195 -135 225 -120 240 -60 255 15 255 19 243 19 255 60 259 94 259 101 266 112 274 125 280 141 283 150 330 150 -15
Polygon -1184463 true false -135 203 -119 208 -74 198 -43 198 -15 207 29 205 104 215 94 260 52 259 19 255 -60 255 -120 240 -135 225
Rectangle -16777216 false false 210 240 255 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 0 254 15 284 27 276 36 255 15 223
Polygon -16777216 false false 0 255 14 284 25 278 34 256 20 256 19 244 14 255
Polygon -16777216 false false -90 191 -105 210 -105 225 -60 255 15 255 30 210 18 160 -90 180 -105 195
Rectangle -16777216 false false 210 240 255 270
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 301 156 297 121 285 105 270 114 261 145 271 150
Polygon -16777216 false false 302 155 297 120 286 105 272 113 261 144 271 150
Polygon -6459832 true true 165 45 180 75 210 90 255 135 285 150 375 165 420 180 435 195 435 225 420 240 360 255 285 255 281 243 281 255 240 259 206 259 199 266 188 274 175 280 159 283 150 330 150 -15
Circle -1184463 true false 75 135 150
Polygon -16777216 true false 201 197 194 180 187 210 180 180 169 184 168 209 168 212 162 211 156 181 149 176 149 240 162 225 169 225 173 241 184 225 186 239 198 227 194 210
Polygon -16777216 false false 207 258 213 249 218 240 221 232 224 222 225 210 224 197 220 182 213 168 195 145 150 165 150 285 158 285 174 281 187 275 198 267
Polygon -16777216 true false 99 197 106 180 113 210 120 180 131 184 132 209 132 212 138 211 144 181 151 176 151 240 138 225 131 225 127 241 116 225 114 239 102 227 106 210
Rectangle -16777216 false false 210 240 255 270
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -1184463 true false 300 254 285 284 273 276 264 255 285 223
Polygon -1184463 true false 435 203 419 208 374 198 343 198 315 207 271 205 196 215 206 260 248 259 281 255 360 255 420 240 435 225
Polygon -16777216 false false 390 191 405 210 405 225 360 255 285 255 270 210 282 160 390 180 405 195
Polygon -6459832 true true 164 135 166 143 150 149 150 131
Polygon -16777216 true false 185 134 170 104 158 110 166 144
Line -16777216 false 150 -15 165 45
Line -16777216 false 165 45 180 75
Line -16777216 false 180 75 210 90
Line -16777216 false 210 90 255 135
Line -16777216 false 255 135 285 150
Line -16777216 false 15 255 30 210
Line -16777216 false 15 150 30 210
Polygon -16777216 false false 276 187 285 195 315 195 331 190 345 188 361 188 375 188 391 192 406 195 420 198 435 195 420 180 375 165 285 150
Line -16777216 false 157 15 150 8
Line -16777216 false 165 45 150 30
Line -16777216 false 165 144 150 149
Line -16777216 false 210 150 210 135
Line -16777216 false 210 105 165 90
Line -16777216 false 180 95 165 60
Line -16777216 false 195 129 165 144
Line -16777216 false 195 129 204 117
Line -16777216 false 204 118 196 100
Line -16777216 false 165 90 150 102
Line -16777216 false 165 60 150 45
Line -16777216 false 165 90 165 75
Line -16777216 false 165 75 150 68
Line -16777216 false 180 135 218 121
Line -16777216 false 225 105 177 87
Circle -7500403 true false 164 118 13
Polygon -16777216 false false 200 230 195 239 186 250 176 257 163 262 156 263 150 263 157 263 170 260 184 251 194 241 199 232
Polygon -1184463 true false 197 215 224 204 221 189 214 171 195 210
Polygon -1184463 true false 215 170 217 138 200 123 195 131 150 150 150 165 195 145
Polygon -16777216 false false 420 240 389 236 360 240 297 233 280 239 285 255 360 255
Polygon -16777216 false false 135 255 150 330 165 255 149 248
Polygon -16777216 false false 24 187 15 195 -15 195 -31 190 -45 188 -61 188 -75 188 -91 192 -106 195 -120 198 -135 195 -120 180 -75 165 15 150
Polygon -6459832 true true 225 270 240 270 256 274 270 285 195 285 210 274
Rectangle -16777216 false false 225 255 240 270
Line -16777216 false 255 135 217 121
Line -16777216 false 45 135 15 150
Line -16777216 false 90 90 45 135
Line -16777216 false 75 105 123 87
Line -16777216 false 120 75 90 90
Line -16777216 false 135 45 120 75
Line -16777216 false 135 45 150 30
Line -16777216 false 150 -15 135 45
Line -16777216 false 143 15 150 8
Line -16777216 false 135 60 150 45
Line -16777216 false 120 95 135 60
Line -16777216 false 135 75 150 68
Line -16777216 false 135 90 135 75
Line -16777216 false 90 105 135 90
Line -16777216 false 135 90 150 102
Line -16777216 false 96 118 104 100
Polygon -16777216 true false 115 134 130 104 142 110 134 144
Circle -7500403 true false 123 118 13
Line -16777216 false 105 129 96 117
Line -16777216 false 120 135 82 121
Line -16777216 false 105 129 135 144
Line -16777216 false 135 144 150 149
Polygon -6459832 true true 136 135 134 143 150 149 150 131
Polygon -1184463 true false 85 170 83 138 100 123 105 131 150 150 150 165 105 145
Polygon -16777216 false false 100 230 105 239 114 250 124 257 137 262 144 263 150 263 143 263 130 260 116 251 106 241 101 232
Polygon -6459832 true true 75 270 60 270 44 274 30 285 105 285 90 274
Line -16777216 false 225 150 195 210
Line -16777216 false 195 210 206 260
Polygon -16777216 false false 300 255 286 284 275 278 266 256 280 256 281 244 286 255
Line -16777216 false 75 150 105 210
Rectangle -16777216 false false 225 255 240 270
Polygon -1184463 true false 103 215 76 204 79 189 86 171 105 210
Polygon -16777216 false false 93 258 87 249 82 240 79 232 76 222 75 210 76 197 80 182 87 168 105 145 150 165 150 285 142 285 126 281 113 275 102 267
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 60 255 75 270
Polygon -6459832 true true 135 255 150 330 165 255 148 248
Polygon -16777216 false false -120 240 -89 236 -60 240 3 233 20 239 15 255 -60 255
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Line -16777216 false 150 45 150 -15
Polygon -16777216 false false -90 180 75 150 105 210 93 259 58 259 19 255 19 243 19 239 4 233 -14 235 0 225 0 210 -15 195 -42 188 -77 188 -104 195
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 60 255 75 270
Rectangle -16777216 false false 45 240 90 270
Polygon -6459832 true true 255 240 210 240 210 270 255 270
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 210 240 255 270
Circle -16777216 true false 167 120 8
Circle -16777216 true false 125 120 8
Circle -955883 true false 135 120 30
Circle -955883 true false 135 270 30
Circle -955883 true false 210 195 30
Circle -955883 true false 60 195 30
Circle -955883 true false 180 150 30
Circle -955883 true false 90 150 30
Circle -955883 true false 90 240 30
Circle -955883 true false 180 240 30
Circle -955883 true false 120 180 60
Line -16777216 false 45 135 83 121

alvatorre-charge6.5
false
3
Polygon -1184463 true false -1 156 3 121 15 105 30 114 39 145 29 150
Polygon -16777216 false false -2 155 3 120 14 105 28 113 39 144 29 150
Polygon -6459832 true true 135 45 120 75 90 90 45 135 15 150 -75 165 -120 180 -135 195 -135 225 -120 240 -60 255 15 255 19 243 19 255 60 259 94 259 101 266 112 274 125 280 141 283 150 330 150 -15
Polygon -1184463 true false -135 203 -119 208 -74 198 -43 198 -15 207 29 205 104 215 94 260 52 259 19 255 -60 255 -120 240 -135 225
Rectangle -16777216 false false 210 240 255 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 0 254 15 284 27 276 36 255 15 223
Polygon -16777216 false false 0 255 14 284 25 278 34 256 20 256 19 244 14 255
Polygon -16777216 false false -90 191 -105 210 -105 225 -60 255 15 255 30 210 18 160 -90 180 -105 195
Rectangle -16777216 false false 210 240 255 270
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 301 156 297 121 285 105 270 114 261 145 271 150
Polygon -16777216 false false 302 155 297 120 286 105 272 113 261 144 271 150
Polygon -6459832 true true 165 45 180 75 210 90 255 135 285 150 375 165 420 180 435 195 435 225 420 240 360 255 285 255 281 243 281 255 240 259 206 259 199 266 188 274 175 280 159 283 150 330 150 -15
Circle -1184463 true false 75 135 150
Polygon -16777216 true false 201 197 194 180 187 210 180 180 169 184 168 209 168 212 162 211 156 181 149 176 149 240 162 225 169 225 173 241 184 225 186 239 198 227 194 210
Polygon -16777216 false false 207 258 213 249 218 240 221 232 224 222 225 210 224 197 220 182 213 168 195 145 150 165 150 285 158 285 174 281 187 275 198 267
Polygon -16777216 true false 99 197 106 180 113 210 120 180 131 184 132 209 132 212 138 211 144 181 151 176 151 240 138 225 131 225 127 241 116 225 114 239 102 227 106 210
Rectangle -16777216 false false 210 240 255 270
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -1184463 true false 300 254 285 284 273 276 264 255 285 223
Polygon -1184463 true false 435 203 419 208 374 198 343 198 315 207 271 205 196 215 206 260 248 259 281 255 360 255 420 240 435 225
Polygon -16777216 false false 390 191 405 210 405 225 360 255 285 255 270 210 282 160 390 180 405 195
Polygon -6459832 true true 164 135 166 143 150 149 150 131
Polygon -16777216 true false 185 134 170 104 158 110 166 144
Line -16777216 false 150 -15 165 45
Line -16777216 false 165 45 180 75
Line -16777216 false 180 75 210 90
Line -16777216 false 210 90 255 135
Line -16777216 false 255 135 285 150
Line -16777216 false 15 255 30 210
Line -16777216 false 15 150 30 210
Polygon -16777216 false false 276 187 285 195 315 195 331 190 345 188 361 188 375 188 391 192 406 195 420 198 435 195 420 180 375 165 285 150
Line -16777216 false 157 15 150 8
Line -16777216 false 165 45 150 30
Line -16777216 false 165 144 150 149
Line -16777216 false 210 150 210 135
Line -16777216 false 210 105 165 90
Line -16777216 false 180 95 165 60
Line -16777216 false 195 129 165 144
Line -16777216 false 195 129 204 117
Line -16777216 false 204 118 196 100
Line -16777216 false 165 90 150 102
Line -16777216 false 165 60 150 45
Line -16777216 false 165 90 165 75
Line -16777216 false 165 75 150 68
Line -16777216 false 180 135 218 121
Line -16777216 false 225 105 177 87
Circle -7500403 true false 164 118 13
Polygon -16777216 false false 200 230 195 239 186 250 176 257 163 262 156 263 150 263 157 263 170 260 184 251 194 241 199 232
Polygon -1184463 true false 197 215 224 204 221 189 214 171 195 210
Polygon -1184463 true false 215 170 217 138 200 123 195 131 150 150 150 165 195 145
Polygon -16777216 false false 420 240 389 236 360 240 297 233 280 239 285 255 360 255
Polygon -16777216 false false 135 255 150 330 165 255 149 248
Polygon -16777216 false false 24 187 15 195 -15 195 -31 190 -45 188 -61 188 -75 188 -91 192 -106 195 -120 198 -135 195 -120 180 -75 165 15 150
Polygon -6459832 true true 225 270 240 270 256 274 270 285 195 285 210 274
Rectangle -16777216 false false 225 255 240 270
Line -16777216 false 255 135 217 121
Line -16777216 false 45 135 15 150
Line -16777216 false 90 90 45 135
Line -16777216 false 75 105 123 87
Line -16777216 false 120 75 90 90
Line -16777216 false 135 45 120 75
Line -16777216 false 135 45 150 30
Line -16777216 false 150 -15 135 45
Line -16777216 false 143 15 150 8
Line -16777216 false 135 60 150 45
Line -16777216 false 120 95 135 60
Line -16777216 false 135 75 150 68
Line -16777216 false 135 90 135 75
Line -16777216 false 90 105 135 90
Line -16777216 false 135 90 150 102
Line -16777216 false 96 118 104 100
Polygon -16777216 true false 115 134 130 104 142 110 134 144
Circle -7500403 true false 123 118 13
Line -16777216 false 105 129 96 117
Line -16777216 false 120 135 82 121
Line -16777216 false 105 129 135 144
Line -16777216 false 135 144 150 149
Polygon -6459832 true true 136 135 134 143 150 149 150 131
Polygon -1184463 true false 85 170 83 138 100 123 105 131 150 150 150 165 105 145
Polygon -16777216 false false 100 230 105 239 114 250 124 257 137 262 144 263 150 263 143 263 130 260 116 251 106 241 101 232
Polygon -6459832 true true 75 270 60 270 44 274 30 285 105 285 90 274
Line -16777216 false 225 150 195 210
Line -16777216 false 195 210 206 260
Polygon -16777216 false false 300 255 286 284 275 278 266 256 280 256 281 244 286 255
Line -16777216 false 75 150 105 210
Rectangle -16777216 false false 225 255 240 270
Polygon -1184463 true false 103 215 76 204 79 189 86 171 105 210
Polygon -16777216 false false 93 258 87 249 82 240 79 232 76 222 75 210 76 197 80 182 87 168 105 145 150 165 150 285 142 285 126 281 113 275 102 267
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 60 255 75 270
Polygon -6459832 true true 135 255 150 330 165 255 148 248
Polygon -16777216 false false -120 240 -89 236 -60 240 3 233 20 239 15 255 -60 255
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Line -16777216 false 150 45 150 -15
Polygon -16777216 false false -90 180 75 150 105 210 93 259 58 259 19 255 19 243 19 239 4 233 -14 235 0 225 0 210 -15 195 -42 188 -77 188 -104 195
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 60 255 75 270
Rectangle -16777216 false false 45 240 90 270
Polygon -6459832 true true 255 240 210 240 210 270 255 270
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 210 240 255 270
Circle -16777216 true false 167 120 8
Circle -16777216 true false 125 120 8
Circle -955883 true false 135 135 30
Circle -955883 true false 135 255 30
Circle -955883 true false 195 195 30
Circle -955883 true false 75 195 30
Circle -955883 true false 172 157 30
Circle -955883 true false 98 157 30
Circle -955883 true false 172 232 30
Circle -955883 true false 98 232 30
Circle -955883 true false 120 180 60
Line -16777216 false 45 135 83 121

alvatorre-charge7
false
3
Polygon -1184463 true false -1 156 3 121 15 105 30 114 39 145 29 150
Polygon -16777216 false false -2 155 3 120 14 105 28 113 39 144 29 150
Polygon -6459832 true true 135 45 120 75 90 90 45 135 15 150 -75 165 -120 180 -135 195 -135 225 -120 240 -60 255 15 255 19 243 19 255 60 259 94 259 101 266 112 274 125 280 141 283 150 330 150 -15
Polygon -1184463 true false -135 203 -119 208 -74 198 -43 198 -15 207 29 205 104 215 94 260 52 259 19 255 -60 255 -120 240 -135 225
Rectangle -16777216 false false 210 240 255 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 0 254 15 284 27 276 36 255 15 223
Polygon -16777216 false false 0 255 14 284 25 278 34 256 20 256 19 244 14 255
Polygon -16777216 false false -90 191 -105 210 -105 225 -60 255 15 255 30 210 18 160 -90 180 -105 195
Rectangle -16777216 false false 210 240 255 270
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 301 156 297 121 285 105 270 114 261 145 271 150
Polygon -16777216 false false 302 155 297 120 286 105 272 113 261 144 271 150
Polygon -6459832 true true 165 45 180 75 210 90 255 135 285 150 375 165 420 180 435 195 435 225 420 240 360 255 285 255 281 243 281 255 240 259 206 259 199 266 188 274 175 280 159 283 150 330 150 -15
Circle -1184463 true false 75 135 150
Polygon -16777216 true false 201 197 194 180 187 210 180 180 169 184 168 209 168 212 162 211 156 181 149 176 149 240 162 225 169 225 173 241 184 225 186 239 198 227 194 210
Polygon -16777216 false false 207 258 213 249 218 240 221 232 224 222 225 210 224 197 220 182 213 168 195 145 150 165 150 285 158 285 174 281 187 275 198 267
Polygon -16777216 true false 99 197 106 180 113 210 120 180 131 184 132 209 132 212 138 211 144 181 151 176 151 240 138 225 131 225 127 241 116 225 114 239 102 227 106 210
Rectangle -16777216 false false 210 240 255 270
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -1184463 true false 300 254 285 284 273 276 264 255 285 223
Polygon -1184463 true false 435 203 419 208 374 198 343 198 315 207 271 205 196 215 206 260 248 259 281 255 360 255 420 240 435 225
Polygon -16777216 false false 390 191 405 210 405 225 360 255 285 255 270 210 282 160 390 180 405 195
Polygon -6459832 true true 164 135 166 143 150 149 150 131
Polygon -16777216 true false 185 134 170 104 158 110 166 144
Line -16777216 false 150 -15 165 45
Line -16777216 false 165 45 180 75
Line -16777216 false 180 75 210 90
Line -16777216 false 210 90 255 135
Line -16777216 false 255 135 285 150
Line -16777216 false 15 255 30 210
Line -16777216 false 15 150 30 210
Polygon -16777216 false false 276 187 285 195 315 195 331 190 345 188 361 188 375 188 391 192 406 195 420 198 435 195 420 180 375 165 285 150
Line -16777216 false 157 15 150 8
Line -16777216 false 165 45 150 30
Line -16777216 false 165 144 150 149
Line -16777216 false 210 150 210 135
Line -16777216 false 210 105 165 90
Line -16777216 false 180 95 165 60
Line -16777216 false 195 129 165 144
Line -16777216 false 195 129 204 117
Line -16777216 false 204 118 196 100
Line -16777216 false 165 90 150 102
Line -16777216 false 165 60 150 45
Line -16777216 false 165 90 165 75
Line -16777216 false 165 75 150 68
Line -16777216 false 180 135 218 121
Line -16777216 false 225 105 177 87
Circle -7500403 true false 164 118 13
Polygon -16777216 false false 200 230 195 239 186 250 176 257 163 262 156 263 150 263 157 263 170 260 184 251 194 241 199 232
Polygon -1184463 true false 197 215 224 204 221 189 214 171 195 210
Polygon -1184463 true false 215 170 217 138 200 123 195 131 150 150 150 165 195 145
Polygon -16777216 false false 420 240 389 236 360 240 297 233 280 239 285 255 360 255
Polygon -16777216 false false 135 255 150 330 165 255 149 248
Polygon -16777216 false false 24 187 15 195 -15 195 -31 190 -45 188 -61 188 -75 188 -91 192 -106 195 -120 198 -135 195 -120 180 -75 165 15 150
Polygon -6459832 true true 225 270 240 270 256 274 270 285 195 285 210 274
Rectangle -16777216 false false 225 255 240 270
Line -16777216 false 255 135 217 121
Line -16777216 false 45 135 15 150
Line -16777216 false 90 90 45 135
Line -16777216 false 75 105 123 87
Line -16777216 false 120 75 90 90
Line -16777216 false 135 45 120 75
Line -16777216 false 135 45 150 30
Line -16777216 false 150 -15 135 45
Line -16777216 false 143 15 150 8
Line -16777216 false 135 60 150 45
Line -16777216 false 120 95 135 60
Line -16777216 false 135 75 150 68
Line -16777216 false 135 90 135 75
Line -16777216 false 90 105 135 90
Line -16777216 false 135 90 150 102
Line -16777216 false 96 118 104 100
Polygon -16777216 true false 115 134 130 104 142 110 134 144
Circle -7500403 true false 123 118 13
Line -16777216 false 105 129 96 117
Line -16777216 false 120 135 82 121
Line -16777216 false 105 129 135 144
Line -16777216 false 135 144 150 149
Polygon -6459832 true true 136 135 134 143 150 149 150 131
Polygon -1184463 true false 85 170 83 138 100 123 105 131 150 150 150 165 105 145
Polygon -16777216 false false 100 230 105 239 114 250 124 257 137 262 144 263 150 263 143 263 130 260 116 251 106 241 101 232
Polygon -6459832 true true 75 270 60 270 44 274 30 285 105 285 90 274
Line -16777216 false 225 150 195 210
Line -16777216 false 195 210 206 260
Polygon -16777216 false false 300 255 286 284 275 278 266 256 280 256 281 244 286 255
Line -16777216 false 75 150 105 210
Rectangle -16777216 false false 225 255 240 270
Polygon -1184463 true false 103 215 76 204 79 189 86 171 105 210
Polygon -16777216 false false 93 258 87 249 82 240 79 232 76 222 75 210 76 197 80 182 87 168 105 145 150 165 150 285 142 285 126 281 113 275 102 267
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 60 255 75 270
Polygon -6459832 true true 135 255 150 330 165 255 148 248
Polygon -16777216 false false -120 240 -89 236 -60 240 3 233 20 239 15 255 -60 255
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Line -16777216 false 150 45 150 -15
Polygon -16777216 false false -90 180 75 150 105 210 93 259 58 259 19 255 19 243 19 239 4 233 -14 235 0 225 0 210 -15 195 -42 188 -77 188 -104 195
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 60 255 75 270
Rectangle -16777216 false false 45 240 90 270
Polygon -6459832 true true 255 240 210 240 210 270 255 270
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 210 240 255 270
Circle -16777216 true false 167 120 8
Circle -16777216 true false 125 120 8
Circle -955883 true false 135 150 30
Circle -955883 true false 135 240 30
Circle -955883 true false 180 195 30
Circle -955883 true false 90 195 30
Circle -955883 true false 165 165 30
Circle -955883 true false 105 165 30
Circle -955883 true false 105 225 30
Circle -955883 true false 165 225 30
Circle -955883 true false 120 180 60
Line -16777216 false 45 135 83 121

alvatorre-charge7.5
false
3
Polygon -1184463 true false -1 156 3 121 15 105 30 114 39 145 29 150
Polygon -16777216 false false -2 155 3 120 14 105 28 113 39 144 29 150
Polygon -6459832 true true 135 45 120 75 90 90 45 135 15 150 -75 165 -120 180 -135 195 -135 225 -120 240 -60 255 15 255 19 243 19 255 60 259 94 259 101 266 112 274 125 280 141 283 150 330 150 -15
Polygon -1184463 true false -135 203 -119 208 -74 198 -43 198 -15 207 29 205 104 215 94 260 52 259 19 255 -60 255 -120 240 -135 225
Rectangle -16777216 false false 210 240 255 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 0 254 15 284 27 276 36 255 15 223
Polygon -16777216 false false 0 255 14 284 25 278 34 256 20 256 19 244 14 255
Polygon -16777216 false false -90 191 -105 210 -105 225 -60 255 15 255 30 210 18 160 -90 180 -105 195
Rectangle -16777216 false false 210 240 255 270
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 301 156 297 121 285 105 270 114 261 145 271 150
Polygon -16777216 false false 302 155 297 120 286 105 272 113 261 144 271 150
Polygon -6459832 true true 165 45 180 75 210 90 255 135 285 150 375 165 420 180 435 195 435 225 420 240 360 255 285 255 281 243 281 255 240 259 206 259 199 266 188 274 175 280 159 283 150 330 150 -15
Circle -1184463 true false 75 135 150
Polygon -16777216 true false 201 197 194 180 187 210 180 180 169 184 168 209 168 212 162 211 156 181 149 176 149 240 162 225 169 225 173 241 184 225 186 239 198 227 194 210
Polygon -16777216 false false 207 258 213 249 218 240 221 232 224 222 225 210 224 197 220 182 213 168 195 145 150 165 150 285 158 285 174 281 187 275 198 267
Polygon -16777216 true false 99 197 106 180 113 210 120 180 131 184 132 209 132 212 138 211 144 181 151 176 151 240 138 225 131 225 127 241 116 225 114 239 102 227 106 210
Rectangle -16777216 false false 210 240 255 270
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -1184463 true false 300 254 285 284 273 276 264 255 285 223
Polygon -1184463 true false 435 203 419 208 374 198 343 198 315 207 271 205 196 215 206 260 248 259 281 255 360 255 420 240 435 225
Polygon -16777216 false false 390 191 405 210 405 225 360 255 285 255 270 210 282 160 390 180 405 195
Polygon -6459832 true true 164 135 166 143 150 149 150 131
Polygon -16777216 true false 185 134 170 104 158 110 166 144
Line -16777216 false 150 -15 165 45
Line -16777216 false 165 45 180 75
Line -16777216 false 180 75 210 90
Line -16777216 false 210 90 255 135
Line -16777216 false 255 135 285 150
Line -16777216 false 15 255 30 210
Line -16777216 false 15 150 30 210
Polygon -16777216 false false 276 187 285 195 315 195 331 190 345 188 361 188 375 188 391 192 406 195 420 198 435 195 420 180 375 165 285 150
Line -16777216 false 157 15 150 8
Line -16777216 false 165 45 150 30
Line -16777216 false 165 144 150 149
Line -16777216 false 210 150 210 135
Line -16777216 false 210 105 165 90
Line -16777216 false 180 95 165 60
Line -16777216 false 195 129 165 144
Line -16777216 false 195 129 204 117
Line -16777216 false 204 118 196 100
Line -16777216 false 165 90 150 102
Line -16777216 false 165 60 150 45
Line -16777216 false 165 90 165 75
Line -16777216 false 165 75 150 68
Line -16777216 false 180 135 218 121
Line -16777216 false 225 105 177 87
Circle -7500403 true false 164 118 13
Polygon -16777216 false false 200 230 195 239 186 250 176 257 163 262 156 263 150 263 157 263 170 260 184 251 194 241 199 232
Polygon -1184463 true false 197 215 224 204 221 189 214 171 195 210
Polygon -1184463 true false 215 170 217 138 200 123 195 131 150 150 150 165 195 145
Polygon -16777216 false false 420 240 389 236 360 240 297 233 280 239 285 255 360 255
Polygon -16777216 false false 135 255 150 330 165 255 149 248
Polygon -16777216 false false 24 187 15 195 -15 195 -31 190 -45 188 -61 188 -75 188 -91 192 -106 195 -120 198 -135 195 -120 180 -75 165 15 150
Polygon -6459832 true true 225 270 240 270 256 274 270 285 195 285 210 274
Rectangle -16777216 false false 225 255 240 270
Line -16777216 false 255 135 217 121
Line -16777216 false 45 135 15 150
Line -16777216 false 90 90 45 135
Line -16777216 false 75 105 123 87
Line -16777216 false 120 75 90 90
Line -16777216 false 135 45 120 75
Line -16777216 false 135 45 150 30
Line -16777216 false 150 -15 135 45
Line -16777216 false 143 15 150 8
Line -16777216 false 135 60 150 45
Line -16777216 false 120 95 135 60
Line -16777216 false 135 75 150 68
Line -16777216 false 135 90 135 75
Line -16777216 false 90 105 135 90
Line -16777216 false 135 90 150 102
Line -16777216 false 96 118 104 100
Polygon -16777216 true false 115 134 130 104 142 110 134 144
Circle -7500403 true false 123 118 13
Line -16777216 false 105 129 96 117
Line -16777216 false 120 135 82 121
Line -16777216 false 105 129 135 144
Line -16777216 false 135 144 150 149
Polygon -6459832 true true 136 135 134 143 150 149 150 131
Polygon -1184463 true false 85 170 83 138 100 123 105 131 150 150 150 165 105 145
Polygon -16777216 false false 100 230 105 239 114 250 124 257 137 262 144 263 150 263 143 263 130 260 116 251 106 241 101 232
Polygon -6459832 true true 75 270 60 270 44 274 30 285 105 285 90 274
Line -16777216 false 225 150 195 210
Line -16777216 false 195 210 206 260
Polygon -16777216 false false 300 255 286 284 275 278 266 256 280 256 281 244 286 255
Line -16777216 false 75 150 105 210
Rectangle -16777216 false false 225 255 240 270
Polygon -1184463 true false 103 215 76 204 79 189 86 171 105 210
Polygon -16777216 false false 93 258 87 249 82 240 79 232 76 222 75 210 76 197 80 182 87 168 105 145 150 165 150 285 142 285 126 281 113 275 102 267
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 60 255 75 270
Polygon -6459832 true true 135 255 150 330 165 255 148 248
Polygon -16777216 false false -120 240 -89 236 -60 240 3 233 20 239 15 255 -60 255
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Line -16777216 false 150 45 150 -15
Polygon -16777216 false false -90 180 75 150 105 210 93 259 58 259 19 255 19 243 19 239 4 233 -14 235 0 225 0 210 -15 195 -42 188 -77 188 -104 195
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 60 255 75 270
Rectangle -16777216 false false 45 240 90 270
Polygon -6459832 true true 255 240 210 240 210 270 255 270
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 210 240 255 270
Circle -16777216 true false 167 120 8
Circle -16777216 true false 125 120 8
Circle -955883 true false 135 165 30
Circle -955883 true false 135 225 30
Circle -955883 true false 165 195 30
Circle -955883 true false 105 195 30
Circle -955883 true false 150 180 30
Circle -955883 true false 120 180 30
Circle -955883 true false 120 210 30
Circle -955883 true false 150 210 30
Circle -955883 true false 120 180 60
Line -16777216 false 45 135 83 121

alvatorre-charge8
false
3
Polygon -1184463 true false -1 156 3 121 15 105 30 114 39 145 29 150
Polygon -16777216 false false -2 155 3 120 14 105 28 113 39 144 29 150
Polygon -6459832 true true 135 45 120 75 90 90 45 135 15 150 -75 165 -120 180 -135 195 -135 225 -120 240 -60 255 15 255 19 243 19 255 60 259 94 259 101 266 112 274 125 280 141 283 150 330 150 -15
Polygon -1184463 true false -135 203 -119 208 -74 198 -43 198 -15 207 29 205 104 215 94 260 52 259 19 255 -60 255 -120 240 -135 225
Rectangle -16777216 false false 210 240 255 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 0 254 15 284 27 276 36 255 15 223
Polygon -16777216 false false 0 255 14 284 25 278 34 256 20 256 19 244 14 255
Polygon -16777216 false false -90 191 -105 210 -105 225 -60 255 15 255 30 210 18 160 -90 180 -105 195
Rectangle -16777216 false false 210 240 255 270
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 301 156 297 121 285 105 270 114 261 145 271 150
Polygon -16777216 false false 302 155 297 120 286 105 272 113 261 144 271 150
Polygon -6459832 true true 165 45 180 75 210 90 255 135 285 150 375 165 420 180 435 195 435 225 420 240 360 255 285 255 281 243 281 255 240 259 206 259 199 266 188 274 175 280 159 283 150 330 150 -15
Circle -1184463 true false 75 135 150
Polygon -16777216 true false 201 197 194 180 187 210 180 180 169 184 168 209 168 212 162 211 156 181 149 176 149 240 162 225 169 225 173 241 184 225 186 239 198 227 194 210
Polygon -16777216 false false 207 258 213 249 218 240 221 232 224 222 225 210 224 197 220 182 213 168 195 145 150 165 150 285 158 285 174 281 187 275 198 267
Polygon -16777216 true false 99 197 106 180 113 210 120 180 131 184 132 209 132 212 138 211 144 181 151 176 151 240 138 225 131 225 127 241 116 225 114 239 102 227 106 210
Rectangle -16777216 false false 210 240 255 270
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -1184463 true false 300 254 285 284 273 276 264 255 285 223
Polygon -1184463 true false 435 203 419 208 374 198 343 198 315 207 271 205 196 215 206 260 248 259 281 255 360 255 420 240 435 225
Polygon -16777216 false false 390 191 405 210 405 225 360 255 285 255 270 210 282 160 390 180 405 195
Polygon -6459832 true true 164 135 166 143 150 149 150 131
Polygon -16777216 true false 185 134 170 104 158 110 166 144
Line -16777216 false 150 -15 165 45
Line -16777216 false 165 45 180 75
Line -16777216 false 180 75 210 90
Line -16777216 false 210 90 255 135
Line -16777216 false 255 135 285 150
Line -16777216 false 15 255 30 210
Line -16777216 false 15 150 30 210
Polygon -16777216 false false 276 187 285 195 315 195 331 190 345 188 361 188 375 188 391 192 406 195 420 198 435 195 420 180 375 165 285 150
Line -16777216 false 157 15 150 8
Line -16777216 false 165 45 150 30
Line -16777216 false 165 144 150 149
Line -16777216 false 210 150 210 135
Line -16777216 false 210 105 165 90
Line -16777216 false 180 95 165 60
Line -16777216 false 195 129 165 144
Line -16777216 false 195 129 204 117
Line -16777216 false 204 118 196 100
Line -16777216 false 165 90 150 102
Line -16777216 false 165 60 150 45
Line -16777216 false 165 90 165 75
Line -16777216 false 165 75 150 68
Line -16777216 false 180 135 218 121
Line -16777216 false 225 105 177 87
Circle -7500403 true false 164 118 13
Polygon -16777216 false false 200 230 195 239 186 250 176 257 163 262 156 263 150 263 157 263 170 260 184 251 194 241 199 232
Polygon -1184463 true false 197 215 224 204 221 189 214 171 195 210
Polygon -1184463 true false 215 170 217 138 200 123 195 131 150 150 150 165 195 145
Polygon -16777216 false false 420 240 389 236 360 240 297 233 280 239 285 255 360 255
Polygon -16777216 false false 135 255 150 330 165 255 149 248
Polygon -16777216 false false 24 187 15 195 -15 195 -31 190 -45 188 -61 188 -75 188 -91 192 -106 195 -120 198 -135 195 -120 180 -75 165 15 150
Polygon -6459832 true true 225 270 240 270 256 274 270 285 195 285 210 274
Rectangle -16777216 false false 225 255 240 270
Line -16777216 false 255 135 217 121
Line -16777216 false 45 135 15 150
Line -16777216 false 90 90 45 135
Line -16777216 false 75 105 123 87
Line -16777216 false 120 75 90 90
Line -16777216 false 135 45 120 75
Line -16777216 false 135 45 150 30
Line -16777216 false 150 -15 135 45
Line -16777216 false 143 15 150 8
Line -16777216 false 135 60 150 45
Line -16777216 false 120 95 135 60
Line -16777216 false 135 75 150 68
Line -16777216 false 135 90 135 75
Line -16777216 false 90 105 135 90
Line -16777216 false 135 90 150 102
Line -16777216 false 96 118 104 100
Polygon -16777216 true false 115 134 130 104 142 110 134 144
Circle -7500403 true false 123 118 13
Line -16777216 false 105 129 96 117
Line -16777216 false 120 135 82 121
Line -16777216 false 105 129 135 144
Line -16777216 false 135 144 150 149
Polygon -6459832 true true 136 135 134 143 150 149 150 131
Polygon -1184463 true false 85 170 83 138 100 123 105 131 150 150 150 165 105 145
Polygon -16777216 false false 100 230 105 239 114 250 124 257 137 262 144 263 150 263 143 263 130 260 116 251 106 241 101 232
Polygon -6459832 true true 75 270 60 270 44 274 30 285 105 285 90 274
Line -16777216 false 225 150 195 210
Line -16777216 false 195 210 206 260
Polygon -16777216 false false 300 255 286 284 275 278 266 256 280 256 281 244 286 255
Line -16777216 false 75 150 105 210
Rectangle -16777216 false false 225 255 240 270
Polygon -1184463 true false 103 215 76 204 79 189 86 171 105 210
Polygon -16777216 false false 93 258 87 249 82 240 79 232 76 222 75 210 76 197 80 182 87 168 105 145 150 165 150 285 142 285 126 281 113 275 102 267
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 60 255 75 270
Polygon -6459832 true true 135 255 150 330 165 255 148 248
Polygon -16777216 false false -120 240 -89 236 -60 240 3 233 20 239 15 255 -60 255
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Line -16777216 false 150 45 150 -15
Polygon -16777216 false false -90 180 75 150 105 210 93 259 58 259 19 255 19 243 19 239 4 233 -14 235 0 225 0 210 -15 195 -42 188 -77 188 -104 195
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 60 255 75 270
Rectangle -16777216 false false 45 240 90 270
Polygon -6459832 true true 255 240 210 240 210 270 255 270
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 210 240 255 270
Circle -16777216 true false 167 120 8
Circle -16777216 true false 125 120 8
Circle -955883 true false 105 165 90
Line -16777216 false 45 135 83 121

alvatorre-charge8.1
false
3
Polygon -1184463 true false -1 156 3 121 15 105 30 114 39 145 29 150
Polygon -16777216 false false -2 155 3 120 14 105 28 113 39 144 29 150
Polygon -6459832 true true 135 45 120 75 90 90 45 135 15 150 -75 165 -120 180 -135 195 -135 225 -120 240 -60 255 15 255 19 243 19 255 60 259 94 259 101 266 112 274 125 280 141 283 150 330 150 -15
Polygon -1184463 true false -135 203 -119 208 -74 198 -43 198 -15 207 29 205 104 215 94 260 52 259 19 255 -60 255 -120 240 -135 225
Rectangle -16777216 false false 210 240 255 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 0 254 15 284 27 276 36 255 15 223
Polygon -16777216 false false 0 255 14 284 25 278 34 256 20 256 19 244 14 255
Polygon -16777216 false false -90 191 -105 210 -105 225 -60 255 15 255 30 210 18 160 -90 180 -105 195
Rectangle -16777216 false false 210 240 255 270
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 301 156 297 121 285 105 270 114 261 145 271 150
Polygon -16777216 false false 302 155 297 120 286 105 272 113 261 144 271 150
Polygon -6459832 true true 165 45 180 75 210 90 255 135 285 150 375 165 420 180 435 195 435 225 420 240 360 255 285 255 281 243 281 255 240 259 206 259 199 266 188 274 175 280 159 283 150 330 150 -15
Circle -1184463 true false 75 135 150
Polygon -16777216 true false 201 197 194 180 187 210 180 180 169 184 168 209 168 212 162 211 156 181 149 176 149 240 162 225 169 225 173 241 184 225 186 239 198 227 194 210
Polygon -16777216 false false 207 258 213 249 218 240 221 232 224 222 225 210 224 197 220 182 213 168 195 145 150 165 150 285 158 285 174 281 187 275 198 267
Polygon -16777216 true false 99 197 106 180 113 210 120 180 131 184 132 209 132 212 138 211 144 181 151 176 151 240 138 225 131 225 127 241 116 225 114 239 102 227 106 210
Rectangle -16777216 false false 210 240 255 270
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -1184463 true false 300 254 285 284 273 276 264 255 285 223
Polygon -1184463 true false 435 203 419 208 374 198 343 198 315 207 271 205 196 215 206 260 248 259 281 255 360 255 420 240 435 225
Polygon -16777216 false false 390 191 405 210 405 225 360 255 285 255 270 210 282 160 390 180 405 195
Polygon -6459832 true true 164 135 166 143 150 149 150 131
Polygon -16777216 true false 185 134 170 104 158 110 166 144
Line -16777216 false 150 -15 165 45
Line -16777216 false 165 45 180 75
Line -16777216 false 180 75 210 90
Line -16777216 false 210 90 255 135
Line -16777216 false 255 135 285 150
Line -16777216 false 15 255 30 210
Line -16777216 false 15 150 30 210
Polygon -16777216 false false 276 187 285 195 315 195 331 190 345 188 361 188 375 188 391 192 406 195 420 198 435 195 420 180 375 165 285 150
Line -16777216 false 157 15 150 8
Line -16777216 false 165 45 150 30
Line -16777216 false 165 144 150 149
Line -16777216 false 210 150 210 135
Line -16777216 false 210 105 165 90
Line -16777216 false 180 95 165 60
Line -16777216 false 195 129 165 144
Line -16777216 false 195 129 204 117
Line -16777216 false 204 118 196 100
Line -16777216 false 165 90 150 102
Line -16777216 false 165 60 150 45
Line -16777216 false 165 90 165 75
Line -16777216 false 165 75 150 68
Line -16777216 false 180 135 218 121
Line -16777216 false 225 105 177 87
Circle -7500403 true false 164 118 13
Polygon -16777216 false false 200 230 195 239 186 250 176 257 163 262 156 263 150 263 157 263 170 260 184 251 194 241 199 232
Polygon -1184463 true false 197 215 224 204 221 189 214 171 195 210
Polygon -1184463 true false 215 170 217 138 200 123 195 131 150 150 150 165 195 145
Polygon -16777216 false false 420 240 389 236 360 240 297 233 280 239 285 255 360 255
Polygon -16777216 false false 135 255 150 330 165 255 149 248
Polygon -16777216 false false 24 187 15 195 -15 195 -31 190 -45 188 -61 188 -75 188 -91 192 -106 195 -120 198 -135 195 -120 180 -75 165 15 150
Polygon -6459832 true true 225 270 240 270 256 274 270 285 195 285 210 274
Rectangle -16777216 false false 225 255 240 270
Line -16777216 false 255 135 217 121
Line -16777216 false 45 135 15 150
Line -16777216 false 90 90 45 135
Line -16777216 false 75 105 123 87
Line -16777216 false 120 75 90 90
Line -16777216 false 135 45 120 75
Line -16777216 false 135 45 150 30
Line -16777216 false 150 -15 135 45
Line -16777216 false 143 15 150 8
Line -16777216 false 135 60 150 45
Line -16777216 false 120 95 135 60
Line -16777216 false 135 75 150 68
Line -16777216 false 135 90 135 75
Line -16777216 false 90 105 135 90
Line -16777216 false 135 90 150 102
Line -16777216 false 96 118 104 100
Polygon -16777216 true false 115 134 130 104 142 110 134 144
Circle -7500403 true false 123 118 13
Line -16777216 false 105 129 96 117
Line -16777216 false 120 135 82 121
Line -16777216 false 105 129 135 144
Line -16777216 false 135 144 150 149
Polygon -6459832 true true 136 135 134 143 150 149 150 131
Polygon -1184463 true false 85 170 83 138 100 123 105 131 150 150 150 165 105 145
Polygon -16777216 false false 100 230 105 239 114 250 124 257 137 262 144 263 150 263 143 263 130 260 116 251 106 241 101 232
Polygon -6459832 true true 75 270 60 270 44 274 30 285 105 285 90 274
Line -16777216 false 225 150 195 210
Line -16777216 false 195 210 206 260
Polygon -16777216 false false 300 255 286 284 275 278 266 256 280 256 281 244 286 255
Line -16777216 false 75 150 105 210
Rectangle -16777216 false false 225 255 240 270
Polygon -1184463 true false 103 215 76 204 79 189 86 171 105 210
Polygon -16777216 false false 93 258 87 249 82 240 79 232 76 222 75 210 76 197 80 182 87 168 105 145 150 165 150 285 142 285 126 281 113 275 102 267
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 60 255 75 270
Polygon -6459832 true true 135 255 150 330 165 255 148 248
Polygon -16777216 false false -120 240 -89 236 -60 240 3 233 20 239 15 255 -60 255
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Line -16777216 false 150 45 150 -15
Polygon -16777216 false false -90 180 75 150 105 210 93 259 58 259 19 255 19 243 19 239 4 233 -14 235 0 225 0 210 -15 195 -42 188 -77 188 -104 195
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 60 255 75 270
Rectangle -16777216 false false 45 240 90 270
Polygon -6459832 true true 255 240 210 240 210 270 255 270
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 210 240 255 270
Circle -16777216 true false 167 120 8
Circle -16777216 true false 125 120 8
Circle -955883 true false 110 170 80
Circle -1184463 true false 130 190 40
Line -16777216 false 45 135 83 121

alvatorre-charge8.2
false
3
Polygon -1184463 true false -1 156 3 121 15 105 30 114 39 145 29 150
Polygon -16777216 false false -2 155 3 120 14 105 28 113 39 144 29 150
Polygon -6459832 true true 135 45 120 75 90 90 45 135 15 150 -75 165 -120 180 -135 195 -135 225 -120 240 -60 255 15 255 19 243 19 255 60 259 94 259 101 266 112 274 125 280 141 283 150 330 150 -15
Polygon -1184463 true false -135 203 -119 208 -74 198 -43 198 -15 207 29 205 104 215 94 260 52 259 19 255 -60 255 -120 240 -135 225
Rectangle -16777216 false false 210 240 255 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 0 254 15 284 27 276 36 255 15 223
Polygon -16777216 false false 0 255 14 284 25 278 34 256 20 256 19 244 14 255
Polygon -16777216 false false -90 191 -105 210 -105 225 -60 255 15 255 30 210 18 160 -90 180 -105 195
Rectangle -16777216 false false 210 240 255 270
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 301 156 297 121 285 105 270 114 261 145 271 150
Polygon -16777216 false false 302 155 297 120 286 105 272 113 261 144 271 150
Polygon -6459832 true true 165 45 180 75 210 90 255 135 285 150 375 165 420 180 435 195 435 225 420 240 360 255 285 255 281 243 281 255 240 259 206 259 199 266 188 274 175 280 159 283 150 330 150 -15
Circle -1184463 true false 75 135 150
Polygon -16777216 true false 201 197 194 180 187 210 180 180 169 184 168 209 168 212 162 211 156 181 149 176 149 240 162 225 169 225 173 241 184 225 186 239 198 227 194 210
Polygon -16777216 false false 207 258 213 249 218 240 221 232 224 222 225 210 224 197 220 182 213 168 195 145 150 165 150 285 158 285 174 281 187 275 198 267
Polygon -16777216 true false 99 197 106 180 113 210 120 180 131 184 132 209 132 212 138 211 144 181 151 176 151 240 138 225 131 225 127 241 116 225 114 239 102 227 106 210
Rectangle -16777216 false false 210 240 255 270
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -1184463 true false 300 254 285 284 273 276 264 255 285 223
Polygon -1184463 true false 435 203 419 208 374 198 343 198 315 207 271 205 196 215 206 260 248 259 281 255 360 255 420 240 435 225
Polygon -16777216 false false 390 191 405 210 405 225 360 255 285 255 270 210 282 160 390 180 405 195
Polygon -6459832 true true 164 135 166 143 150 149 150 131
Polygon -16777216 true false 185 134 170 104 158 110 166 144
Line -16777216 false 150 -15 165 45
Line -16777216 false 165 45 180 75
Line -16777216 false 180 75 210 90
Line -16777216 false 210 90 255 135
Line -16777216 false 255 135 285 150
Line -16777216 false 15 255 30 210
Line -16777216 false 15 150 30 210
Polygon -16777216 false false 276 187 285 195 315 195 331 190 345 188 361 188 375 188 391 192 406 195 420 198 435 195 420 180 375 165 285 150
Line -16777216 false 157 15 150 8
Line -16777216 false 165 45 150 30
Line -16777216 false 165 144 150 149
Line -16777216 false 210 150 210 135
Line -16777216 false 210 105 165 90
Line -16777216 false 180 95 165 60
Line -16777216 false 195 129 165 144
Line -16777216 false 195 129 204 117
Line -16777216 false 204 118 196 100
Line -16777216 false 165 90 150 102
Line -16777216 false 165 60 150 45
Line -16777216 false 165 90 165 75
Line -16777216 false 165 75 150 68
Line -16777216 false 180 135 218 121
Line -16777216 false 225 105 177 87
Circle -7500403 true false 164 118 13
Polygon -16777216 false false 200 230 195 239 186 250 176 257 163 262 156 263 150 263 157 263 170 260 184 251 194 241 199 232
Polygon -1184463 true false 197 215 224 204 221 189 214 171 195 210
Polygon -1184463 true false 215 170 217 138 200 123 195 131 150 150 150 165 195 145
Polygon -16777216 false false 420 240 389 236 360 240 297 233 280 239 285 255 360 255
Polygon -16777216 false false 135 255 150 330 165 255 149 248
Polygon -16777216 false false 24 187 15 195 -15 195 -31 190 -45 188 -61 188 -75 188 -91 192 -106 195 -120 198 -135 195 -120 180 -75 165 15 150
Polygon -6459832 true true 225 270 240 270 256 274 270 285 195 285 210 274
Rectangle -16777216 false false 225 255 240 270
Line -16777216 false 255 135 217 121
Line -16777216 false 45 135 15 150
Line -16777216 false 90 90 45 135
Line -16777216 false 75 105 123 87
Line -16777216 false 120 75 90 90
Line -16777216 false 135 45 120 75
Line -16777216 false 135 45 150 30
Line -16777216 false 150 -15 135 45
Line -16777216 false 143 15 150 8
Line -16777216 false 135 60 150 45
Line -16777216 false 120 95 135 60
Line -16777216 false 135 75 150 68
Line -16777216 false 135 90 135 75
Line -16777216 false 90 105 135 90
Line -16777216 false 135 90 150 102
Line -16777216 false 96 118 104 100
Polygon -16777216 true false 115 134 130 104 142 110 134 144
Circle -7500403 true false 123 118 13
Line -16777216 false 105 129 96 117
Line -16777216 false 120 135 82 121
Line -16777216 false 105 129 135 144
Line -16777216 false 135 144 150 149
Polygon -6459832 true true 136 135 134 143 150 149 150 131
Polygon -1184463 true false 85 170 83 138 100 123 105 131 150 150 150 165 105 145
Polygon -16777216 false false 100 230 105 239 114 250 124 257 137 262 144 263 150 263 143 263 130 260 116 251 106 241 101 232
Polygon -6459832 true true 75 270 60 270 44 274 30 285 105 285 90 274
Line -16777216 false 225 150 195 210
Line -16777216 false 195 210 206 260
Polygon -16777216 false false 300 255 286 284 275 278 266 256 280 256 281 244 286 255
Line -16777216 false 75 150 105 210
Rectangle -16777216 false false 225 255 240 270
Polygon -1184463 true false 103 215 76 204 79 189 86 171 105 210
Polygon -16777216 false false 93 258 87 249 82 240 79 232 76 222 75 210 76 197 80 182 87 168 105 145 150 165 150 285 142 285 126 281 113 275 102 267
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 60 255 75 270
Polygon -6459832 true true 135 255 150 330 165 255 148 248
Polygon -16777216 false false -120 240 -89 236 -60 240 3 233 20 239 15 255 -60 255
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Line -16777216 false 150 45 150 -15
Polygon -16777216 false false -90 180 75 150 105 210 93 259 58 259 19 255 19 243 19 239 4 233 -14 235 0 225 0 210 -15 195 -42 188 -77 188 -104 195
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 60 255 75 270
Rectangle -16777216 false false 45 240 90 270
Polygon -6459832 true true 255 240 210 240 210 270 255 270
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 210 240 255 270
Circle -16777216 true false 167 120 8
Circle -16777216 true false 125 120 8
Circle -955883 true false 110 170 80
Rectangle -955883 true false 110 209 190 266
Rectangle -1184463 true false 130 208 170 266
Circle -1184463 true false 130 190 40
Line -16777216 false 45 135 83 121

alvatorre-charge8.5
false
3
Polygon -1184463 true false -1 156 3 121 15 105 30 114 39 145 29 150
Polygon -16777216 false false -2 155 3 120 14 105 28 113 39 144 29 150
Polygon -6459832 true true 135 45 120 75 90 90 45 135 15 150 -75 165 -120 180 -135 195 -135 225 -120 240 -60 255 15 255 19 243 19 255 60 259 94 259 101 266 112 274 125 280 141 283 150 330 150 -15
Polygon -1184463 true false -135 203 -119 208 -74 198 -43 198 -15 207 29 205 104 215 94 260 52 259 19 255 -60 255 -120 240 -135 225
Rectangle -16777216 false false 210 240 255 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 0 254 15 284 27 276 36 255 15 223
Polygon -16777216 false false 0 255 14 284 25 278 34 256 20 256 19 244 14 255
Polygon -16777216 false false -90 191 -105 210 -105 225 -60 255 15 255 30 210 18 160 -90 180 -105 195
Rectangle -16777216 false false 210 240 255 270
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 301 156 297 121 285 105 270 114 261 145 271 150
Polygon -16777216 false false 302 155 297 120 286 105 272 113 261 144 271 150
Polygon -6459832 true true 165 45 180 75 210 90 255 135 285 150 375 165 420 180 435 195 435 225 420 240 360 255 285 255 281 243 281 255 240 259 206 259 199 266 188 274 175 280 159 283 150 330 150 -15
Circle -1184463 true false 75 135 150
Polygon -16777216 true false 201 197 194 180 187 210 180 180 169 184 168 209 168 212 162 211 156 181 149 176 149 240 162 225 169 225 173 241 184 225 186 239 198 227 194 210
Polygon -16777216 false false 207 258 213 249 218 240 221 232 224 222 225 210 224 197 220 182 213 168 195 145 150 165 150 285 158 285 174 281 187 275 198 267
Polygon -16777216 true false 99 197 106 180 113 210 120 180 131 184 132 209 132 212 138 211 144 181 151 176 151 240 138 225 131 225 127 241 116 225 114 239 102 227 106 210
Rectangle -16777216 false false 210 240 255 270
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -1184463 true false 300 254 285 284 273 276 264 255 285 223
Polygon -1184463 true false 435 203 419 208 374 198 343 198 315 207 271 205 196 215 206 260 248 259 281 255 360 255 420 240 435 225
Polygon -16777216 false false 390 191 405 210 405 225 360 255 285 255 270 210 282 160 390 180 405 195
Polygon -6459832 true true 164 135 166 143 150 149 150 131
Polygon -16777216 true false 185 134 170 104 158 110 166 144
Line -16777216 false 150 -15 165 45
Line -16777216 false 165 45 180 75
Line -16777216 false 180 75 210 90
Line -16777216 false 210 90 255 135
Line -16777216 false 255 135 285 150
Line -16777216 false 15 255 30 210
Line -16777216 false 15 150 30 210
Polygon -16777216 false false 276 187 285 195 315 195 331 190 345 188 361 188 375 188 391 192 406 195 420 198 435 195 420 180 375 165 285 150
Line -16777216 false 157 15 150 8
Line -16777216 false 165 45 150 30
Line -16777216 false 165 144 150 149
Line -16777216 false 210 150 210 135
Line -16777216 false 210 105 165 90
Line -16777216 false 180 95 165 60
Line -16777216 false 195 129 165 144
Line -16777216 false 195 129 204 117
Line -16777216 false 204 118 196 100
Line -16777216 false 165 90 150 102
Line -16777216 false 165 60 150 45
Line -16777216 false 165 90 165 75
Line -16777216 false 165 75 150 68
Line -16777216 false 180 135 218 121
Line -16777216 false 225 105 177 87
Circle -7500403 true false 164 118 13
Polygon -16777216 false false 200 230 195 239 186 250 176 257 163 262 156 263 150 263 157 263 170 260 184 251 194 241 199 232
Polygon -1184463 true false 197 215 224 204 221 189 214 171 195 210
Polygon -1184463 true false 215 170 217 138 200 123 195 131 150 150 150 165 195 145
Polygon -16777216 false false 420 240 389 236 360 240 297 233 280 239 285 255 360 255
Polygon -16777216 false false 135 255 150 330 165 255 149 248
Polygon -16777216 false false 24 187 15 195 -15 195 -31 190 -45 188 -61 188 -75 188 -91 192 -106 195 -120 198 -135 195 -120 180 -75 165 15 150
Polygon -6459832 true true 225 270 240 270 256 274 270 285 195 285 210 274
Rectangle -16777216 false false 225 255 240 270
Line -16777216 false 255 135 217 121
Line -16777216 false 45 135 15 150
Line -16777216 false 90 90 45 135
Line -16777216 false 75 105 123 87
Line -16777216 false 120 75 90 90
Line -16777216 false 135 45 120 75
Line -16777216 false 135 45 150 30
Line -16777216 false 150 -15 135 45
Line -16777216 false 143 15 150 8
Line -16777216 false 135 60 150 45
Line -16777216 false 120 95 135 60
Line -16777216 false 135 75 150 68
Line -16777216 false 135 90 135 75
Line -16777216 false 90 105 135 90
Line -16777216 false 135 90 150 102
Line -16777216 false 96 118 104 100
Polygon -16777216 true false 115 134 130 104 142 110 134 144
Circle -7500403 true false 123 118 13
Line -16777216 false 105 129 96 117
Line -16777216 false 120 135 82 121
Line -16777216 false 105 129 135 144
Line -16777216 false 135 144 150 149
Polygon -6459832 true true 136 135 134 143 150 149 150 131
Polygon -1184463 true false 85 170 83 138 100 123 105 131 150 150 150 165 105 145
Polygon -16777216 false false 100 230 105 239 114 250 124 257 137 262 144 263 150 263 143 263 130 260 116 251 106 241 101 232
Polygon -6459832 true true 75 270 60 270 44 274 30 285 105 285 90 274
Line -16777216 false 225 150 195 210
Line -16777216 false 195 210 206 260
Polygon -16777216 false false 300 255 286 284 275 278 266 256 280 256 281 244 286 255
Line -16777216 false 75 150 105 210
Rectangle -16777216 false false 225 255 240 270
Polygon -1184463 true false 103 215 76 204 79 189 86 171 105 210
Polygon -16777216 false false 93 258 87 249 82 240 79 232 76 222 75 210 76 197 80 182 87 168 105 145 150 165 150 285 142 285 126 281 113 275 102 267
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 60 255 75 270
Polygon -6459832 true true 135 255 150 330 165 255 148 248
Polygon -16777216 false false -120 240 -89 236 -60 240 3 233 20 239 15 255 -60 255
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Line -16777216 false 150 45 150 -15
Polygon -16777216 false false -90 180 75 150 105 210 93 259 58 259 19 255 19 243 19 239 4 233 -14 235 0 225 0 210 -15 195 -42 188 -77 188 -104 195
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 60 255 75 270
Rectangle -16777216 false false 45 240 90 270
Polygon -6459832 true true 255 240 210 240 210 270 255 270
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 210 240 255 270
Circle -16777216 true false 167 120 8
Circle -16777216 true false 125 120 8
Circle -955883 true false 110 170 80
Rectangle -955883 true false 110 209 190 286
Rectangle -1184463 true false 130 208 170 287
Circle -1184463 true false 130 190 40
Line -16777216 false 45 135 83 121

alvatorre-charge8.6
false
3
Polygon -1184463 true false -1 156 3 121 15 105 30 114 39 145 29 150
Polygon -16777216 false false -2 155 3 120 14 105 28 113 39 144 29 150
Polygon -6459832 true true 135 45 120 75 90 90 45 135 15 150 -75 165 -120 180 -135 195 -135 225 -120 240 -60 255 15 255 19 243 19 255 60 259 94 259 101 266 112 274 125 280 141 283 150 330 150 -15
Polygon -1184463 true false -135 203 -119 208 -74 198 -43 198 -15 207 29 205 104 215 94 260 52 259 19 255 -60 255 -120 240 -135 225
Rectangle -16777216 false false 210 240 255 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 0 254 15 284 27 276 36 255 15 223
Polygon -16777216 false false 0 255 14 284 25 278 34 256 20 256 19 244 14 255
Polygon -16777216 false false -90 191 -105 210 -105 225 -60 255 15 255 30 210 18 160 -90 180 -105 195
Rectangle -16777216 false false 210 240 255 270
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 301 156 297 121 285 105 270 114 261 145 271 150
Polygon -16777216 false false 302 155 297 120 286 105 272 113 261 144 271 150
Polygon -6459832 true true 165 45 180 75 210 90 255 135 285 150 375 165 420 180 435 195 435 225 420 240 360 255 285 255 281 243 281 255 240 259 206 259 199 266 188 274 175 280 159 283 150 330 150 -15
Circle -1184463 true false 75 135 150
Polygon -16777216 true false 201 197 194 180 187 210 180 180 169 184 168 209 168 212 162 211 156 181 149 176 149 240 162 225 169 225 173 241 184 225 186 239 198 227 194 210
Polygon -16777216 false false 207 258 213 249 218 240 221 232 224 222 225 210 224 197 220 182 213 168 195 145 150 165 150 285 158 285 174 281 187 275 198 267
Polygon -16777216 true false 99 197 106 180 113 210 120 180 131 184 132 209 132 212 138 211 144 181 151 176 151 240 138 225 131 225 127 241 116 225 114 239 102 227 106 210
Rectangle -16777216 false false 210 240 255 270
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -1184463 true false 300 254 285 284 273 276 264 255 285 223
Polygon -1184463 true false 435 203 419 208 374 198 343 198 315 207 271 205 196 215 206 260 248 259 281 255 360 255 420 240 435 225
Polygon -16777216 false false 390 191 405 210 405 225 360 255 285 255 270 210 282 160 390 180 405 195
Polygon -6459832 true true 164 135 166 143 150 149 150 131
Polygon -16777216 true false 185 134 170 104 158 110 166 144
Line -16777216 false 150 -15 165 45
Line -16777216 false 165 45 180 75
Line -16777216 false 180 75 210 90
Line -16777216 false 210 90 255 135
Line -16777216 false 255 135 285 150
Line -16777216 false 15 255 30 210
Line -16777216 false 15 150 30 210
Polygon -16777216 false false 276 187 285 195 315 195 331 190 345 188 361 188 375 188 391 192 406 195 420 198 435 195 420 180 375 165 285 150
Line -16777216 false 157 15 150 8
Line -16777216 false 165 45 150 30
Line -16777216 false 165 144 150 149
Line -16777216 false 210 150 210 135
Line -16777216 false 210 105 165 90
Line -16777216 false 180 95 165 60
Line -16777216 false 195 129 165 144
Line -16777216 false 195 129 204 117
Line -16777216 false 204 118 196 100
Line -16777216 false 165 90 150 102
Line -16777216 false 165 60 150 45
Line -16777216 false 165 90 165 75
Line -16777216 false 165 75 150 68
Line -16777216 false 180 135 218 121
Line -16777216 false 225 105 177 87
Circle -7500403 true false 164 118 13
Polygon -16777216 false false 200 230 195 239 186 250 176 257 163 262 156 263 150 263 157 263 170 260 184 251 194 241 199 232
Polygon -1184463 true false 197 215 224 204 221 189 214 171 195 210
Polygon -1184463 true false 215 170 217 138 200 123 195 131 150 150 150 165 195 145
Polygon -16777216 false false 420 240 389 236 360 240 297 233 280 239 285 255 360 255
Polygon -16777216 false false 135 255 150 330 165 255 149 248
Polygon -16777216 false false 24 187 15 195 -15 195 -31 190 -45 188 -61 188 -75 188 -91 192 -106 195 -120 198 -135 195 -120 180 -75 165 15 150
Polygon -6459832 true true 225 270 240 270 256 274 270 285 195 285 210 274
Rectangle -16777216 false false 225 255 240 270
Line -16777216 false 255 135 217 121
Line -16777216 false 45 135 15 150
Line -16777216 false 90 90 45 135
Line -16777216 false 75 105 123 87
Line -16777216 false 120 75 90 90
Line -16777216 false 135 45 120 75
Line -16777216 false 135 45 150 30
Line -16777216 false 150 -15 135 45
Line -16777216 false 143 15 150 8
Line -16777216 false 135 60 150 45
Line -16777216 false 120 95 135 60
Line -16777216 false 135 75 150 68
Line -16777216 false 135 90 135 75
Line -16777216 false 90 105 135 90
Line -16777216 false 135 90 150 102
Line -16777216 false 96 118 104 100
Polygon -16777216 true false 115 134 130 104 142 110 134 144
Circle -7500403 true false 123 118 13
Line -16777216 false 105 129 96 117
Line -16777216 false 120 135 82 121
Line -16777216 false 105 129 135 144
Line -16777216 false 135 144 150 149
Polygon -6459832 true true 136 135 134 143 150 149 150 131
Polygon -1184463 true false 85 170 83 138 100 123 105 131 150 150 150 165 105 145
Polygon -16777216 false false 100 230 105 239 114 250 124 257 137 262 144 263 150 263 143 263 130 260 116 251 106 241 101 232
Polygon -6459832 true true 75 270 60 270 44 274 30 285 105 285 90 274
Line -16777216 false 225 150 195 210
Line -16777216 false 195 210 206 260
Polygon -16777216 false false 300 255 286 284 275 278 266 256 280 256 281 244 286 255
Line -16777216 false 75 150 105 210
Rectangle -16777216 false false 225 255 240 270
Polygon -1184463 true false 103 215 76 204 79 189 86 171 105 210
Polygon -16777216 false false 93 258 87 249 82 240 79 232 76 222 75 210 76 197 80 182 87 168 105 145 150 165 150 285 142 285 126 281 113 275 102 267
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 60 255 75 270
Polygon -6459832 true true 135 255 150 330 165 255 148 248
Polygon -16777216 false false -120 240 -89 236 -60 240 3 233 20 239 15 255 -60 255
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Line -16777216 false 150 45 150 -15
Polygon -16777216 false false -90 180 75 150 105 210 93 259 58 259 19 255 19 243 19 239 4 233 -14 235 0 225 0 210 -15 195 -42 188 -77 188 -104 195
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 60 255 75 270
Rectangle -16777216 false false 45 240 90 270
Polygon -6459832 true true 255 240 210 240 210 270 255 270
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 210 240 255 270
Circle -16777216 true false 167 120 8
Circle -16777216 true false 125 120 8
Circle -955883 true false 110 170 80
Rectangle -955883 true false 110 209 190 302
Rectangle -1184463 true false 130 208 170 304
Circle -1184463 true false 130 190 40
Line -16777216 false 45 135 83 121

alvatorre-charge8.7
false
3
Polygon -1184463 true false -1 156 3 121 15 105 30 114 39 145 29 150
Polygon -16777216 false false -2 155 3 120 14 105 28 113 39 144 29 150
Polygon -6459832 true true 135 45 120 75 90 90 45 135 15 150 -75 165 -120 180 -135 195 -135 225 -120 240 -60 255 15 255 19 243 19 255 60 259 94 259 101 266 112 274 125 280 141 283 150 330 150 -15
Polygon -1184463 true false -135 203 -119 208 -74 198 -43 198 -15 207 29 205 104 215 94 260 52 259 19 255 -60 255 -120 240 -135 225
Rectangle -16777216 false false 210 240 255 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 0 254 15 284 27 276 36 255 15 223
Polygon -16777216 false false 0 255 14 284 25 278 34 256 20 256 19 244 14 255
Polygon -16777216 false false -90 191 -105 210 -105 225 -60 255 15 255 30 210 18 160 -90 180 -105 195
Rectangle -16777216 false false 210 240 255 270
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 301 156 297 121 285 105 270 114 261 145 271 150
Polygon -16777216 false false 302 155 297 120 286 105 272 113 261 144 271 150
Polygon -6459832 true true 165 45 180 75 210 90 255 135 285 150 375 165 420 180 435 195 435 225 420 240 360 255 285 255 281 243 281 255 240 259 206 259 199 266 188 274 175 280 159 283 150 330 150 -15
Circle -1184463 true false 75 135 150
Polygon -16777216 true false 201 197 194 180 187 210 180 180 169 184 168 209 168 212 162 211 156 181 149 176 149 240 162 225 169 225 173 241 184 225 186 239 198 227 194 210
Polygon -16777216 false false 207 258 213 249 218 240 221 232 224 222 225 210 224 197 220 182 213 168 195 145 150 165 150 285 158 285 174 281 187 275 198 267
Polygon -16777216 true false 99 197 106 180 113 210 120 180 131 184 132 209 132 212 138 211 144 181 151 176 151 240 138 225 131 225 127 241 116 225 114 239 102 227 106 210
Rectangle -16777216 false false 210 240 255 270
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -1184463 true false 300 254 285 284 273 276 264 255 285 223
Polygon -1184463 true false 435 203 419 208 374 198 343 198 315 207 271 205 196 215 206 260 248 259 281 255 360 255 420 240 435 225
Polygon -16777216 false false 390 191 405 210 405 225 360 255 285 255 270 210 282 160 390 180 405 195
Polygon -6459832 true true 164 135 166 143 150 149 150 131
Polygon -16777216 true false 185 134 170 104 158 110 166 144
Line -16777216 false 150 -15 165 45
Line -16777216 false 165 45 180 75
Line -16777216 false 180 75 210 90
Line -16777216 false 210 90 255 135
Line -16777216 false 255 135 285 150
Line -16777216 false 15 255 30 210
Line -16777216 false 15 150 30 210
Polygon -16777216 false false 276 187 285 195 315 195 331 190 345 188 361 188 375 188 391 192 406 195 420 198 435 195 420 180 375 165 285 150
Line -16777216 false 157 15 150 8
Line -16777216 false 165 45 150 30
Line -16777216 false 165 144 150 149
Line -16777216 false 210 150 210 135
Line -16777216 false 210 105 165 90
Line -16777216 false 180 95 165 60
Line -16777216 false 195 129 165 144
Line -16777216 false 195 129 204 117
Line -16777216 false 204 118 196 100
Line -16777216 false 165 90 150 102
Line -16777216 false 165 60 150 45
Line -16777216 false 165 90 165 75
Line -16777216 false 165 75 150 68
Line -16777216 false 180 135 218 121
Line -16777216 false 225 105 177 87
Circle -7500403 true false 164 118 13
Polygon -16777216 false false 200 230 195 239 186 250 176 257 163 262 156 263 150 263 157 263 170 260 184 251 194 241 199 232
Polygon -1184463 true false 197 215 224 204 221 189 214 171 195 210
Polygon -1184463 true false 215 170 217 138 200 123 195 131 150 150 150 165 195 145
Polygon -16777216 false false 420 240 389 236 360 240 297 233 280 239 285 255 360 255
Polygon -16777216 false false 135 255 150 330 165 255 149 248
Polygon -16777216 false false 24 187 15 195 -15 195 -31 190 -45 188 -61 188 -75 188 -91 192 -106 195 -120 198 -135 195 -120 180 -75 165 15 150
Polygon -6459832 true true 225 270 240 270 256 274 270 285 195 285 210 274
Rectangle -16777216 false false 225 255 240 270
Line -16777216 false 255 135 217 121
Line -16777216 false 45 135 15 150
Line -16777216 false 90 90 45 135
Line -16777216 false 75 105 123 87
Line -16777216 false 120 75 90 90
Line -16777216 false 135 45 120 75
Line -16777216 false 135 45 150 30
Line -16777216 false 150 -15 135 45
Line -16777216 false 143 15 150 8
Line -16777216 false 135 60 150 45
Line -16777216 false 120 95 135 60
Line -16777216 false 135 75 150 68
Line -16777216 false 135 90 135 75
Line -16777216 false 90 105 135 90
Line -16777216 false 135 90 150 102
Line -16777216 false 96 118 104 100
Polygon -16777216 true false 115 134 130 104 142 110 134 144
Circle -7500403 true false 123 118 13
Line -16777216 false 105 129 96 117
Line -16777216 false 120 135 82 121
Line -16777216 false 105 129 135 144
Line -16777216 false 135 144 150 149
Polygon -6459832 true true 136 135 134 143 150 149 150 131
Polygon -1184463 true false 85 170 83 138 100 123 105 131 150 150 150 165 105 145
Polygon -16777216 false false 100 230 105 239 114 250 124 257 137 262 144 263 150 263 143 263 130 260 116 251 106 241 101 232
Polygon -6459832 true true 75 270 60 270 44 274 30 285 105 285 90 274
Line -16777216 false 225 150 195 210
Line -16777216 false 195 210 206 260
Polygon -16777216 false false 300 255 286 284 275 278 266 256 280 256 281 244 286 255
Line -16777216 false 75 150 105 210
Rectangle -16777216 false false 225 255 240 270
Polygon -1184463 true false 103 215 76 204 79 189 86 171 105 210
Polygon -16777216 false false 93 258 87 249 82 240 79 232 76 222 75 210 76 197 80 182 87 168 105 145 150 165 150 285 142 285 126 281 113 275 102 267
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 60 255 75 270
Polygon -6459832 true true 135 255 150 330 165 255 148 248
Polygon -16777216 false false -120 240 -89 236 -60 240 3 233 20 239 15 255 -60 255
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Line -16777216 false 150 45 150 -15
Polygon -16777216 false false -90 180 75 150 105 210 93 259 58 259 19 255 19 243 19 239 4 233 -14 235 0 225 0 210 -15 195 -42 188 -77 188 -104 195
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 60 255 75 270
Rectangle -16777216 false false 45 240 90 270
Polygon -6459832 true true 255 240 210 240 210 270 255 270
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 210 240 255 270
Circle -16777216 true false 167 120 8
Circle -16777216 true false 125 120 8
Circle -955883 true false 110 170 80
Rectangle -955883 true false 110 210 190 312
Rectangle -1184463 true false 130 208 170 311
Circle -1184463 true false 130 190 40
Line -16777216 false 45 135 83 121

alvatorre-charge9
false
3
Polygon -1184463 true false -1 156 3 121 15 105 30 114 39 145 29 150
Polygon -16777216 false false -2 155 3 120 14 105 28 113 39 144 29 150
Polygon -6459832 true true 135 45 120 75 90 90 45 135 15 150 -75 165 -120 180 -135 195 -135 225 -120 240 -60 255 15 255 19 243 19 255 60 259 94 259 101 266 112 274 125 280 141 283 150 330 150 -15
Polygon -1184463 true false -135 203 -119 208 -74 198 -43 198 -15 207 29 205 104 215 94 260 52 259 19 255 -60 255 -120 240 -135 225
Rectangle -16777216 false false 210 240 255 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 0 254 15 284 27 276 36 255 15 223
Polygon -16777216 false false 0 255 14 284 25 278 34 256 20 256 19 244 14 255
Polygon -16777216 false false -90 191 -105 210 -105 225 -60 255 15 255 30 210 18 160 -90 180 -105 195
Rectangle -16777216 false false 210 240 255 270
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 45 240 90 270
Polygon -1184463 true false 301 156 297 121 285 105 270 114 261 145 271 150
Polygon -16777216 false false 302 155 297 120 286 105 272 113 261 144 271 150
Polygon -6459832 true true 165 45 180 75 210 90 255 135 285 150 375 165 420 180 435 195 435 225 420 240 360 255 285 255 281 243 281 255 240 259 206 259 199 266 188 274 175 280 159 283 150 330 150 -15
Circle -1184463 true false 75 135 150
Polygon -16777216 true false 201 197 194 180 187 210 180 180 169 184 168 209 168 212 162 211 156 181 149 176 149 240 162 225 169 225 173 241 184 225 186 239 198 227 194 210
Polygon -16777216 false false 207 258 213 249 218 240 221 232 224 222 225 210 224 197 220 182 213 168 195 145 150 165 150 285 158 285 174 281 187 275 198 267
Polygon -16777216 true false 99 197 106 180 113 210 120 180 131 184 132 209 132 212 138 211 144 181 151 176 151 240 138 225 131 225 127 241 116 225 114 239 102 227 106 210
Rectangle -16777216 false false 210 240 255 270
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Polygon -1184463 true false 300 254 285 284 273 276 264 255 285 223
Polygon -1184463 true false 435 203 419 208 374 198 343 198 315 207 271 205 196 215 206 260 248 259 281 255 360 255 420 240 435 225
Polygon -16777216 false false 390 191 405 210 405 225 360 255 285 255 270 210 282 160 390 180 405 195
Polygon -6459832 true true 164 135 166 143 150 149 150 131
Polygon -16777216 true false 185 134 170 104 158 110 166 144
Line -16777216 false 150 -15 165 45
Line -16777216 false 165 45 180 75
Line -16777216 false 180 75 210 90
Line -16777216 false 210 90 255 135
Line -16777216 false 255 135 285 150
Line -16777216 false 15 255 30 210
Line -16777216 false 15 150 30 210
Polygon -16777216 false false 276 187 285 195 315 195 331 190 345 188 361 188 375 188 391 192 406 195 420 198 435 195 420 180 375 165 285 150
Line -16777216 false 157 15 150 8
Line -16777216 false 165 45 150 30
Line -16777216 false 165 144 150 149
Line -16777216 false 210 150 210 135
Line -16777216 false 210 105 165 90
Line -16777216 false 180 95 165 60
Line -16777216 false 195 129 165 144
Line -16777216 false 195 129 204 117
Line -16777216 false 204 118 196 100
Line -16777216 false 165 90 150 102
Line -16777216 false 165 60 150 45
Line -16777216 false 165 90 165 75
Line -16777216 false 165 75 150 68
Line -16777216 false 180 135 218 121
Line -16777216 false 225 105 177 87
Circle -7500403 true false 164 118 13
Polygon -16777216 false false 200 230 195 239 186 250 176 257 163 262 156 263 150 263 157 263 170 260 184 251 194 241 199 232
Polygon -1184463 true false 197 215 224 204 221 189 214 171 195 210
Polygon -1184463 true false 215 170 217 138 200 123 195 131 150 150 150 165 195 145
Polygon -16777216 false false 420 240 389 236 360 240 297 233 280 239 285 255 360 255
Polygon -16777216 false false 135 255 150 330 165 255 149 248
Polygon -16777216 false false 24 187 15 195 -15 195 -31 190 -45 188 -61 188 -75 188 -91 192 -106 195 -120 198 -135 195 -120 180 -75 165 15 150
Polygon -6459832 true true 225 270 240 270 256 274 270 285 195 285 210 274
Rectangle -16777216 false false 225 255 240 270
Line -16777216 false 255 135 217 121
Line -16777216 false 45 135 15 150
Line -16777216 false 90 90 45 135
Line -16777216 false 75 105 123 87
Line -16777216 false 120 75 90 90
Line -16777216 false 135 45 120 75
Line -16777216 false 135 45 150 30
Line -16777216 false 150 -15 135 45
Line -16777216 false 143 15 150 8
Line -16777216 false 135 60 150 45
Line -16777216 false 120 95 135 60
Line -16777216 false 135 75 150 68
Line -16777216 false 135 90 135 75
Line -16777216 false 90 105 135 90
Line -16777216 false 135 90 150 102
Line -16777216 false 96 118 104 100
Polygon -16777216 true false 115 134 130 104 142 110 134 144
Circle -7500403 true false 123 118 13
Line -16777216 false 105 129 96 117
Line -16777216 false 120 135 82 121
Line -16777216 false 105 129 135 144
Line -16777216 false 135 144 150 149
Polygon -6459832 true true 136 135 134 143 150 149 150 131
Polygon -1184463 true false 85 170 83 138 100 123 105 131 150 150 150 165 105 145
Polygon -16777216 false false 100 230 105 239 114 250 124 257 137 262 144 263 150 263 143 263 130 260 116 251 106 241 101 232
Polygon -6459832 true true 75 270 60 270 44 274 30 285 105 285 90 274
Line -16777216 false 225 150 195 210
Line -16777216 false 195 210 206 260
Polygon -16777216 false false 300 255 286 284 275 278 266 256 280 256 281 244 286 255
Line -16777216 false 75 150 105 210
Rectangle -16777216 false false 225 255 240 270
Polygon -1184463 true false 103 215 76 204 79 189 86 171 105 210
Polygon -16777216 false false 93 258 87 249 82 240 79 232 76 222 75 210 76 197 80 182 87 168 105 145 150 165 150 285 142 285 126 281 113 275 102 267
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 60 255 75 270
Polygon -6459832 true true 135 255 150 330 165 255 148 248
Polygon -16777216 false false -120 240 -89 236 -60 240 3 233 20 239 15 255 -60 255
Polygon -16777216 false false 390 180 225 150 195 210 207 259 242 259 281 255 281 243 281 239 296 233 314 235 300 225 300 210 315 195 342 188 377 188 404 195
Line -16777216 false 150 45 150 -15
Polygon -16777216 false false -90 180 75 150 105 210 93 259 58 259 19 255 19 243 19 239 4 233 -14 235 0 225 0 210 -15 195 -42 188 -77 188 -104 195
Polygon -6459832 true true 45 240 90 240 90 270 45 270
Rectangle -16777216 false false 60 255 75 270
Rectangle -16777216 false false 45 240 90 270
Polygon -6459832 true true 255 240 210 240 210 270 255 270
Rectangle -16777216 false false 225 255 240 270
Rectangle -16777216 false false 210 240 255 270
Circle -16777216 true false 167 120 8
Circle -16777216 true false 125 120 8
Circle -955883 true false 110 170 80
Rectangle -955883 true false 110 211 190 346
Rectangle -1184463 true false 130 212 170 347
Circle -1184463 true false 130 190 40
Line -16777216 false 45 135 83 121

alvatorre1
false
0
Circle -6459832 false false 231 156 108
Polygon -6459832 false false 285 330 270 255 285 248
Circle -6459832 false false 210 135 150
Line -6459832 false 285 -15 270 45
Line -6459832 false 270 45 255 75
Line -6459832 false 255 75 225 90
Line -6459832 false 225 90 180 135
Line -6459832 false 180 135 150 150
Line -6459832 false 0 195 0 225
Line -6459832 false 0 225 15 240
Line -6459832 false 15 240 75 255
Line -6459832 false 75 255 150 255
Line -6459832 false 150 255 165 210
Line -6459832 false 150 150 165 210
Line -6459832 false 154 243 154 255
Line -6459832 false 154 255 196 259
Line -6459832 false 196 259 229 259
Polygon -6459832 false false 159 187 150 195 120 195 104 190 90 188 74 188 60 188 44 192 29 195 15 198 0 195 15 180 60 165 150 150
Line -6459832 false 30 195 45 180
Line -6459832 false 45 180 210 150
Line -6459832 false 210 150 240 210
Line -6459832 false 240 210 229 259
Line -6459832 false 278 15 285 8
Line -6459832 false 270 45 285 30
Line -6459832 false 300 120 300 0
Line -6459832 false 220 170 240 145
Line -6459832 false 270 144 285 149
Line -6459832 false 210 150 210 135
Line -6459832 false 210 135 225 105
Line -6459832 false 225 105 270 90
Line -6459832 false 255 95 270 60
Line -6459832 false 15 240 45 236
Line -6459832 false 45 236 76 240
Line -6459832 false 75 240 135 233
Line -6459832 false 136 233 155 239
Line -6459832 false 240 129 270 144
Line -6459832 false 240 129 231 117
Line -6459832 false 231 118 239 100
Line -6459832 false 250 134 265 104
Line -6459832 false 265 104 275 110
Line -6459832 false 275 111 269 144
Line -6459832 false 240 145 285 167
Circle -6459832 false false 259 119 12
Line -6459832 false 45 192 30 210
Line -6459832 false 30 210 30 225
Line -6459832 false 30 225 75 255
Line -6459832 false 120 195 135 210
Line -6459832 false 135 210 135 225
Line -6459832 false 135 225 120 235
Line -6459832 false 285 -15 285 255
Line -6459832 false 270 90 285 102
Line -6459832 false 270 60 285 45
Line -6459832 false 270 90 270 75
Line -6459832 false 270 75 285 68
Line -6459832 false 233 196 240 180
Line -6459832 false 240 180 247 210
Line -6459832 false 250 226 248 238
Line -6459832 false 247 238 236 226
Line -6459832 false 247 210 254 180
Line -6459832 false 255 180 265 184
Line -6459832 false 265 184 266 210
Line -6459832 false 272 210 278 180
Line -6459832 false 279 180 285 176
Line -6459832 false 285 240 272 225
Line -6459832 false 266 211 272 211
Line -6459832 false 272 225 266 225
Line -6459832 false 265 226 261 241
Line -6459832 false 250 225 261 241

alvatorre2
false
0
Polygon -6459832 true false 180 240 225 240 225 270 180 270
Polygon -6459832 true false 135 255 150 285 162 277 171 256 150 224
Polygon -6459832 true false 119 156 123 121 135 105 150 114 159 145 146 196
Polygon -6459832 true false 270 45 255 75 225 90 180 135 150 150 60 165 15 180 0 195 0 225 15 240 75 255 150 255 154 243 154 255 195 259 229 259 236 266 247 274 260 280 276 283 285 330 285 -15
Circle -16777216 false false 231 156 108
Polygon -16777216 false false 285 330 270 255 285 248
Line -16777216 false 285 -15 270 45
Line -16777216 false 270 45 255 75
Line -16777216 false 255 75 225 90
Line -16777216 false 225 90 180 135
Line -16777216 false 180 135 150 150
Line -16777216 false 0 195 0 225
Line -16777216 false 0 225 15 240
Line -16777216 false 15 240 75 255
Line -16777216 false 75 255 150 255
Line -16777216 false 150 255 165 210
Line -16777216 false 150 150 165 210
Line -16777216 false 154 243 154 255
Line -16777216 false 154 255 196 259
Line -16777216 false 196 259 229 259
Polygon -16777216 false false 159 187 150 195 120 195 104 190 90 188 74 188 60 188 44 192 29 195 15 198 0 195 15 180 60 165 150 150
Line -16777216 false 30 195 45 180
Line -16777216 false 45 180 210 150
Line -16777216 false 210 150 240 210
Line -16777216 false 240 210 229 259
Line -16777216 false 278 15 285 8
Line -16777216 false 270 45 285 30
Line -6459832 false 300 120 300 0
Line -16777216 false 220 170 240 145
Line -16777216 false 270 144 285 149
Line -16777216 false 210 150 210 135
Line -16777216 false 210 135 225 105
Line -16777216 false 225 105 270 90
Line -16777216 false 255 95 270 60
Line -16777216 false 15 240 45 236
Line -16777216 false 45 236 76 240
Line -16777216 false 75 240 135 233
Line -16777216 false 136 233 155 239
Line -16777216 false 240 129 270 144
Line -16777216 false 240 129 231 117
Line -16777216 false 231 118 239 100
Line -16777216 false 250 134 265 104
Line -16777216 false 265 104 275 110
Line -16777216 false 275 111 269 144
Line -16777216 false 240 145 285 167
Circle -16777216 false false 259 119 12
Line -16777216 false 45 192 30 210
Line -16777216 false 30 210 30 225
Line -16777216 false 30 225 75 255
Line -16777216 false 120 195 135 210
Line -16777216 false 135 210 135 225
Line -16777216 false 135 225 120 235
Line -16777216 false 285 -15 285 255
Line -16777216 false 270 90 285 102
Line -16777216 false 270 60 285 45
Line -16777216 false 270 90 270 75
Line -16777216 false 270 75 285 68
Line -16777216 false 233 196 240 180
Line -16777216 false 240 180 247 210
Line -16777216 false 250 226 248 238
Line -16777216 false 247 238 236 226
Line -16777216 false 247 210 254 180
Line -16777216 false 255 180 265 184
Line -16777216 false 265 184 266 210
Line -16777216 false 272 210 278 180
Line -16777216 false 279 180 285 176
Line -16777216 false 285 240 272 225
Line -16777216 false 266 211 272 211
Line -16777216 false 272 225 266 225
Line -16777216 false 265 226 261 241
Line -16777216 false 250 225 261 241
Circle -16777216 false false 210 135 150
Line -16777216 false 119 156 123 119
Line -16777216 false 124 119 135 105
Line -16777216 false 135 105 150 114
Line -16777216 false 149 114 160 144
Line -16777216 false 135 255 150 285
Line -16777216 false 170 256 161 276
Line -16777216 false 150 285 161 277
Rectangle -16777216 false false 180 240 225 270
Polygon -16777216 false false 195 270 165 285 240 285 210 270
Rectangle -16777216 false false 195 255 210 270
Line -16777216 false 180 135 218 121
Line -16777216 false 210 105 258 87
Polygon -6459832 true false 210 270 195 270 179 274 165 285 240 285 225 274

alvatorre3
false
1
Polygon -6459832 true false 270 45 255 75 225 90 180 135 150 150 60 165 15 180 0 195 0 225 15 240 75 255 150 255 154 243 154 255 195 259 229 259 236 266 247 274 260 280 276 283 285 330 285 -15
Polygon -16777216 false false 228 258 222 249 217 240 214 232 211 222 210 210 211 197 215 182 222 168 240 145 285 165 285 285 277 285 261 281 248 275 237 267
Polygon -16777216 true false 250 134 265 104 277 110 269 144
Polygon -6459832 true false 180 240 225 240 225 270 180 270
Polygon -6459832 true false 135 255 150 285 162 277 171 256 150 224
Polygon -6459832 true false 119 156 123 121 135 105 150 114 159 145 146 196
Polygon -16777216 false false 285 330 270 255 285 248
Line -16777216 false 285 -15 270 45
Line -16777216 false 270 45 255 75
Line -16777216 false 255 75 225 90
Line -16777216 false 225 90 180 135
Line -16777216 false 180 135 150 150
Line -16777216 false 0 195 0 225
Line -16777216 false 0 225 15 240
Line -16777216 false 15 240 75 255
Line -16777216 false 75 255 150 255
Line -16777216 false 150 255 165 210
Line -16777216 false 150 150 165 210
Line -16777216 false 154 243 154 255
Line -16777216 false 154 255 196 259
Line -16777216 false 196 259 229 259
Polygon -16777216 false false 159 187 150 195 120 195 104 190 90 188 74 188 60 188 44 192 29 195 15 198 0 195 15 180 60 165 150 150
Line -16777216 false 30 195 45 180
Line -16777216 false 45 180 210 150
Line -16777216 false 210 150 240 210
Line -16777216 false 240 210 229 259
Line -16777216 false 278 15 285 8
Line -16777216 false 270 45 285 30
Line -6459832 false 300 120 300 0
Line -16777216 false 270 144 285 149
Line -16777216 false 210 150 210 135
Line -16777216 false 210 135 225 105
Line -16777216 false 225 105 270 90
Line -16777216 false 255 95 270 60
Line -16777216 false 15 240 45 236
Line -16777216 false 45 236 76 240
Line -16777216 false 75 240 135 233
Line -16777216 false 136 233 155 239
Line -16777216 false 240 129 270 144
Line -16777216 false 240 129 231 117
Line -16777216 false 231 118 239 100
Line -16777216 false 45 192 30 210
Line -16777216 false 30 210 30 225
Line -16777216 false 30 225 75 255
Line -16777216 false 120 195 135 210
Line -16777216 false 135 210 135 225
Line -16777216 false 135 225 120 235
Line -16777216 false 285 -15 285 255
Line -16777216 false 270 90 285 102
Line -16777216 false 270 60 285 45
Line -16777216 false 270 90 270 75
Line -16777216 false 270 75 285 68
Line -16777216 false 233 196 240 180
Line -16777216 false 240 180 247 210
Line -16777216 false 250 226 248 238
Line -16777216 false 247 238 236 226
Line -16777216 false 247 210 254 180
Line -16777216 false 255 180 265 184
Line -16777216 false 265 184 266 210
Line -16777216 false 272 210 278 180
Line -16777216 false 279 180 285 176
Line -16777216 false 285 240 272 225
Line -16777216 false 266 211 272 211
Line -16777216 false 272 225 266 225
Line -16777216 false 265 226 261 241
Line -16777216 false 250 225 261 241
Line -16777216 false 119 156 123 119
Line -16777216 false 124 119 135 105
Line -16777216 false 135 105 150 114
Line -16777216 false 149 114 160 144
Line -16777216 false 135 255 150 285
Line -16777216 false 170 256 161 276
Line -16777216 false 150 285 161 277
Rectangle -16777216 false false 180 240 225 270
Polygon -16777216 false false 195 270 165 285 240 285 210 270
Rectangle -16777216 false false 195 255 210 270
Line -16777216 false 180 135 218 121
Line -16777216 false 210 105 258 87
Polygon -6459832 true false 210 270 195 270 179 274 165 285 240 285 225 274
Circle -7500403 true false 258 118 13
Polygon -16777216 false false 235 230 240 239 249 250 259 257 272 262 279 263 285 263 278 263 265 260 251 251 241 241 236 232
Polygon -16777216 true false 234 197 241 180 248 210 255 180 266 184 267 209 267 212 273 211 279 181 286 176 286 240 273 225 266 225 262 241 251 225 249 239 237 227 241 210

alvatorre5
false
4
Polygon -6459832 true false 270 45 255 75 225 90 180 135 150 150 60 165 15 180 0 195 0 225 15 240 75 255 150 255 154 243 154 255 195 259 229 259 236 266 247 274 260 280 276 283 285 330 285 -15
Polygon -1184463 true true 0 203 16 208 61 198 92 198 120 207 164 205 239 215 229 260 187 259 154 255 75 255 15 240 0 225
Polygon -16777216 false false 45 180 210 150 240 210 228 259 193 259 154 255 154 243 154 239 139 233 121 235 135 225 135 210 120 195 93 188 58 188 31 195
Polygon -16777216 false false 45 191 30 210 30 225 75 255 150 255 165 210 153 160 45 180 30 195
Polygon -16777216 false false 135 255 149 284 160 278 169 256 155 256 154 244 149 255
Polygon -16777216 false false 118 155 123 120 134 105 148 113 159 144 149 150
Circle -1184463 true true 210 135 150
Polygon -6459832 true false 271 135 269 143 285 149 285 131
Polygon -16777216 false false 228 258 222 249 217 240 214 232 211 222 210 210 211 197 215 182 222 168 240 145 285 165 285 285 277 285 261 281 248 275 237 267
Polygon -16777216 true false 250 134 265 104 277 110 269 144
Polygon -6459832 true false 180 240 225 240 225 270 180 270
Polygon -1184463 true true 135 254 150 284 162 276 171 255 150 223
Polygon -1184463 true true 119 156 123 121 135 105 150 114 159 145 149 150
Line -16777216 false 285 -15 270 45
Line -16777216 false 270 45 255 75
Line -16777216 false 255 75 225 90
Line -16777216 false 225 90 180 135
Line -16777216 false 180 135 150 150
Line -16777216 false 0 195 0 225
Line -16777216 false 0 225 15 240
Line -16777216 false 150 255 165 210
Line -16777216 false 150 150 165 210
Line -16777216 false 154 243 154 255
Line -16777216 false 154 255 196 259
Line -16777216 false 196 259 229 259
Polygon -16777216 false false 159 187 150 195 120 195 104 190 90 188 74 188 60 188 44 192 29 195 15 198 0 195 15 180 60 165 150 150
Line -16777216 false 30 195 45 180
Line -16777216 false 45 180 210 150
Line -16777216 false 210 150 240 210
Line -16777216 false 240 210 229 259
Line -16777216 false 278 15 285 8
Line -16777216 false 270 45 285 30
Line -6459832 false 300 120 300 0
Line -16777216 false 270 144 285 149
Line -16777216 false 210 150 210 135
Line -16777216 false 210 135 225 105
Line -16777216 false 225 105 270 90
Line -16777216 false 255 95 270 60
Line -16777216 false 240 129 270 144
Line -16777216 false 240 129 231 117
Line -16777216 false 231 118 239 100
Line -16777216 false 285 -15 285 255
Line -16777216 false 270 90 285 102
Line -16777216 false 270 60 285 45
Line -16777216 false 270 90 270 75
Line -16777216 false 270 75 285 68
Line -16777216 false 233 196 240 180
Line -16777216 false 240 180 247 210
Line -16777216 false 250 226 248 238
Line -16777216 false 247 238 236 226
Line -16777216 false 247 210 254 180
Line -16777216 false 255 180 265 184
Line -16777216 false 265 184 266 210
Line -16777216 false 272 210 278 180
Line -16777216 false 279 180 285 176
Line -16777216 false 285 240 272 225
Line -16777216 false 266 211 272 211
Line -16777216 false 272 225 266 225
Line -16777216 false 265 226 261 241
Line -16777216 false 250 225 261 241
Rectangle -16777216 false false 180 240 225 270
Polygon -16777216 false false 195 270 165 285 240 285 210 270
Rectangle -16777216 false false 195 255 210 270
Line -16777216 false 180 135 218 121
Line -16777216 false 210 105 258 87
Polygon -6459832 true false 210 270 195 270 179 274 165 285 240 285 225 274
Circle -7500403 true false 258 118 13
Polygon -16777216 false false 235 230 240 239 249 250 259 257 272 262 279 263 285 263 278 263 265 260 251 251 241 241 236 232
Polygon -16777216 true false 234 197 241 180 248 210 255 180 266 184 267 209 267 212 273 211 279 181 286 176 286 240 273 225 266 225 262 241 251 225 249 239 237 227 241 210
Polygon -1184463 true true 238 215 211 204 214 189 221 171 240 210
Polygon -1184463 true true 220 170 218 138 235 123 240 131 285 150 285 165 240 145
Polygon -16777216 false false 15 240 46 236 75 240 138 233 155 239 150 255 75 255
Polygon -16777216 false false 270 255 285 330 300 255 284 248

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

asteriod1
true
10
Polygon -13345367 true true 149 30 119 45 89 45 59 60 44 75 25 77 19 119 21 137 35 161 74 195 100 222 121 249 135 260 156 264 209 255 224 225 239 195 254 165 253 154 238 131 273 101 238 91 214 93 217 72 209 30 164 30
Polygon -1 true false 30 105 60 135 151 179 195 75 195 45 210 30 150 30 120 45 91 38 68 39 26 76
Polygon -7500403 true false 136 174 157 265 210 255 252 211 268 154 259 129 274 102 210 30 210 60 195 75

asteriod2
true
10
Polygon -7500403 true false 150 30 120 30 105 45 90 45 60 60 45 75 30 105 30 135 15 150 15 180 45 210 105 225 135 240 150 255 181 263 210 255 225 255 240 240 270 210 285 180 289 134 285 111 270 90 255 75 240 60 210 45 165 30
Polygon -13345367 true true 43 101 43 116 48 137 35 153 73 161 103 176 133 176 133 206 133 176 118 146 73 116 58 116
Polygon -13345367 true true 60 90 75 105 105 120 120 135 150 150 165 135 195 120 180 165 195 120 210 90 240 75 240 60 210 45 165 30 150 30 120 30 105 45 90 45 60 60
Polygon -1 true false 150 45 195 60 195 75 180 105 150 120 135 105 105 90 90 90 75 75 90 60 105 60 120 45

asteriod3
true
10
Polygon -13345367 true true 180 15 105 15 105 30 90 30 90 45 60 45 60 60 45 60 30 75 15 90 0 105 0 195 15 225 30 240 60 240 60 255 105 255 105 285 180 285 180 270 210 270 210 255 225 255 225 240 240 240 240 210 270 210 270 195 285 195 285 60 270 60 240 45 255 45 240 45 225 30 210 30
Polygon -1 true false 150 15 180 30 210 45 240 60 255 90 255 105 240 105 240 120 150 120 150 135 45 135 45 105 30 105 30 90 45 90 45 60 60 45 90 30 105 15
Polygon -7500403 true false 105 135 120 165 120 180 105 180 90 210 75 225 60 240 30 240 60 255 105 255 105 285 180 285 180 270 210 270 225 255 240 240 240 210 270 210 285 195 285 105 240 105 240 120 150 120 150 135

asteriod4
false
10
Polygon -13345367 true true 180 15 105 15 105 30 90 30 90 45 60 45 60 60 45 60 45 75 30 75 30 90 15 90 15 105 0 105 0 195 15 195 15 225 30 225 30 240 60 240 60 255 105 255 105 285 180 285 180 270 210 270 210 255 225 255 225 240 240 240 240 210 270 210 270 195 285 195 285 60 270 60 270 45 255 45 240 45 240 30 180 30
Polygon -1 true false 150 15 150 30 180 30 180 45 225 45 225 60 240 60 240 90 255 90 255 105 240 105 240 120 150 120 150 135 45 135 45 105 30 105 30 90 45 90 45 60 60 60 60 45 90 45 90 30 105 30 105 15
Polygon -7500403 true false 105 135 105 165 120 165 120 180 105 180 105 210 90 210 90 225 75 225 75 240 60 240 60 255 105 255 105 285 180 285 180 270 210 270 210 255 225 255 225 240 240 240 240 210 270 210 270 195 285 195 285 105 240 105 240 120 150 120 150 135

boss2
false
0
Polygon -1 true false 0 150 15 180 60 210 120 225 180 225 240 210 285 180 300 150 300 135 285 120 240 105 195 105 150 105 105 105 60 105 15 120 0 135
Polygon -16777216 false false 105 105 60 105 15 120 0 135 0 150 15 180 60 210 120 225 180 225 240 210 285 180 300 150 300 135 285 120 240 105 210 105
Polygon -7500403 true true 60 131 90 161 135 176 165 176 210 161 240 131 225 101 195 71 150 60 105 71 75 101
Circle -16777216 false false 255 135 30
Circle -16777216 false false 180 180 30
Circle -16777216 false false 90 180 30
Circle -16777216 false false 15 135 30
Circle -7500403 true true 15 135 30
Circle -7500403 true true 90 180 30
Circle -7500403 true true 180 180 30
Circle -7500403 true true 255 135 30
Polygon -16777216 false false 150 59 105 70 75 100 60 130 90 160 135 175 165 175 210 160 240 130 225 100 195 70

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

box 2
false
0
Polygon -7500403 true true 150 285 270 225 270 90 150 150
Polygon -13791810 true false 150 150 30 90 150 30 270 90
Polygon -13345367 true false 30 90 30 225 150 285 150 150

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

bullets-blue0
true
0
Rectangle -13791810 true false 120 30 180 270

bullets-blue1
true
0
Rectangle -13791810 true false 195 30 255 270
Rectangle -13791810 true false 45 30 105 270

bullets-blue2
true
0
Rectangle -13791810 true false 120 30 180 270
Rectangle -13791810 true false 240 30 300 270
Rectangle -13791810 true false 0 30 60 270

bullets-blue3
true
0
Rectangle -13791810 true false 30 0 270 300
Rectangle -11221820 true false 90 0 210 300

bullets-red1
true
0
Rectangle -2674135 true false 135 105 165 210
Polygon -2674135 true false 135 105 150 90 165 105 135 105

bullets-red2
true
0
Rectangle -2674135 true false 180 105 210 210
Rectangle -2674135 true false 90 105 120 210
Polygon -2674135 true false 90 105 105 90 120 105 90 105
Polygon -2674135 true false 180 105 195 90 210 105 180 105

bullets-violet0
true
0
Rectangle -7500403 true true 105 -15 195 315
Polygon -8630108 true false 195 -15 225 0 240 30 240 270 225 300 195 315
Polygon -8630108 true false 105 -15 75 0 60 30 60 270 75 300 105 315

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

enemy-assaultship
false
1
Polygon -6459832 true false 150 0 135 15 135 45 120 30 105 30 90 30 75 45 75 60 120 90 105 135 75 135 30 105 15 120 15 150 30 180 15 210 15 240 30 255 75 225 105 225 120 240 105 270 105 285 128 300 173 300 195 285 195 270 180 240 195 225 225 225 270 255 285 240 285 210 270 180 285 150 285 120 270 105 225 135 195 135 180 90 225 60 225 45 210 30 180 30 165 45 165 15
Polygon -7500403 true false 120 270 135 285 165 285 180 270
Polygon -7500403 true false 195 225 225 210 225 150 210 150 195 165
Polygon -7500403 true false 105 225 75 210 75 150 90 150 105 165
Polygon -16777216 false false 105 225 75 210 75 150 90 150 105 165
Line -16777216 false 165 45 165 75
Line -16777216 false 135 45 135 75
Polygon -16777216 false false 150 90 120 120 120 225 180 225 180 120
Circle -16777216 false false 135 120 30
Rectangle -16777216 false false 135 165 165 210
Polygon -16777216 false false 120 225 120 240 180 240 180 225
Polygon -16777216 false false 195 225 195 150 180 135 180 240
Polygon -16777216 false false 105 225 105 150 120 135 120 240
Polygon -16777216 false false 195 225 225 210 225 150 210 150 195 165
Polygon -16777216 false false 225 165 195 180 225 210
Polygon -16777216 false false 75 165 105 180 75 210
Line -16777216 false 195 135 210 150
Line -16777216 false 105 135 90 150
Polygon -16777216 false false 120 270 180 270 165 285 135 285
Polygon -7500403 false false 105 270 120 255 180 255 195 270 180 255 120 255
Line -16777216 false 120 240 135 255
Polygon -13791810 true false 270 105 285 105 300 120 300 150 285 180 300 210 300 240 285 255 270 255 285 240 285 210 270 180 285 150 285 120
Polygon -13791810 true false 30 105 15 105 0 120 0 150 15 180 0 210 0 240 15 255 30 255 15 240 15 210 30 180 15 150 15 120
Polygon -13791810 true false 195 30 210 30 225 45 225 60 210 70 210 45
Line -16777216 false 180 240 165 255
Line -16777216 false 150 90 150 0
Line -16777216 false 210 45 165 45
Line -16777216 false 195 270 180 255
Line -16777216 false 105 270 120 255
Line -16777216 false 120 255 180 255
Polygon -13791810 true false 180 90 165 75 150 90
Polygon -13791810 true false 120 90 135 75 150 90
Line -16777216 false 150 270 150 285
Polygon -2674135 true true 75 225 15 210 15 240 30 255
Polygon -2674135 true true 75 135 15 150 15 120 30 105
Polygon -2674135 true true 225 135 285 150 285 120 270 105
Polygon -2674135 true true 225 225 285 210 285 240 270 255
Polygon -13791810 true false 105 30 90 30 75 45 75 60 90 70 90 45
Line -16777216 false 90 45 135 45

enemy-bomber
true
10
Polygon -7500403 true false 151 0 121 45 106 45 31 135 1 150 -15 165 61 165 91 180 75 210 75 225 106 210 106 240 136 240 136 195 166 195 166 240 196 240 196 210 225 225 225 210 211 180 241 165 315 165 301 150 271 135 196 45 181 45
Rectangle -13345367 true true 105 210 135 240
Rectangle -13345367 true true 165 210 195 240
Polygon -13345367 true true 180 90 210 90 225 105 210 120 165 120
Polygon -13345367 true true 120 90 90 90 75 105 90 120 135 120
Polygon -13345367 true true 135 156 150 161 165 157 165 195 150 210 135 195
Polygon -13345367 true true 195 150 255 150 255 165 240 165 210 180
Polygon -13345367 true true 105 150 45 150 45 165 60 165 90 180
Circle -2674135 true false 135 60 30
Line -16777216 false 195 45 173 45
Polygon -16777216 false false 195 240 165 240 165 120 180 90 195 90 210 90 225 105 210 120 195 120
Polygon -16777216 false false 105 240 135 240 135 120 120 90 105 90 90 90 75 105 90 120 105 120
Line -16777216 false 270 135 255 150
Line -16777216 false 255 150 255 165
Line -16777216 false 255 150 195 150
Line -16777216 false 45 150 105 150
Line -16777216 false 30 135 45 150
Polygon -13345367 true true 121 60 136 45 166 45 181 60 166 60 151 51 136 60
Line -16777216 false 105 45 127 45
Line -16777216 false 195 120 165 120
Line -16777216 false 105 120 135 120
Line -16777216 false 210 180 195 150
Line -16777216 false 90 180 105 150
Line -16777216 false 174 102 150 90
Line -16777216 false 126 102 150 90
Line -16777216 false 165 157 150 161
Line -16777216 false 135 157 150 161
Line -16777216 false 45 150 45 165
Line -16777216 false 195 210 165 210
Line -16777216 false 105 210 135 210
Line -16777216 false 165 195 195 195
Line -16777216 false 135 195 105 195
Polygon -2674135 true false 196 240 203 256 203 270 181 300 159 270 159 255 166 240
Polygon -2674135 true false 105 240 98 256 98 270 120 300 142 270 142 255 135 240
Polygon -955883 true false 180 240 195 255 180 285 165 255
Polygon -955883 true false 120 240 105 255 120 285 135 255

enemy-boss-raiden
true
0
Polygon -7500403 true true 75 75 60 90 60 165 90 165 90 90 75 75
Polygon -7500403 true true 225 75 240 90 240 165 210 165 210 90 225 75
Line -7500403 true 60 165 90 165
Line -7500403 true 210 165 240 165
Line -7500403 true 135 15 135 45
Line -7500403 true 165 15 165 45
Line -7500403 true 150 30 135 45
Line -7500403 true 135 45 135 105
Line -7500403 true 135 105 165 105
Line -7500403 true 150 30 165 45
Line -7500403 true 165 45 165 105
Line -7500403 true 37 225 120 195
Line -7500403 true 180 195 261 225
Line -7500403 true 135 105 150 120
Line -7500403 true 165 105 150 120
Rectangle -7500403 false true 75 180 75 195
Line -7500403 true 75 180 75 210
Line -7500403 true 225 180 225 210
Line -7500403 true 135 120 135 150
Line -7500403 true 165 120 165 150
Polygon -7500403 true true 150 -15 135 15 135 45 150 30 165 45 165 15 150 -15
Polygon -7500403 true true 150 165 135 180 135 255 150 270 165 255 165 180 150 165
Polygon -1184463 true false 165 15 180 74 180 105 165 105
Polygon -1184463 true false 120 104 15 195 60 255 120 255 120 195 105 165 135 150 150 165 165 150 195 165 180 195 180 255 240 255 285 195 180 105 165 105 150 120 135 105
Polygon -13791810 true false 150 30 135 45 135 105 150 120 165 105 165 45
Polygon -16777216 true false 135 105 165 105 150 120 135 105
Polygon -2674135 true false 210 255 210 270 187 292 165 270 165 255 180 255 195 255 210 255
Polygon -13345367 true false 150 30 135 45 165 45 150 30
Polygon -955883 true false 165 105 195 120
Polygon -7500403 true true 60 255 120 255 120 195 37 226 60 255
Polygon -7500403 true true 240 255 180 255 180 195 263 226 240 255
Line -16777216 false 135 150 135 120
Line -16777216 false 165 150 165 120
Line -16777216 false 75 210 75 165
Line -16777216 false 225 210 225 165
Line -16777216 false 225 210 263 225
Line -16777216 false 75 210 37 225
Line -16777216 false 181 104 170 104
Polygon -1184463 true false 135 15 120 74 120 105 135 105
Polygon -2674135 true false 90 255 90 270 113 292 135 270 135 255 120 255 105 255 90 255
Line -16777216 false 119 104 130 104

enemy-bullet-gold
true
4
Polygon -1184463 true true 45 270 75 300 105 270
Rectangle -1184463 true true 195 30 255 270
Rectangle -1184463 true true 45 30 105 270
Polygon -1184463 true true 45 30 75 0 105 30
Polygon -1184463 true true 255 30 225 0 195 30
Polygon -1184463 true true 255 270 225 300 195 270

enemy-bullets-gold
true
0
Polygon -955883 true false 120 0 90 15 90 285 120 300 180 300 210 285 210 15 180 0
Rectangle -1184463 true false 120 0 180 300

enemy-fang
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

enemy-fighter1
true
3
Polygon -6459832 true true 150 -30 135 45 135 75 135 270 120 315 150 375 180 315 165 270 165 75 165 45
Rectangle -7500403 true false 90 15 105 60
Rectangle -7500403 true false 195 15 210 60
Polygon -2674135 true false 165 90 180 105 180 120 165 135
Polygon -2674135 true false 135 90 120 105 120 120 135 135
Polygon -6459832 true true 270 150 285 150 285 195 255 165 240 165
Polygon -6459832 true true 30 150 15 150 15 195 45 165 60 165
Rectangle -6459832 true true 45 90 120 120
Rectangle -6459832 true true 180 90 255 120
Polygon -6459832 true true 45 60 60 105 45 135 30 120 30 90
Polygon -6459832 true true 255 60 240 105 255 135 270 120 270 90
Polygon -13791810 true false 135 90 105 60 75 45 45 45 30 60 15 90 15 120 30 150 60 165 105 165 135 180 135 135 120 120 90 150 60 150 30 120 30 90 45 60 75 60 105 75 120 105
Polygon -13791810 true false 165 90 195 60 225 45 255 45 270 60 285 90 285 120 270 150 240 165 195 165 165 180 165 135 180 120 210 150 240 150 270 120 270 90 255 60 225 60 195 75 180 105
Polygon -7500403 true false 165 105 180 60 180 45 165 15
Polygon -7500403 true false 135 105 120 60 120 45 135 15
Polygon -7500403 true false 75 255 60 225
Polygon -7500403 true false 210 30 218 14 203 -30 187 15 195 30
Polygon -7500403 true false 90 30 82 14 97 -30 113 15 105 30
Polygon -6459832 true true 120 345 120 315 135 300 165 300 180 315 180 345
Polygon -11221820 true false 210 150 165 150 165 135 180 120
Polygon -11221820 true false 90 150 135 150 135 135 120 120

enemy-fighter2
true
1
Polygon -1 true false 150 0 120 15 105 45 90 135 75 150 15 165 0 150 0 225 75 225 90 285 135 300 135 240 150 225 165 240 165 285 165 300 210 285 225 225 300 225 300 150 285 165 225 150 210 135 195 45 180 15
Polygon -2674135 true true 150 15 120 30 105 60 90 150 30 165 15 165 75 150 90 135 105 45 120 15 150 0 180 15 195 45 210 135 225 150 285 165 270 165 210 150 195 60 180 30
Polygon -2674135 true true 285 210 180 210 165 180 165 225 300 225 300 150 285 165
Polygon -2674135 true true 15 210 120 210 135 180 135 225 0 225 0 150 15 165
Polygon -7500403 true false 75 225 90 285 135 300 135 240 150 225 165 240 165 300 210 285 225 225
Line -16777216 false 165 240 195 240
Line -16777216 false 195 240 210 255
Line -16777216 false 105 240 90 255
Line -16777216 false 135 240 105 240
Line -16777216 false 210 150 210 165
Line -16777216 false 210 165 180 165
Line -16777216 false 90 165 120 165
Line -16777216 false 90 150 90 165
Polygon -16777216 true false 150 30 135 45 120 150 180 150 165 45
Rectangle -1 true false 120 67 180 75
Rectangle -1 true false 120 113 180 120
Line -16777216 false 135 45 120 150
Line -16777216 false 165 45 180 150
Line -16777216 false 180 150 120 150
Line -16777216 false 135 45 150 30
Line -16777216 false 165 45 150 30

enemy-laser-gold
true
0
Rectangle -955883 true false 30 0 270 300
Rectangle -1184463 true false 90 0 210 300

enemy-missile-homing
true
13
Rectangle -1184463 true false 135 180 165 225
Polygon -1184463 true false 150 -10 40 235 150 190 260 235
Polygon -2064490 true true 150 -10 150 195 195 210
Polygon -2674135 true false 135 225 120 240 120 255 135 285 150 300 165 285 180 255 180 240 165 225 135 225
Polygon -955883 true false 135 225 135 255 150 285 165 255 165 225

enemy-pellet-green
false
0
Circle -7500403 true true 90 90 118
Polygon -10899396 true false 195 120 225 135 240 150 255 180 225 165 195 165 180 150
Polygon -10899396 true false 120 105 135 75 150 60 180 45 165 75 165 105 150 120
Polygon -10899396 true false 180 195 165 225 150 240 120 255 135 225 135 195 150 180
Polygon -10899396 true false 105 180 75 165 60 150 45 120 75 135 105 135 120 150

enemy-pellet-yellow
false
0
Circle -955883 true false 77 77 144
Circle -1184463 true false 81 95 124

enemy-suicidal
true
4
Polygon -7500403 true false 210 60 180 75 180 120 225 165 210 135
Polygon -7500403 true false 90 60 120 75 120 120 75 165 90 135
Rectangle -6459832 true false 75 90 120 105
Rectangle -6459832 true false 180 90 225 105
Polygon -7500403 true false 195 120 225 165 225 225 195 225
Polygon -7500403 true false 105 120 75 165 75 225 105 225
Rectangle -6459832 true false 195 195 225 210
Rectangle -6459832 true false 195 165 225 180
Rectangle -6459832 true false 75 195 105 210
Rectangle -6459832 true false 75 165 105 180
Rectangle -7500403 true false 240 60 255 120
Polygon -7500403 true false 45 120 60 120 60 60 45 60
Polygon -6459832 true false 90 45 60 105 30 120 0 165 0 195 15 225 45 255 75 225 75 165 90 135
Polygon -6459832 true false 210 45 240 105 270 120 300 165 300 195 285 225 255 255 225 225 225 165 210 135
Polygon -7500403 true false 105 120 120 60 150 0 180 60 195 120
Polygon -6459832 true false 135 120 150 60 165 120
Polygon -7500403 true false 120 120 105 135 105 225 120 240 180 240 195 225 195 135 180 120
Circle -2674135 true false 117 147 66
Line -16777216 false 195 120 195 225
Line -16777216 false 105 120 105 225
Line -16777216 false 150 60 165 120
Line -16777216 false 150 60 135 120
Line -16777216 false 195 120 225 165
Line -16777216 false 105 120 75 165
Line -16777216 false 225 165 225 225
Line -16777216 false 75 165 75 225
Line -16777216 false 105 120 195 120
Line -16777216 false 195 135 180 120
Line -16777216 false 105 135 120 120
Line -16777216 false 180 60 195 120
Line -16777216 false 120 60 105 120
Line -16777216 false 180 60 150 0
Line -16777216 false 120 60 150 0
Line -16777216 false 210 45 210 135
Line -16777216 false 90 45 90 135
Line -16777216 false 210 135 225 165
Line -16777216 false 90 135 75 165
Line -16777216 false 225 165 195 165
Line -16777216 false 75 165 105 165
Line -16777216 false 225 180 195 180
Line -16777216 false 225 195 195 195
Line -16777216 false 75 210 105 210
Line -16777216 false 225 210 195 210
Line -16777216 false 75 195 105 195
Line -16777216 false 75 180 105 180
Line -16777216 false 210 90 187 90
Line -16777216 false 210 105 191 105
Line -16777216 false 90 90 113 90
Line -16777216 false 90 105 109 105
Polygon -13345367 true false 225 225 240 240 240 255 210 285 180 255 180 240 195 225
Polygon -13345367 true false 75 225 60 240 60 255 90 285 120 255 120 240 105 225
Polygon -11221820 true false 210 225 225 240 210 285 195 240 210 225
Polygon -11221820 true false 90 225 75 240 90 285 105 240 90 225

enemy-suicidal2
true
4
Polygon -2674135 true false 90 240 75 255 75 270 97 300 120 270 120 255 105 240
Polygon -1184463 true true 150 0 105 30 105 45 0 150 0 180 30 180 75 150 75 210 120 210 120 180 150 195 180 180 180 210 225 210 225 150 270 180 300 180 300 150 195 45 195 30
Polygon -6459832 true false 150 0 105 30 105 60 120 60
Polygon -6459832 true false 150 0 195 30 195 60 180 60
Polygon -16777216 false false 150 0 180 60 195 60 195 30
Polygon -16777216 false false 150 0 120 60 105 60 105 30
Line -16777216 false 195 60 210 150
Line -16777216 false 105 60 90 150
Polygon -1184463 true true 150 0 120 60
Circle -2674135 true false 135 30 30
Rectangle -6459832 true false 138 75 161 156
Polygon -6459832 true false 197 74 255 120 300 165 300 180 270 180 210 150
Polygon -6459832 true false 103 74 45 120 0 165 0 180 30 180 90 150
Polygon -2674135 true false 210 240 225 255 225 270 203 300 180 270 180 255 195 240
Rectangle -7500403 true false 180 210 225 240
Rectangle -7500403 true false 75 210 120 240
Polygon -16777216 false false 105 150 90 150 75 157 75 210 120 210 120 165
Polygon -16777216 false false 195 150 210 150 225 157 225 210 180 210 180 165
Polygon -955883 true false 210 240 210 255 210 270 202 286 202 285 195 270 195 255 195 240
Polygon -955883 true false 90 240 90 255 90 270 98 286 98 285 105 270 105 255 105 240

explosion1
false
0
Circle -2674135 true false 105 105 90

explosion2
false
0
Circle -2674135 true false 60 60 180
Circle -955883 true false 105 105 90

explosion3
false
0
Circle -2674135 true false 15 15 270
Circle -955883 true false 45 45 210
Circle -1184463 true false 105 105 90

explosion4
false
0
Circle -2674135 true false 0 0 300
Circle -955883 true false 15 15 270
Circle -1184463 true false 45 45 210
Circle -16777216 true false 105 105 90

explosion5
false
0
Circle -2674135 true false 0 0 300
Circle -955883 true false 0 0 300
Circle -1184463 true false 15 15 270
Circle -16777216 true false 60 60 180

explosion6
false
0
Circle -955883 true false 0 0 300
Circle -1184463 true false 0 0 300
Circle -16777216 true false 30 30 240

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fire-blue
false
0
Polygon -13345367 true false 151 286 134 282 103 282 59 248 40 210 32 157 37 108 68 146 71 109 83 72 111 27 127 55 148 11 167 41 180 112 195 57 217 91 226 126 227 203 256 156 256 201 238 263 213 278 183 281
Polygon -13791810 true false 126 284 91 251 85 212 91 168 103 132 118 153 125 181 135 141 151 96 185 161 195 203 193 253 164 286
Polygon -11221820 true false 155 284 172 268 172 243 162 224 148 201 130 233 131 260 135 282

fire-red
false
0
Polygon -7500403 true true 151 286 134 282 103 282 59 248 40 210 32 157 37 108 68 146 71 109 83 72 111 27 127 55 148 11 167 41 180 112 195 57 217 91 226 126 227 203 256 156 256 201 238 263 213 278 183 281
Polygon -2674135 true false 126 284 91 251 85 212 91 168 103 132 118 153 125 181 135 141 151 96 185 161 195 203 193 253 164 286
Polygon -955883 true false 155 284 172 268 172 243 162 224 148 201 130 233 131 260 135 282

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

link
true
0
Line -7500403 true 150 0 150 300

link direction
true
0
Line -7500403 true 150 150 30 225
Line -7500403 true 150 150 270 225

missiles-homing
true
13
Rectangle -7500403 true false 135 180 165 225
Polygon -7500403 true false 150 -10 40 235 150 190 260 235
Polygon -2064490 true true 150 -10 150 195 195 210
Polygon -2674135 true false 135 225 120 240 120 255 135 285 150 300 165 285 180 255 180 240 165 225 135 225
Polygon -955883 true false 135 225 135 255 150 285 165 255 165 225

missiles-normal
true
13
Polygon -7500403 true false 150 0 180 15 180 45 180 240 120 240 120 45 120 15
Polygon -2674135 true false 120 240 120 255 135 285 150 300 165 285 180 255 180 240
Polygon -955883 true false 135 240 135 255 150 285 165 255 165 240
Rectangle -13345367 true false 120 45 180 60
Rectangle -2064490 true true 120 165 180 180
Polygon -7500403 true false 120 180 90 225 120 240 180 240 210 225 180 180

nothing
true
0

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

powerup-bomb
true
0
Circle -2674135 true false 88 13 124
Circle -13345367 true false 148 118 124
Circle -8630108 true false 28 118 124
Polygon -16777216 true false 106 60 106 75 106 90 106 105 106 120 106 135 106 150 106 165 106 180 106 195 136 195 158 194 178 190 196 180 207 165 205 165 206 165 207 165 207 150 196 135 166 120 189 109 196 94 192 81 181 73 160 64 131 60
Polygon -2674135 true false 120 75 120 105
Polygon -2674135 true false 125 78 125 108 142 108 155 107 165 103 171 93 166 84 156 80 143 78
Polygon -13345367 true false 124 130 124 176 147 176 173 173 182 164 182 159 182 155 181 147 176 142 172 138 164 133 148 130

powerup-max
false
1
Rectangle -7500403 true false 30 30 270 270
Rectangle -16777216 true false 75 75 225 225
Rectangle -13345367 true false 30 135 75 165
Rectangle -13345367 true false 225 135 270 165
Polygon -2674135 true true 90 90 90 210 120 210 120 180 120 165 165 165 195 150 210 135 210 120 195 105 165 90
Polygon -16777216 true false 120 105 120 150 150 150 180 135 180 120 150 105

powerup-missile-homing
false
1
Rectangle -7500403 true false 30 45 270 255
Rectangle -16777216 true false 75 75 225 225
Rectangle -7500403 true false 135 45 165 75
Rectangle -7500403 true false 135 225 165 255
Rectangle -7500403 true false 30 135 75 165
Rectangle -7500403 true false 225 135 270 165
Line -16777216 false 30 135 75 135
Line -16777216 false 75 165 30 165
Line -16777216 false 135 255 135 225
Line -16777216 false 165 255 165 225
Line -16777216 false 225 135 270 135
Line -16777216 false 225 165 270 165
Line -16777216 false 135 45 135 75
Line -16777216 false 165 45 165 75
Rectangle -7500403 true false 225 30 270 60
Rectangle -7500403 true false 30 30 75 60
Rectangle -7500403 true false 30 240 75 270
Rectangle -7500403 true false 225 240 270 270
Polygon -13840069 true false 90 90 120 90 120 135 180 135 180 90 210 90 210 210 180 210 180 165 120 165 120 210 90 210

powerup-missile-normal
false
1
Rectangle -7500403 true false 30 45 270 255
Rectangle -16777216 true false 75 75 225 225
Rectangle -7500403 true false 135 45 165 75
Rectangle -7500403 true false 135 225 165 255
Rectangle -7500403 true false 30 135 75 165
Rectangle -7500403 true false 225 135 270 165
Line -16777216 false 30 135 75 135
Line -16777216 false 75 165 30 165
Line -16777216 false 135 255 135 225
Line -16777216 false 165 255 165 225
Line -16777216 false 225 135 270 135
Line -16777216 false 225 165 270 165
Line -16777216 false 135 45 135 75
Line -16777216 false 165 45 165 75
Rectangle -7500403 true false 225 30 270 60
Rectangle -7500403 true false 30 30 75 60
Rectangle -7500403 true false 30 240 75 270
Rectangle -7500403 true false 225 240 270 270
Polygon -1184463 true false 90 90 90 210 120 210 120 150 145 180 155 180 180 150 180 210 210 210 210 90 180 90 150 135 120 90

powerup-weapon
false
1
Rectangle -7500403 true false 30 30 270 270
Rectangle -2674135 true true 75 75 225 225
Rectangle -2674135 true true 135 30 165 75
Rectangle -2674135 true true 135 225 165 270
Rectangle -2674135 true true 30 135 75 165
Rectangle -2674135 true true 225 135 270 165

raiden
true
1
Polygon -7500403 true false 75 75 60 90 60 165 90 165 90 90 75 75
Polygon -7500403 true false 225 75 240 90 240 165 210 165 210 90 225 75
Line -7500403 false 60 165 90 165
Line -7500403 false 210 165 240 165
Line -7500403 false 135 15 135 45
Line -7500403 false 165 15 165 45
Line -7500403 false 150 30 135 45
Line -7500403 false 135 45 135 105
Line -7500403 false 135 105 165 105
Line -7500403 false 150 30 165 45
Line -7500403 false 165 45 165 105
Line -7500403 false 37 225 120 195
Line -7500403 false 180 195 261 225
Line -7500403 false 135 105 150 120
Line -7500403 false 165 105 150 120
Rectangle -7500403 false false 75 180 75 195
Line -7500403 false 75 180 75 210
Line -7500403 false 225 180 225 210
Line -7500403 false 135 120 135 150
Line -7500403 false 165 120 165 150
Polygon -7500403 true false 150 -15 135 15 135 45 150 30 165 45 165 15 150 -15
Polygon -7500403 true false 150 165 135 180 135 255 150 270 165 255 165 180 150 165
Polygon -2674135 true true 165 15 180 74 180 105 165 105
Polygon -2674135 true true 120 104 15 195 60 255 120 255 120 195 105 165 135 150 150 165 165 150 195 165 180 195 180 255 240 255 285 195 180 105 165 105 150 120 135 105
Polygon -1184463 true false 150 30 135 45 135 105 150 120 165 105 165 45
Polygon -16777216 true false 135 105 165 105 150 120 135 105
Polygon -13840069 true false 210 255 210 270 187 292 165 270 165 255 180 255 195 255 210 255
Polygon -955883 true false 150 30 135 45 165 45 150 30
Polygon -955883 true false 165 105 195 120
Polygon -7500403 true false 60 255 120 255 120 195 37 226 60 255
Polygon -7500403 true false 240 255 180 255 180 195 263 226 240 255
Line -16777216 false 135 150 135 120
Line -16777216 false 165 150 165 120
Line -16777216 false 75 210 75 165
Line -16777216 false 225 210 225 165
Line -16777216 false 225 210 263 225
Line -16777216 false 75 210 37 225
Line -16777216 false 181 104 170 104
Polygon -2674135 true true 135 15 120 74 120 105 135 105
Polygon -13840069 true false 90 255 90 270 113 292 135 270 135 255 120 255 105 255 90 255
Line -16777216 false 119 104 130 104

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

ufo side
false
0
Polygon -1 true false 0 150 15 180 60 210 120 225 180 225 240 210 285 180 300 150 300 135 285 120 240 105 195 105 150 105 105 105 60 105 15 120 0 135
Polygon -16777216 false false 105 105 60 105 15 120 0 135 0 150 15 180 60 210 120 225 180 225 240 210 285 180 300 150 300 135 285 120 240 105 210 105
Polygon -7500403 true true 60 131 90 161 135 176 165 176 210 161 240 131 225 101 195 71 150 60 105 71 75 101
Circle -16777216 false false 255 135 30
Circle -16777216 false false 180 180 30
Circle -16777216 false false 90 180 30
Circle -16777216 false false 15 135 30
Circle -7500403 true true 15 135 30
Circle -7500403 true true 90 180 30
Circle -7500403 true true 180 180 30
Circle -7500403 true true 255 135 30
Polygon -16777216 false false 150 59 105 70 75 100 60 130 90 160 135 175 165 175 210 160 240 130 225 100 195 70

ufo top
false
0
Circle -1 true false 15 15 270
Circle -16777216 false false 15 15 270
Circle -7500403 true true 75 75 150
Circle -16777216 false false 75 75 150
Circle -7500403 true true 60 60 30
Circle -7500403 true true 135 30 30
Circle -7500403 true true 210 60 30
Circle -7500403 true true 240 135 30
Circle -7500403 true true 210 210 30
Circle -7500403 true true 135 240 30
Circle -7500403 true true 60 210 30
Circle -7500403 true true 30 135 30
Circle -16777216 false false 30 135 30
Circle -16777216 false false 60 210 30
Circle -16777216 false false 135 240 30
Circle -16777216 false false 210 210 30
Circle -16777216 false false 240 135 30
Circle -16777216 false false 210 60 30
Circle -16777216 false false 135 30 30
Circle -16777216 false false 60 60 30

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.4.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
