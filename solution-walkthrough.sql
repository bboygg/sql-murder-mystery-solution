-- This is the solution to follow up walkthough for sql murder mystery http://mystery.knightlab.com/walkthrough.html

-- Introduction
/*
A crime has taken place and the detective needs your help. The detective gave you the crime scene report, but you somehow lost it. You vaguely remember that the crime was a ​murder​ that occurred sometime on ​Jan.15, 2018​ and that it took place in ​SQL City​. Start by retrieving the corresponding crime scene report from the police department’s database.
*/



-- 1. Where is Witness?

SELECT description
FROM crime_scene_report
WHERE date = '20180115' AND type = 'murder' AND city = 'SQL City';

/*
Security footage shows that there were 2 witnesses. The first witness lives at the last house on "Northwestern Dr". The second witness, named Annabel, lives somewhere on "Franklin Ave".
*/

-- 2. Who is witness?

-- First witness

SELECT * FROM person
WHERE address_street_name = 'Northestern Dr'
ORDER BY address_number DESC LIMIT 1;

/* 
First Witness: Morty Schapiro | 14887 
*/

-- Second witness

SELECT * FROM person 
WHERE name like '%Annabel%'
AND address_street_name = 'Franklin Ave';

/*
Second Witness: Annabel Miller | 16371
*/

-- 3. What are interview transcripts for two witness.

SELECT person.name, interview.transcript
FROM person JOIN interview
ON person.id = interview.person_id
WHERE person.id = 14887 OR person.id = 16371;

/*
First Witness: I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". Only gold members have those bags. The man got into a car with a plate that included "H42W".

Second Witness: I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.
*/

-- 4. Let's find out the murder

SELECT person.name
FROM get_fit_now_member
JOIN person ON get_fit_now_member.person_id = person.id
JOIN drivers_license on person.license_id = drivers_license.id
WHERE membership_status = 'gold' 
AND get_fit_now_member.id LIKE '%48Z%'
AND plate_number LIKE '%H42W%';

/*
name: Jeremy Bowers
*/

-- 5. Check your solution

/*
When you enter the 'Jeremy Bowers', and run the program.
INSERT INTO solution VALUES (1, 'Insert the name of the person you found here');

SELECT value FROM solution;

Then, you will get 

Congrats, you found the murderer! But wait, there's more... If you think you're up for a challenge, try querying the interview transcript of the murderer to find the real villain behind this crime. If you feel especially confident in your SQL skills, try to complete this final step with no more than 2 queries. Use this same INSERT statement with your new suspect to check your answer.
*/

-- Further investigation

-- 6. 

