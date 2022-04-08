(*
                         CS 51 Code Review 1
                Core Functional Programming -- Testing
*)                           

open Cr8 ;;

(* The Absbook module contains simple functions for unit testing:
   `unit_test` and `unit_test_within`. *)
open CS51Utils ;;
open Absbook ;;
open List ;;

let test_entity () =
    let other_ent : entity = new entity 5 2 10 in
    let my_ent = new entity 5 4 8 in
    unit_test (my_ent#get_health = 8) "base entity hp test";
    unit_test (FightSimulator.battle other_ent my_ent = my_ent) "base entity test";
    unit_test (my_ent#get_attack = 5) "base entity attack test";
    unit_test (my_ent#get_defense = 4) "base entity defense test";
    unit_test (my_ent#get_health = 4) "base entity hp test";

    my_ent#restore_health 1;
    unit_test (my_ent#get_health = 5) "base entity restore hp test";
    
    my_ent#restore_health 100;
    unit_test (my_ent#get_health = 8) "base entity restore hp over cap test";
;;


let test_weapons () =
    let my_weapon : weapon_type = new weapon 1 2 in
    unit_test (my_weapon#get_attack == 1) "get attack test";
    unit_test (my_weapon#get_defense == 2) "get defense test";

    let my_sword : weapon_type = new sword 3 in
    unit_test (my_sword#get_attack == 3) "sword attack test";
    unit_test (my_sword#get_defense == 0) "sword defense test";

    let my_shield : weapon_type = new shield 4 in
    unit_test (my_shield#get_attack == 0) "shield attack test";
    unit_test (my_shield#get_defense == 4) "shield defense test";
;;

let test_equippable_entity () =
    let other_ent : entity = new entity 5 2 10 in
    let my_equip_ent = new equippable_entity 5 2 10 in
    unit_test (my_equip_ent#get_health = 10) "base equippable hp test";
    unit_test (FightSimulator.battle other_ent (my_equip_ent :> entity_type) = other_ent) "base equippable test";
    unit_test (my_equip_ent#get_attack = 5) "base equippable attack test";
    unit_test (my_equip_ent#get_defense = 2) "base equippable defense test";

    let other_ent : entity = new entity 5 2 10 in
    let my_equip_ent = new equippable_entity 5 2 10 in
    let my_weapon = new weapon 3 3 in
    my_equip_ent#equip my_weapon;
    unit_test (FightSimulator.battle other_ent (my_equip_ent :> entity_type) = (my_equip_ent :> entity_type)) "equipped equippable test";
    unit_test (my_equip_ent#get_health = 10) "equipped equippable hp test";
    unit_test (my_equip_ent#get_attack = 8) "equipped equippable attack test";
    unit_test (my_equip_ent#get_defense = 5) "equipped equippable defense test";
;;


let test_all () = 
    test_entity ();
    test_weapons ();
    test_equippable_entity ()
;;


let _ = test_all () ;;
