# FPGA-based-Ultra-Traffic-Light-Controller
Ultra Traffic Light Controller
initially traffic light controller has three sides (A, B, C) with one sensor embedded on side C to detect the vehicles and which can only be turn on if there is car waiting on Southeast. Side A has two traffic lights for North and South. Side A North augmented with a left turn signal that goes from North to East or to side C which adds one more traffic light.

Side B has two traffic lights for East and West. We have total six traffic lights for the initial problem. 

The sequencing of the lights is Green arrow, Yellow arrow, Green light, Yellow light and so on. The left turn needs to be accounted in all cycles for side A. Side C must always be red if there is no car waiting. Another condition from specification is that Car travelling from north to south on side A should have green light while turn arrow is lit up and all other directions must see a red light.

The modified version of the traffic light controller represented by adding another left turn on side A for traffic going from south to west. Also, we need to add two more left turns on side B for east and west which can only turn green if there is a car present. 

In this scenario, we are adding another traffic light to side A left turn and Two more traffic lights for side B left turns. Two sensors are embedded on side B left turns which can detect if any car is waiting. Our final system results with nine traffic lights with two sensors embedded on side B left turns and one sensor on side C.

A timer has been designed to generate two timing sequence that is associated with different traffic light transition. Long timer assigned to Green lights, Red lights and some Green lights with Yellow arrows combination. Short timer assigned to Green arrows, Yellow arrows, Yellow lights. Timer will count clock pulses and lit up lights for applicable amount of time. 
For this project, we are using Short timer as 2 seconds and Long timer as 8 seconds.

According to the Specification, first question arise that what is the impact of adding one more left turn on side A for south to west and how it will satisfy the sequence of lights and condition that left turn needs to be lit up while traffic heading toward South to North?  This results in traffic delay since according to sequence we have first Green arrow, yellow arrow, green light and yellow light so whenever there is a left turn ON on side A north and all other directions are red that adds more time(approximately  24 clock cycles for TS=2s and TL=8s) just to cross intersection from south to north and (18 clock cycles) to take left turn from south to west.

To satisfy the condition and reduce time delay for traffic, we can make two left turn green of side A at the same time for short timer and after yellow for short timer. After this signal we can make green lights on both traffic lights north and south with left turn arrow lit up yellow so if a car still wants to take a left turn then it must take it with caution of vehicles crossing from straight direction (north to south and south to north)  for long timer and after, All the traffic lights on side A becomes yellow for short timer and sequence will go to side B.

The above solution can also be applying to the side B but with a slight change.  If there is no car waiting than traffic signal sequence will skips the side B left turns and move control to side B traffic lights. 

Since there is a condition available that arrows should only be turn on if there is a car present. To satisfy this condition, we can add yellow arrows with Green Lights for long timer and Yellow lights for short timer. So, we are not making left turn signal green, but instead yellow arrows if a car wants to take a turn than they must take it with caution. If a sensor detects a car waiting on west or east turn arrows then light sequence will start from two left turn will become Green for Short timer and after, they will become yellow for short timer and goes to red.

Side C embedded with a sensor that detect vehicles coming from southeast. The whole lights sequencing will ignore side C traffic light and move control to initial state which is side A. If there is a car waiting on side C then side C will become Green for long timer and side C will become yellow light for short timer. We are designing the Traffic lights on VGA Controller.
