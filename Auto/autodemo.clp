
;;;======================================================
;;;   Automotive Expert System
;;;
;;;     This expert system diagnoses some simple
;;;     problems with a car.
;;;
;;;     CLIPS Version 6.3 Example
;;;
;;;     For use with the Auto Demo Example
;;;======================================================

;;; ***************************
;;; * DEFTEMPLATES & DEFFACTS *
;;; ***************************

(deftemplate UI-state
   (slot id (default-dynamic (gensym*)))
   (slot display)
   (slot relation-asserted (default none))
   (slot response (default none))
   (multislot valid-answers)
   (slot state (default middle)))
   
(deftemplate state-list
   (slot current)
   (multislot sequence))
  
(deffacts startup
   (state-list))
   
;;;****************
;;;* STARTUP RULE *
;;;****************

(defrule system-banner ""
  =>
  (assert (UI-state (display WelcomeMessage)
                    (relation-asserted start)
                    (state initial)
                    (valid-answers))))

;;;***************
;;;* QUERY RULES *
;;;***************



(defrule determine-genre ""
   (logical (start))
   =>
   (assert (UI-state (display StartQuestion)
                     (relation-asserted genre-is)
                     (response SciFi)
                     (valid-answers SciFi Fantasy Horror Slipstream))))
 
;;; Fantasy
(defrule urban-or-period ""
   (logical (genre-is Fantasy))
   =>
   (assert (UI-state (display UrbanOrPeriodQuestion)
                     (relation-asserted urban-or-period)
                     (response Urban)
                     (valid-answers Urban Period))))                    
 
(defrule likes-superheroes ""
   (logical (urban-or-period Urban))
   =>
   (assert (UI-state (display LikeSuperheroesQuestion)
                     (relation-asserted likes-superheroes)
                     (response Yes)
                     (valid-answers Yes No))))      
                     
 (defrule likes-mythology ""
   (logical (likes-superheroes No))
   =>
   (assert (UI-state (display MythologyQuestion)
                     (relation-asserted likes-mythology)
                     (response Yes)
                     (valid-answers Yes No))))  
                     
 (defrule likes-live-action ""
   (logical (likes-superheroes Yes))
   =>
   (assert (UI-state (display AnimatedOrLiveActionQuestion)
                     (relation-asserted animated-or-liveaction)
                     (response Live)
                     (valid-answers Live Toons)))) 
                      
 (defrule myths-or-legends ""
   (logical (urban-or-period Period))
   =>
   (assert (UI-state (display MythsQuestion)
                     (relation-asserted myths-or-legends)
                     (response Myths)
                     (valid-answers Myths Legends))))               
                     
(defrule girls-or-boys ""
   (logical (myths-or-legends Myths))
   =>
   (assert (UI-state (display DudesOrGirlsQuestion)
                     (relation-asserted girls-or-dudes)
                     (response Dudes)
                     (valid-answers Dudes Ladies))))   
                     
 (defrule animated-or-liveaction ""
   (logical (myths-or-legends Legends))
   =>
   (assert (UI-state (display AnimatedOrLiveActionQuestion)
                     (relation-asserted animated-or-liveaction)
                     (response Live)
                     (valid-answers Live Toons))))       
                     
  (defrule likes-nudity ""
   (logical (animated-or-liveaction Live))
   =>
   (assert (UI-state (display LikeNudityQuestion)
                     (relation-asserted likes-nudity)
                     (response Yes)
                     (valid-answers Yes No))))    
                        
 (defrule owns-gaemboy ""
   (logical (animated-or-liveaction Toons))
   =>
   (assert (UI-state (display GameboyQuestion)
                     (relation-asserted owns-gameboy)
                     (response Yes)
                     (valid-answers Yes No))))                                                                                                                       
;;; Slipstream
(defrule likes-slipstream-action ""
   (logical (genre-is Slipstream))
   =>
   (assert (UI-state (display ActionDramaQuestion)
                     (relation-asserted likes-slipstream-action)
                     (response Action)
                     (valid-answers Action Drama))))
                     
(defrule does-like-slipstream-action ""
   (logical (likes-slipstream-action Action))
   =>
   (assert (UI-state (display BiopunkSteampunkQuestion)
                     (relation-asserted biopunk-or-steampunk)
                     (response Biopunk)
                     (valid-answers Biopunk Steampunk))))
                     
(defrule doesnt-like-slipstream-action ""
   (logical (likes-slipstream-action Drama))
   =>
   (assert (UI-state (display SeenXFilesQuestion)
                     (relation-asserted have-you-seen-x-files)
                     (response Yes)
                     (valid-answers Yes No HatedIt))))
                     
(defrule does-like-slipstream-action ""
   (logical (likes-slipstream-action Action))
   =>
   (assert (UI-state (display BiopunkSteampunkQuestion)
                     (relation-asserted biopunk-or-steampunk)
                     (response Biopunk)
                     (valid-answers Biopunk Steampunk))))
                   
(defrule does-like-biopunk ""
   (logical (biopunk-or-steampunk Biopunk))
   =>
   (assert (UI-state (display WhedonCameronQuestion)
                     (relation-asserted whedon-or-cameron)
                     (response Whedon)
                     (valid-answers Whedon Cameron))))
               
(defrule hates-x-files ""
   (logical (have-you-seen-x-files HatedIt))
   =>
   (assert (UI-state (display OkWithBeingLetDownQuestion)
                     (relation-asserted ok-with-let-down)
                     (response Yes)
                     (valid-answers Yes No))))
                     
  (defrule not-okay-with-let-down ""
   (logical (have-you-seen-x-files HatedIt))
   =>
   (assert (UI-state (display FeelingAboutScottBakula)
                     (relation-asserted likes-scott-bakula)
                     (response Who)
                     (valid-answers Who ImAFan))))                   
                                           
;;; SciFi
(defrule likes-sci-fi-anthologies ""
   (logical (genre-is SciFi))
   =>
   (assert (UI-state (display AnthologiesQuestion)
                     (relation-asserted likes-sci-fi-anthologies)
                     (response No)
                     (valid-answers Yes No))))
                     
(defrule doesnt-like-sci-fi-anthologies ""
   (logical (likes-sci-fi-anthologies No))
   =>
   (assert (UI-state (display SpaceOperaQuestion)
                     (relation-asserted space-opera-or-home)
                     (response Home)
                     (valid-answers Stars Home))))
                     
(defrule wants-home ""
   (logical (space-opera-or-home Home))
   =>
   (assert (UI-state (display InvadersQuestion)
                     (relation-asserted friendlies-or-invaders)
                     (response Friends)
                     (valid-answers Friends Invaders))))

(defrule wants-invaders ""
  (logical (friendlies-or-invaders Invaders))
  =>
  (assert (UI-state (display AnimatedLiveActionQuestion)
  (relation-asserted animated-or-live-action)
  (response Live)
  (valid-answers Live Toons))))

(defrule wants-into-stars ""
  (logical (space-opera-or-home Stars))
  =>
  (assert (UI-state (display ComedyQuestion)
  (relation-asserted comedy)
  (response Yes)
  (valid-answers Yes No))))

(defrule wants-comedy ""
  (logical (comedy Yes))
  =>
  (assert (UI-state (display BritishAmericanQuestion)
  (relation-asserted british-or-american-comedy)
  (response UK)
  (valid-answers UK USA))))

(defrule doesnt-want-comedy ""
  (logical (comedy No))
  =>
  (assert (UI-state (display TrekkieQuestion)
  (relation-asserted trekkie-comedy)
  (response YepSeenAll)
  (valid-answers YepSeenAll Yes No))))

(defrule wants-trekkie-comedy ""
  (logical (trekkie-comedy Yes))
  =>
  (assert (UI-state (display WillWheatonQuestion)
  (relation-asserted will-wheaton)
  (response Woot)
  (valid-answers Woot NOOOO))))

(defrule doesnt-want-will-wheaton ""
  (logical (will-wheaton NOOOO))
  =>
  (assert (UI-state (display WhatStudyQuestion)
  (relation-asserted what-do-you-study)
  (response PoliSci)
  (valid-answers PoliSci WomensLib Sociology History))))

(defrule doesnt-want-trekkie-comedy ""
  (logical (trekkie-comedy No))
  =>
  (assert (UI-state (display WesternsQuestion)
  (relation-asserted likes-westerns)
  (response Yes)
  (valid-answers Yes No))))

(defrule doesnt-like-westerns ""
  (logical (likes-westerns No))
  =>
  (assert (UI-state (display GatewaysQuestion)
  (relation-asserted time-space-gateways)
  (response Yes)
  (valid-answers Yes No))))

(defrule doesnt-want-gateways ""
  (logical (time-space-gateways No))
  =>
  (assert (UI-state (display ClassicModernQuestion)
  (relation-asserted classic-or-modern)
  (response Modern)
  (valid-answers Classic Modern))))

(defrule wants-gateways ""
  (logical (time-space-gateways Yes))
  =>
  (assert (UI-state (display BritishAmericanQuestion)
  (relation-asserted british-or-american-gateways)
  (response USA)
  (valid-answers USA UK))))

;;; Horror
(defrule want-horror ""
  (logical (genre-is Horror))
  =>
  (assert (UI-state (display VampiresZombiesQuestion)
  (relation-asserted vampires-zombies)
  (response Zombies)
  (valid-answers Zombies Vampires Neither))))

(defrule wants-neither-zombies-nor-vampires ""
  (logical (vampires-zombies Neither))
  =>
  (assert (UI-state (display AnthologiesQuestion)
  (relation-asserted likes-horror-anthologies)
  (response No)
  (valid-answers Yes No))))

(defrule likes-horror-anthologies ""
  (logical (likes-horror-anthologies Yes))
  =>
  (assert (UI-state (display PsychologicalGoryQuestion)
  (relation-asserted psychological-gory)
  (response Psycho)
  (valid-answers Psycho Gory))))

(defrule wants-vampires ""
  (logical (vampires-zombies Vampires))
  =>
  (assert (UI-state (display HowOldQuestion)
  (relation-asserted is-this-old)
  (response LessThan16)
  (valid-answers LessThan16 MoreThan16))))

(defrule is-more-than-16-years-old ""
  (logical (is-this-old MoreThan16))
  =>
  (assert (UI-state (display NSFWQuestion)
  (relation-asserted sfw-nsfw)
  (response SFW)
  (valid-answers SFW NSFW))))

(defrule wants-sfw ""
  (logical (sfw-nsfw SFW))
  =>
  (assert (UI-state (display SeenBuffyQuestion)
  (relation-asserted seen-buffy)
  (response No)
  (valid-answers Yes No))))

(defrule wants-nsfw ""
  (logical (sfw-nsfw NSFW))
  =>
  (assert (UI-state (display BritishAmericanQuestion)
  (relation-asserted british-or-american-nsfw-horror)
  (response UK)
  (valid-answers UK USA))))

;;;****************
;;;* MOVIE SUGGESTION RULES *
;;;****************

(defrule likes-sci-fi-anthologies-conclusions ""
   (logical (likes-sci-fi-anthologies Yes))
   =>
   (assert (UI-state (display OuterLimitsMovie)
                     (state final))))

(defrule friendlies-conclusions ""
  (logical (friendlies-or-invaders Friends))
  =>
   (assert (UI-state (display AlienNationMovie)
                     (state final))))

(defrule live-conclusions ""
  (logical (animated-or-live-action Live))
  =>
  (assert (UI-state (display VMovie)
  (state final))))

(defrule toons-conclusions ""
  (logical (animated-or-live-action Toons))
  =>
  (assert (UI-state (display InvaderZimMovie)
  (state final))))

(defrule british-comedy-conclusions ""
  (logical (british-or-american-comedy UK))
  =>
  (assert (UI-state (display RedDwarfMovie)
  (state final))))

(defrule american-comedy-conclusions ""
  (logical (british-or-american-comedy USA))
  =>
  (assert (UI-state (display FuturamaMovie)
  (state final))))

(defrule seen-all-trekkie-comedies-conclusions ""
  (logical (trekkie-comedy YepSeenAll))
  =>
  (assert (UI-state (display EarthFinalConflictMovie)
  (state final))))

(defrule will-wheaton-woot-conclusions ""
  (logical (will-wheaton Woot))
  =>
  (assert (UI-state (display TheNextGenerationMovie)
  (state final))))

(defrule studies-poli-sci-conclusions ""
  (logical (what-do-you-study PoliSci))
  =>
  (assert (UI-state (display StarTrekDeepSpaceMineMovie)
  (state final))))

(defrule studies-womens-lib-conclusions ""
  (logical (what-do-you-study WomensLib))
  =>
  (assert (UI-state (display StarTrekVoyagerMovie)
  (state final))))
(defrule studies-sociology-conclusions ""
  (logical (what-do-you-study Sociology))
  =>
  (assert (UI-state (display StarTrekTheOriginalSeriesMovie)
  (state final))))
(defrule studies-history-conclusions ""
  (logical (what-do-you-study History))
  =>
  (assert (UI-state (display StarTrekEnterpriseMovie)
  (state final))))
(defrule likes-westerns-conclusions ""
  (logical (likes-westerns Yes))
  =>
  (assert (UI-state (display FireflyMovie)
  (state final))))
(defrule classic-conclusions ""
  (logical (classic-or-modern Classic))
  =>
  (assert (UI-state (display BattlestarGalacticaOldMovie)
  (state final))))
(defrule modern-conclusions ""
  (logical (classic-or-modern Modern))
  =>
  (assert (UI-state (display BattlestarGalacticaNewMovie)
  (state final))))
(defrule british-gateways-conclusions ""
  (logical (british-or-american-gateways UK))
  =>
  (assert (UI-state (display DoctorWhoMovie)
  (state final))))
(defrule american-gateways-conclusions ""
  (logical (british-or-american-gateways USA))
  =>
  (assert (UI-state (display StargateMovie)
  (state final))))
(defrule zombies-conclusions ""
  (logical (vampires-zombies Zombies))
  =>
  (assert (UI-state (display WalkingDeadMovie)
  (state final))))
(defrule no-horror-anthologies-conclusions ""
  (logical (likes-horror-anthologies No))
  =>
  (assert (UI-state (display CharmedMovie)
  (state final))))
(defrule psycho-horror-conclusions ""
  (logical (psychological-gory Psycho))
  =>
  (assert (UI-state (display TwilightZoneMovie)
  (state final))))
(defrule gory-horror-conclusions ""
  (logical (psychological-gory Gory))
  =>
  (assert (UI-state (display TalesFromTheCryptMovie)
  (state final))))
(defrule is-less-than-16-old-conclusions ""
  (logical (is-this-old LessThan16))
  =>
  (assert (UI-state (display VampireDiariesMovie)
  (state final))))
(defrule didnt-see-buffy-conclusions ""
  (logical (seen-buffy No))
  =>
  (assert (UI-state (display BuffyMovie)
  (state final))))
(defrule seen-buffy-conclusions ""
  (logical (seen-buffy Yes))
  =>
  (assert (UI-state (display AngelMovie)
  (state final))))
(defrule british-nsfw-horror-conclusions ""
  (logical (british-or-american-nsfw-horror UK))
  =>
  (assert (UI-state (display BeingHumanMovie)
  (state final))))
(defrule american-nsfw-horror-conclusions ""
  (logical (british-or-american-nsfw-horror USA))
  =>
  (assert (UI-state (display TrueBloodMovie)
  (state final))))
  
;;; slipstream
(defrule sanctuary-movie-conclusions ""
  (logical (biopunk-or-steampunk Steampunk))
  =>
  (assert (UI-state (display SanctuaryMovie)
  (state final))))
(defrule dark-angel-movie-conclusions ""
  (logical (whedon-or-cameron Cameron))
  =>
  (assert (UI-state (display DarkAngielMovie)
  (state final))))
(defrule doll-house-movie-conclusions ""
  (logical (whedon-or-cameron Whedon))
  =>
  (assert (UI-state (display DollhouseMovie)
  (state final))))
(defrule fringe-movie-conclusions ""
  (logical (have-you-seen-x-files Yes))
  =>
  (assert (UI-state (display FringeMovie)
  (state final))))
(defrule x-files-movie-conclusions ""
  (logical (have-you-seen-x-files No))
  =>
  (assert (UI-state (display XFilesMovie)
  (state final))))
(defrule warehouse-movie-conclusions ""
  (logical (likes-scott-bakula Who))
  =>
  (assert (UI-state (display Warehouse13Movie)
  (state final))))
(defrule quantum-leap-movie-conclusions ""
  (logical (likes-scott-bakula ImAFan))
  =>
  (assert (UI-state (display QuantumLeapMovie)
  (state final))))
(defrule lost-movie-conclusions ""
  (logical (ok-with-let-down Yes))
  =>
  (assert (UI-state (display LostMovie)
  (state final))))

;;; fantasy
(defrule the-tick-conclusions ""
  (logical (animated-or-liveaction Toons))
  =>
  (assert (UI-state (display TheTickMovie)
  (state final))))
  
(defrule smallville-conclusions ""
  (logical (animated-or-liveaction Live))
  =>
  (assert (UI-state (display SmallvilleMovie)
  (state final))))
  
(defrule headhunter-conclusions ""
  (logical (likes-mythology Yes))
  =>
  (assert (UI-state (display HeadhunterMovie)
  (state final))))

(defrule dresden-conclusions ""
  (logical (likes-mythology No))
  =>
  (assert (UI-state (display DresdenMovie)
  (state final))))

(defrule pokemon-conclusions ""
  (logical (owns-gameboy Yes))
  =>
  (assert (UI-state (display PokemonMovie)
  (state final))))

(defrule avatar-conclusions ""
  (logical (owns-gameboy No))
  =>
  (assert (UI-state (display AvatarMovie)
  (state final))))

(defrule legends-conclusions ""
  (logical (likes-nudity No))
  =>
  (assert (UI-state (display LegendOfSeekerMovie)
  (state final))))
  
(defrule spartacus-conclusions ""
  (logical (likes-nudity Yes))
  =>
  (assert (UI-state (display SpartacusMovie)
  (state final))))

(defrule hercules-conclusions ""
  (logical (girls-or-dudes Dudes))
  =>
  (assert (UI-state (display HerculesMovie)
  (state final))))
  
(defrule xena-conclusions ""
  (logical (girls-or-dudes Ladies))
  =>
  (assert (UI-state (display XenaMovie)
  (state final))))







































;;;*************************
;;;* GUI INTERACTION RULES *
;;;*************************

(defrule ask-question

   (declare (salience 5))
   
   (UI-state (id ?id))
   
   ?f <- (state-list (sequence $?s&:(not (member$ ?id ?s))))
             
   =>
   
   (modify ?f (current ?id)
              (sequence ?id ?s))
   
   (halt))

(defrule handle-next-no-change-none-middle-of-chain

   (declare (salience 10))
   
   ?f1 <- (next ?id)

   ?f2 <- (state-list (current ?id) (sequence $? ?nid ?id $?))
                      
   =>
      
   (retract ?f1)
   
   (modify ?f2 (current ?nid))
   
   (halt))

(defrule handle-next-response-none-end-of-chain

   (declare (salience 10))
   
   ?f <- (next ?id)

   (state-list (sequence ?id $?))
   
   (UI-state (id ?id)
             (relation-asserted ?relation))
                   
   =>
      
   (retract ?f)

   (assert (add-response ?id)))   

(defrule handle-next-no-change-middle-of-chain

   (declare (salience 10))
   
   ?f1 <- (next ?id ?response)

   ?f2 <- (state-list (current ?id) (sequence $? ?nid ?id $?))
     
   (UI-state (id ?id) (response ?response))
   
   =>
      
   (retract ?f1)
   
   (modify ?f2 (current ?nid))
   
   (halt))

(defrule handle-next-change-middle-of-chain

   (declare (salience 10))
   
   (next ?id ?response)

   ?f1 <- (state-list (current ?id) (sequence ?nid $?b ?id $?e))
     
   (UI-state (id ?id) (response ~?response))
   
   ?f2 <- (UI-state (id ?nid))
   
   =>
         
   (modify ?f1 (sequence ?b ?id ?e))
   
   (retract ?f2))
   
(defrule handle-next-response-end-of-chain

   (declare (salience 10))
   
   ?f1 <- (next ?id ?response)
   
   (state-list (sequence ?id $?))
   
   ?f2 <- (UI-state (id ?id)
                    (response ?expected)
                    (relation-asserted ?relation))
                
   =>
      
   (retract ?f1)

   (if (neq ?response ?expected)
      then
      (modify ?f2 (response ?response)))
      
   (assert (add-response ?id ?response)))   

(defrule handle-add-response

   (declare (salience 10))
   
   (logical (UI-state (id ?id)
                      (relation-asserted ?relation)))
   
   ?f1 <- (add-response ?id ?response)
                
   =>
      
   (str-assert (str-cat "(" ?relation " " ?response ")"))
   
   (retract ?f1))   

(defrule handle-add-response-none

   (declare (salience 10))
   
   (logical (UI-state (id ?id)
                      (relation-asserted ?relation)))
   
   ?f1 <- (add-response ?id)
                
   =>
      
   (str-assert (str-cat "(" ?relation ")"))
   
   (retract ?f1))   

(defrule handle-prev

   (declare (salience 10))
      
   ?f1 <- (prev ?id)
   
   ?f2 <- (state-list (sequence $?b ?id ?p $?e))
                
   =>
   
   (retract ?f1)
   
   (modify ?f2 (current ?p))
   
   (halt))
   
