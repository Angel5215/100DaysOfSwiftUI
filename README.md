
# 100DaysOfSwiftUI

## Wrap-up Challenge. Day 94

1. Change project 8 ([Moonshot](Moonshot)) so that when you scroll down in `MissionView` the mission badge image gets smaller. It doesn’t need to shrink away to nothing – going down to maybe 80% is fine.

2. Change project 5 ([Word Scramble](WordScramble)) so that words towards the bottom of the list slide in from the right as you scroll. Ideally at least the top 8-10 words should all be positioned normally, but after that they should be offset increasingly to the right.

3. For a real challenge make the letter count images in project 5 change color as you scroll. For the best effect, you should create colors using the `Color(red:green:blue:)` initializer, feeding in values for whichever of red, green, and blue you want to modify. The values to input can be figured out using the row’s current position divided by maximum position, which should give you values in the range 0 to 1.

## Images

<p align="center"><img src="img/run-example.gif" height="600px"/></p>